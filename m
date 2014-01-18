From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 18 Jan 2014 08:14:59 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <CAPQV+nO=Xe=z669QxCJSerrm-xP0b=WtyPveyh2uTcM2B3i5KQ@mail.gmail.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voamU5hc7uC5MTOA7OtYuqpsis7cTX3sx0UrmpdZx7_TpzA@mail.gmail.com>
 <CANruHrS1D8d_y43xa-2OGduTvAGWfdeY1REVzZ6YJHjhzLg+hw@mail.gmail.com>
 <346894265.CPBN0v9Elj@flatron>
 <CAD=FV=UBz0ShCOj2ztBmf1Tge+BoQ_QUByAKj=W=mEgE4dE94Q@mail.gmail.com>
 <CAPQV+nO=Xe=z669QxCJSerrm-xP0b=WtyPveyh2uTcM2B3i5KQ@mail.gmail.com>
Message-ID: <CAM4voanbMd4LM0Ox=FnZo4cW-0rMB62Yc1hxHgkVfd6p4aDjJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have observed on an average 2 failures in 100 S2R cycles even with
the mainline kernel on SMDK5420. The system resumes fine after an
aborted suspend. I have isolated the problem to the MCT_L0 interrupt.
On disabling the forwarding of just this interrupt from the
distributor there are no failures for over 1000 cycles.
Code exists to mask the system timer wake-up and post-resume in a
failed case the WAKEUP_STAT register does not show the timer having
woken up the system (I am checking this quite early post-resume).
On suspending the system, the non-boot cores would free their timer
irqs (in the MCT driver) but not the boot core. So, there is a
possibility that L0 irq might wake the system if it races with
suspend. Is this a possibility ? Please correct me if my understanding
is wrong.

Abhilash
On Sat, Jan 11, 2014 at 1:06 AM, Jonathan Kliegman <kliegs@chromium.org> wrote:
>
>
>
> On Fri, Dec 20, 2013 at 8:15 PM, Doug Anderson <dianders@chromium.org>
> wrote:
>>
>> Tomasz,
>>
>> On Fri, Dec 20, 2013 at 1:19 PM, Tomasz Figa <tomasz.figa@gmail.com>
>> wrote:
>> > Hi,
>> >
>> > On Friday 20 of December 2013 15:56:38 sunil joshi wrote:
>> >> Hi Abhilash,
>> >> I saw another patch in chrome tree ..by Andrew Bresticker
>> >> which may be relevant here ..
>> >>
>> >> Just wondering if you missed adding this ? or this is not needed ?
>> >> You did not face any issue in getting core to suspend ?
>> >>
>> >>
>> >> ------------------------------------------------------------------------------------------
>> >> commit 95402d816b9f1a05ce633f7ff64b4c939c142482
>> >> Author: Andrew Bresticker <abrestic@chromium.org>
>> >> Date:   Mon Jul 15 13:14:36 2013 -0700
>> >>
>> >>     arm: exynos: disable all interrupts on Exynos5420 before suspend
>> >>
>> >>     Disable all interrupts from the GIC before entering suspend on
>> >>     Exynos5420 as is done on Exynos5250.  If interrupts are enabled, we
>> >>     may receive an interrupt after entering WFI but before the PMU has
>> >>     suspended the system, causing suspend to fail.
>> >>
>> >>     BUG=chrome-os-partner:20523
>> >>     TEST=Run suspend_stress_test on Pit and observe that entering
>> >> suspend
>> >>     no longer occasionally fails with the "Failed to suspend the
>> >> system"
>> >>     error in exynos_cpu_suspend().
>> >
>> > A question about this for Chromium and LSI guys:
>> >
>> > If you find out that there is already a pending interrupt before you
>> > enter
>> > the sleep mode, isn't it more reasonable to cancel the process ASAP and
>> > handle the event instead of entering the sleep just to leave it?
>> >
>> > I believe this should be both more efficient with respect to power usage
>> > and latency, because sleep-wakeup transition takes time and power.
>> >
>> > Do you have any reason to think the opposite?
>>
>> I'm not actually sure I know every last detail, but...
>>
>> From what I remember on 5250 there was some type of mystery interrupt
>> that was hitting in the system but that wasn't identifiable as any
>> particular interrupt source.  I think that this was an attempt to deal
>> with that with a heavy hammer.  I don't think it was a very elegant
>> solution and it would be nice to do better.
>>
>> Ah, here's the original CL:
>> <https://chromium-review.googlesource.com/#/c/34541/>.  ...as you can
>> see I wasn't super happy about it at the time but was OK with it going
>> in since it was very late in the Chromebook release cycle and we
>> needed suspend/resume to be reliable.
>>
>> Another fairly questionable CL:
>> <https://chromium-review.googlesource.com/#/c/37991/>
>>
>> It would be super great if we could get suspend/resume reliable
>> upstream without those hacks.
>
> My recollection is the first CL (34541 that I put in) didn't actually do
> anything itself, but had enough of a change in the timings that it made
> behavior better.  The second CL (37991) is definitely a hack that covered up
> the issue and I don't think anyone was happy with but given the timing it
> was the best alternative.
>
> I did a lot of debugging and don't believe I ever found an actual interrupt
> firing that caused this.  I'm pretty sure this was related to power settings
> and it just failing to enter the suspend state.
>>
>>
>> -Doug
>
>

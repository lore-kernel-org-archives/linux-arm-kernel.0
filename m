From: zyy@motorola.com (Yuanyuan ZHONG)
Date: Thu, 10 Oct 2013 11:00:18 -0500
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when forcing
 reload
In-Reply-To: <CAFUV4K3dsVDtHhQtuZ6yEQHxxHXaa9LODBZuGFipjAKumF4abQ@mail.gmail.com>
References: <1380751187-11257-1-git-send-email-zyy@motorola.com>
 <20131002221123.GC12758@n2100.arm.linux.org.uk>
 <CAFUV4K3dsVDtHhQtuZ6yEQHxxHXaa9LODBZuGFipjAKumF4abQ@mail.gmail.com>
Message-ID: <CAFUV4K1CkzGZVEwkXGX38jG0HxerqQq--d-qFiqF9J6wi88xYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, et al

If there is no further comments, I'll submit it to patch system.
Thanks.

On Wed, Oct 2, 2013 at 5:21 PM, Yuanyuan ZHONG <zyy@motorola.com> wrote:
> On Wed, Oct 2, 2013 at 5:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Oct 02, 2013 at 04:59:47PM -0500, Yuanyuan Zhong wrote:
>>> The current thread trying to clear the held vfp state may not be
>>> the owner of hw state. For example,
>>>       Core0                   Core1
>>>                               Thread1 uses VFP.
>>>                                 Thread1 vfpstate.hard.cpu = 1.
>>>                                 vfp_current_hw_state[1] points to Thread1
>>>                                   vfpstate.
>>>       Going to suspend.
>>>       Freeze Thread1.
>>>                               Thread1 is switched out.
>>>                               VFP HW registers saved to Thread1 vfpstate.
>>
>> Correct so far.  At this point:
>>
>>                                 vfp_current_hw_state[1] = &thread1->vfpstate;
>>                                 thread1->vfpstate.hard.cpu = 1;
>>
>>>       Core0 disables Core1.
>>>                               Stopper thread calls vfp_force_reload().
>>>                               Stopper thread vfpstate.hard.cpu = NR_CPUS.
>>
>> Correct, except there's another part to this.  vfp_state_in_hw() returns
>> true here, since thread1->vfpstate.hard.cpu is the dying CPU (CPU 1), and
>> vfp_current_hw_state[1] is &thread1->vfpstate.  So we also do this:
>>
>>                                 clear FPEXC_EN
>>                                 vfp_current_hw_state[1] = NULL;
>>
> vfp_state_in_hw() returns false. It's checking current_thread_info()
> which is the stopper thread migration/1, not thread1.
>>>                               ...
>>>                               (No PM notifier for non-idle path. So
>>>                                 vfp_pm_suspend() is NOT called on Core1.)
>>>                               ...
>>>                               Core1 is off and VFP HW registers are lost.
>>>       ...
>>>       Core0 enables Core1.
>>>       Core0 thaw Thread1.
>>>       Thread1 migrate to Core1
>>>         before using VFP.
>>>                               Thread1 starts using VFP.
>>>                               Now we have vfp_current_hw_state[1] points
>>>                                 to Thread1 vfpstate. And Thread1 has
>>>                                 vfpstate.hard.cpu = 1.
>>
>> No.  With my above correction:
>>                                 vfp_current_hw_state[1] = NULL
>>
>> and that forces a reload of the saved context.

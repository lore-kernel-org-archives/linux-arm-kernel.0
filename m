From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Jun 2014 13:37:21 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
Message-ID: <20140606203721.GA10422@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding Nico since he was involved in the original reviews]

Hi,

On Fri, Jun 06, 2014 at 11:20:56AM -0700, Doug Anderson wrote:
> Abhilash,
> 
> 
> 
> On Fri, Jun 6, 2014 at 11:12 AM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
> > Hi Doug,
> >
> > On Fri, Jun 6, 2014 at 11:32 PM, Doug Anderson <dianders@google.com> wrote:
> >> Abhilash,
> >>
> >> On Fri, Jun 6, 2014 at 10:36 AM, Abhilash Kesavan
> >> <kesavan.abhilash@gmail.com> wrote:
> >>> Hi Doug,
> >>>
> >>> The first change in the kernel (clearing an iRAM location) is needed
> >>> because of an unnecessary change that we are carrying in the Chrome
> >>> U-boot. There is no reason for us to have the workaround in the
> >>> mainline kernel. Rather, we should remove the check from our u-boot.
> >>> However AFAIR a clean-up patch that I had posted internally was not
> >>> accepted as we had frozen the SPL at the time.
> >>
> >> Ah, is that this one, or a different one?
> >>
> >> https://chromium-review.googlesource.com/#/c/66049/
> > Yes, this along with a kernel side change.
> 
> Can we safely take this one without the kernel-side one?
> 
> 
> >> If we land that patch now it won't help since nobody is going to be
> >> updating their read-only firmware.  We'll need to put code somewhere
> >> that fixes it.
> > We just carry the workaround fix locally until we migrate to mainline
> > u-boot for 5420 where the unnecessay check will not be present.
> 
> I think there are people out there who want to run a mainline kernel
> on existing Chromebook 2 hardware and don't want to rewrite their RO
> firmware.  We need a solution for those people.

Agree. The answer to this is most definitely _not_ "install mainline u-boot".
The upstream kernel needs to be able to boot with the firmware that was shipped
on the device.

In this case it shouldn't be controversial to add this. What we need is
a one-time boot-time setup, not runtime so cpuidle shouldn't be a factor
at that time. The earlier reservations were about runtime changes and this is
quite different.

> >>> The second change is to enable snoops for boot cluster. Internally, we
> >>> were disabling the snoops for both the clusters at power off and
> >>> enabling it in power_up_setup and power_up. However, I dropped the
> >>> approach due to problems pointed out by Nicolas here
> >>> http://www.spinics.net/lists/arm-kernel/msg324091.html related to
> >>> cpuidle. Hence, we turn it on at the u-boot.
> >>
> >> I think I followed all that.  What you're saying is that our kernel
> >> dynamically enables and disables snoops as needed, but Nicolas pointed
> >> out that it was unsafe (though apparently we're not seeing problems in
> >> our usage).
> > We did not see any problems as CPUIdle was one of the problematic
> > scenarios which we have not got enabled.
> 
> Ah, makes sense!
> 
> 
> 
> I'm still trying to figure out all of this code, but we'll also need
> to make sure whatever solution we come up with handles suspend/resume
> properly.  I know SRAM is lost across suspend/resume so someone
> (either the SPL from read-only memory or the kernel) must be
> recreating the SRAM structures after S2R...


-Olof

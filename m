From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Jun 2014 14:01:26 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
Message-ID: <20140606210126.GA10219@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 02:16:27AM +0530, Abhilash Kesavan wrote:
> Hi Olof,
> 
> On Sat, Jun 7, 2014 at 2:07 AM, Olof Johansson <olof@lixom.net> wrote:
> > [Adding Nico since he was involved in the original reviews]
> >
> > Hi,
> >
> > On Fri, Jun 06, 2014 at 11:20:56AM -0700, Doug Anderson wrote:
> >> Abhilash,
> >>
> >>
> >>
> >> On Fri, Jun 6, 2014 at 11:12 AM, Abhilash Kesavan
> >> <kesavan.abhilash@gmail.com> wrote:
> >> > Hi Doug,
> >> >
> >> > On Fri, Jun 6, 2014 at 11:32 PM, Doug Anderson <dianders@google.com> wrote:
> >> >> Abhilash,
> >> >>
> >> >> On Fri, Jun 6, 2014 at 10:36 AM, Abhilash Kesavan
> >> >> <kesavan.abhilash@gmail.com> wrote:
> >> >>> Hi Doug,
> >> >>>
> >> >>> The first change in the kernel (clearing an iRAM location) is needed
> >> >>> because of an unnecessary change that we are carrying in the Chrome
> >> >>> U-boot. There is no reason for us to have the workaround in the
> >> >>> mainline kernel. Rather, we should remove the check from our u-boot.
> >> >>> However AFAIR a clean-up patch that I had posted internally was not
> >> >>> accepted as we had frozen the SPL at the time.
> >> >>
> >> >> Ah, is that this one, or a different one?
> >> >>
> >> >> https://chromium-review.googlesource.com/#/c/66049/
> >> > Yes, this along with a kernel side change.
> >>
> >> Can we safely take this one without the kernel-side one?
> >>
> >>
> >> >> If we land that patch now it won't help since nobody is going to be
> >> >> updating their read-only firmware.  We'll need to put code somewhere
> >> >> that fixes it.
> >> > We just carry the workaround fix locally until we migrate to mainline
> >> > u-boot for 5420 where the unnecessay check will not be present.
> >>
> >> I think there are people out there who want to run a mainline kernel
> >> on existing Chromebook 2 hardware and don't want to rewrite their RO
> >> firmware.  We need a solution for those people.
> >
> > Agree. The answer to this is most definitely _not_ "install mainline u-boot".
> > The upstream kernel needs to be able to boot with the firmware that was shipped
> > on the device.
>
> My answer is not "use mainline u-boot" primarily because I am not sure
> mainline u-boot actually works on 5420 :).

And I'm saying that's not the answer primarily because we should never require
people to update their firmware to get a usable linux system.

> My answer is keep a patch
> locally (or make a trivial change to the bootcmd) for people who would
> like to use an upstream kernel with the firmware on the device. Once
> we do have a working mainline u-boot, that can then be used by the
> interested parties.

And I am strongly NAK:ing both of those approaches. We should not require
a single out-of-tree patch because that means we have failed to make a useful
kernel for people. And it should never, ever, be a requirement for people to
reflash and risk bricking their device just to run mainline linux on it. It's
an artificial barrier of entry with high risk, and we'll be worse off for
adding it. Same for out-of-tree patches.

> > In this case it shouldn't be controversial to add this. What we need is
> > a one-time boot-time setup, not runtime so cpuidle shouldn't be a factor
> > at that time. The earlier reservations were about runtime changes and this is
> > quite different.
> I think there is some confusion here, the clearing of the iRAM
> location is what I have been pushing against. It has got nothing to do
> cpuidle. If it were to be done then  it would be a one time setup and
> I could quite easily do it in mcpm_init.

iRAM is covered on Doug's sub-thread, and I think his approach looks promising.
So, it seems like we have a solution both to enable the CCI port and to avoid
clearing iram -- we should be set?


-Olof

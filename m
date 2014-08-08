From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Aug 2014 14:17:53 -0400 (EDT)
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <7hlhqy3lkd.fsf@paris.lan>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
 <CAOesGMi0RUbz4BSnmR92dEk3fWgN=hnENSdi55VeCXdcHLRLJQ@mail.gmail.com>
 <7hlhqy3lkd.fsf@paris.lan>
Message-ID: <alpine.LFD.2.11.1408081409260.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Kevin Hilman wrote:

> Olof Johansson <olof@lixom.net> writes:
> 
> > On Fri, Aug 1, 2014 at 4:01 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> >> On Fri, 2014-08-01 at 11:26 +0100, Sudeep Holla wrote:
> >>>
> >>> On 22/07/14 19:01, Olof Johansson wrote:
> >>> > This is a major refresh of the multi_v7_defconfig:
> >>> >
> >>> > - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
> >>> >   * Enable big.LITTLE
> >>> >   * MCPM
> >>> [...]
> >>
> >>> > +CONFIG_BIG_LITTLE=y
> >>> > +CONFIG_BL_SWITCHER=y
> >>>
> >>> IIUC, this will enable switcher code by default. I am not sure if this
> >>> is intentional ? E.g.: After this I can have only 2 active cpus instead
> >>> of 5 on my Vexpress TC2 platform.
> >>>
> >>> IMO we can keep this enabled by default in the build, but disabled
> >>> by default on boot.
> >>
> >> TC2 has a big.LITTLE processor and the switcher is the only mainlined
> >> way of making any kind of proper use of big.LITTLE, so why not have it
> >> enabled by default?
> >
> > +1.
> >
> 
> I disagree.
> 
> The bL switcher is a stopgap used on products (which have their own
> defconfigs anyways) but upstream development is focused on HMP (or
> whatever the current buzzword is for the kernel directly scheduling both
> big and little cores.)  
> 
> So IMO, for upstream coverage, we should *not* be enabling the switcher
> but should be letting the scheduler directly manage all CPUs.

I agree... in principle.  In practice the upstream scheduler has no 
notion of asymmetric processing yet, and probably still for a while to 
come.  Once the scheduler does a semi-descent job at it then the 
switcher should default to being disabled.

> At least on Exynos, with MCPM support merged, the kernel can boot up all
> the CPUs and directly manage them.

"Managing" them is still somewhat overstated.  Yes, the scheduler does 
_see_ them but it still can't manage them properly.  At best you'll get 
somewhat random system performance, at worst it'll be completely 
inefficient.  In most cases the switcher will give you much better 
behavior for the time being.


Nicolas

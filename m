From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 08 Mar 2016 01:50:50 +0100
Subject: [GIT PULL 1/3] rockchip soc changes for 4.5
In-Reply-To: <CAD=FV=Wr0f6d=tJCCfQa59pNDe1PEj44hdqCKFKricYdv7D+0w@mail.gmail.com>
References: <1936935.FVZdWRYuBf@diego> <2125152.VIQO6FufKf@diego>
 <CAD=FV=Wr0f6d=tJCCfQa59pNDe1PEj44hdqCKFKricYdv7D+0w@mail.gmail.com>
Message-ID: <3859490.BDucKaOEBr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 7. M?rz 2016, 16:46:04 schrieb Doug Anderson:
> On Fri, Dec 11, 2015 at 4:57 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Arnd,
> > 
> > Am Samstag, 12. Dezember 2015, 01:30:17 schrieb Arnd Bergmann:
> >> On Saturday 05 December 2015 01:53:38 Heiko St?bner wrote:
> >> > SMP special case for the rk3036 and making sure the arch-timer
> >> > supply is enabled, similar to the rk3288.
> >> 
> >> That is a rather ugly hack, I'd prefer if this could be done cleaner
> >> rather than duplicated into another place.
> > 
> > I do agree that it is rather ugly :-) .
> > 
> > The general opinion seems to be, that firmware is supposed to make sure
> > this timer is enabled and at the time when it got introduced the
> > consensus was to not hack up the arch-timer to facilitate this and "just"
> > put it into the soc code for the affected cpu.
> > 
> > It seems like the really new rk3228 (quad-core A7 and using psci now)
> > actually gets this right now, in having its firmware taking care of this.
> > So it looks like this hopefully won't be needed even for future arm32
> > socs.
> > 
> > I guess I should look at what the new and shiny mainline uboot support
> > does
> > for this, but I do think it might actually do it right as well.
> > 
> > So this is really only a hack for flaky vendor-bootloaders.
> > 
> > 
> > Which brings me to ...
> > 
> >> Sorry for not seeing this earlier. Can you replace the hardcoded
> >> RK3036_TIMER_PHYS and RK3288_TIMER6_7_PHYS constants with a DT
> >> lookup, to make it somewhat less hacky?
> > 
> > I'm not really sure how that is supposed to look like. Technically nothing
> > should ever touch that timer, as it will only make the system hang if it
> > gets disabled.
> > 
> > We do have a binding for the timer ip block (rockchip,rk3288-timer) but of
> > course cannot use that, to make sure the regular timer driver doesn't bind
> > to it. So I guess we could do something like:
> > 
> > 
> > timer at 200440a0 {
> > 
> >         compatible = "rockchip,arch-timer-supply";
> >         reg = <0x200440a0 0x20>;
> > 
> > };
> > 
> > try to find this and enable it, but duplicating the hack and spreading it
> > into the dts as well somehow doesn't feel like an improvement ;-) .
> > 
> > But I maybe you have a nicer idea on how to do this, than me.
> 
> In a kernel tree drop from Rockchip I noticed that they're still
> carrying around the patch "ARM: rockchip: make sure timer5 is enabled
> on rk3036 platforms" as if it made it upstream, but as per this thread
> it didn't.
> 
> Does someone have ownership resolving this?  Perhaps everyone has
> updated to a bootloader that avoids the need for this patch now?

running on kylin, with the provided uboot sources (mainline uboot + some 
patches) the rk3036 runs just fine, without that timer enablement being needed.

So if nobody shouts (and does the needed work), I intend to just let it drop.


Heiko

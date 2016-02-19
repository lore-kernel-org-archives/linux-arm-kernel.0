From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 03:39:38 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <20160218223312.GT19428@n2100.arm.linux.org.uk>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602181244490.13632@knanqh.ubzr>
 <HK2PR06MB0561377EABB3B4B8E94F22328AAF0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1602181327060.13632@knanqh.ubzr>
 <HK2PR06MB0561C0EEA846C516645239338AAF0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20160218223312.GT19428@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB05617E2ED835CFE20F65E3D38AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Russell King - ARM Linux wrote:

> On Thu, Feb 18, 2016 at 07:42:20PM +0000, Chris Brandt wrote:
> > On Thu, 18 Feb 2016, Nicolas Pitre wrote:
> > 
> > > > Is there some way you can do a PLATFORM_COUNTER++ for each device 
> > > > that is selected, and then XIP_KERNEL would depend on 
> > > > PLATFORM_COUNTER == 1 ?
> > >
> > > I don't know all the Kconfig possibilities.
> > >
> > > But would something like this work?
> > >
> > > config FOO
> > >	depends on !(XIP && CHOICE_MADE)
> > >	select CHOICE_MADE
> > 
> > I follow your logic and that might work: If you made multiple choices,
> > it would just take the first one.
> > 
> > However...I just tried it and it crashes.
> > 
> > scripts/kconfig/mconf  Kconfig
> > make[2]: *** [menuconfig] Segmentation fault (core dumped)
> > make[1]: *** [menuconfig] Error 2
> > 
> > 
> > It looks like you can't depend on something not being set that you are
> > going to set yourself. Basically..."do as I say, not as I do"
> 
> It's missing a bool/tristate.  Every config option needs to be typed.


Thank you! That makes things better.

Technically, it seems to work (you can only select 1), but the menu system is a little flakey when you try jumping back and forth between what device to select. Somehow when 2 get selected, I need to get kbuild to go back and do a full refresh or something.


I'm going to play with it some more before I start shouting victory.


Chris

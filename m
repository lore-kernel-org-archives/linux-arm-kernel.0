From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 10 Feb 2015 20:53:44 +0200
Subject: [PATCH] ARM: shmobile: r8a73a4: Move pfc node to work around
 probe ordering bug
In-Reply-To: <CAMuHMdUmftjWD=hZVYVOGJWBc6tb1h=ZnMv61_nCROkOC=e_iw@mail.gmail.com>
References: <1423254173-31852-1-git-send-email-geert+renesas@glider.be>
 <20150209182918.GA2531@atomide.com>
 <CAMuHMdUmftjWD=hZVYVOGJWBc6tb1h=ZnMv61_nCROkOC=e_iw@mail.gmail.com>
Message-ID: <3282348.ooqjOMyZ9x@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tuesday 10 February 2015 11:19:39 Geert Uytterhoeven wrote:
> On Mon, Feb 9, 2015 at 7:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Geert Uytterhoeven <geert@linux-m68k.org> [150209 09:17]:
> >> On Mon, Feb 9, 2015 at 5:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>> * Geert Uytterhoeven <geert+renesas@glider.be> [150206 12:26]:
> >>>> Notes:
> >>>>   - It seems several people tried to solve this in the core OF probing
> >>>>     code before, but the final solution never went in?
> >>>>   
> >>>>   - This can be reproduced on other SoCs (e.g. sh73a0 and r8a7740) by
> >>>>     moving their pfc nodes before their interrupt controller nodes.
> >>>>   
> >>>>   - This patch is against my working tree, so it doesn't apply to
> >>>>     Simon's repository, but you get the idea....
> >>> 
> >>> No issues with the patch, but here are few comments on the core
> >>> reasons (without looking at the code in this case) that might help
> >>> fix similar issues.
> >>> 
> >>> In all the cases I've seen these errors are caused by non-standard
> >>> custom initcall levels for drivers like i2c bus. The real solution
> >>> is to initialize drivers later with standard module_init, and stop
> >>> the race to the bottom with custom initcall levels.
> >>> 
> >>> If there is legacy board specific platofrm init code that needs
> >>> i2c gpios early, that code can probably be moved to initialize
> >>> later on.
> >> 
> >> In this case no i2c is involved. The drivers for both pinctrl
> >> (renesas,pfc-r8a73a4) and irqchip (renesas,irqc) are registered
> >> 
> >> at the same level:
> >>   - postcore_initcall(sh_pfc_init);
> >>   - postcore_initcall(irqc_init);
> >> 
> >> Hence the system uses the "natural" order from within the DTS,
> >> and decided to instantiate the pfc before the irqchip.
> > 
> > OK
> 
> I tried converting the renesas,irqc driver to IRQCHIP_DECLARE().
> This solves the probe ordering problem, but it no longer allows the use of
> a platform device.

One (quite hackish) possible way around this is to register the platform 
driver (using a static variable to ensure the driver isn't registered multiple 
times) in the IRQCHIP_DECLARE'd init function, and then call 
of_platform_device_create() to create the platform device. This should get the 
device probed immediately.

> As I was already adding clock and runtime PM support
> (which use platform devices), IRQCHIP_DECLARE doesn't look like the
> right road to follow...

-- 
Regards,

Laurent Pinchart

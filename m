From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 9 Oct 2012 13:50:35 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <50738DD0.5090406@wwwdotorg.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <20121007195759.GG12801@game.jcrosoft.org>
 <20121007225417.GA29996@glitch> <50738DD0.5090406@wwwdotorg.org>
Message-ID: <20121009115034.GA28817@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 08:37:04PM -0600, Stephen Warren wrote:
> On 10/07/2012 04:54 PM, Domenico Andreoli wrote:
> > On Sun, Oct 07, 2012 at 09:57:59PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> On 03:53 Sun 07 Oct     , Domenico Andreoli wrote:
> >>> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> >>> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> 
> >>> +		vic0: interrupt-controller at 80000 {
> >>> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
> >> why brcm specific compatbile?
> > 
> > Nothing breaks if I drop it. I think it's a future-proof clause, especially
> > if you consider that the devicetree could be not easy to upgrade and you
> > may need a way to differentiate the bcm476x's implementation from the
> > common one. I'm not sure it's an actual requirement with use cases.
> 
> Indeed, everything works fine right now if you drop that. However, it is
> correct practice to include a compatible value for the particular SoC
> that incorporates the IP so that if in the future some SoC-specific
> workaround is required, the compatible value needed to trigger this is
> already in all historical .dts file.

This matches with what I know but it seems anyway that in the arm,primecell
cases this is not a great concern, almost none of the dts currently in
mainline go as far as specifying the machine specific name.

> >>> Index: b/arch/arm/include/debug/bcm476x.S
> 
> >>> +#if defined(CONFIG_DEBUG_BCM476X_UART0)
> >>> +# define BCM476X_DEBUG_PHYS	0x000c0000
> >>> +# define BCM476X_DEBUG_VIRT	0xd00c0000
> >>> +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
> >>> +# define BCM476X_DEBUG_PHYS	0x000c1000
> >>> +# define BCM476X_DEBUG_VIRT	0xd00c1000
> >>> +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
> >>> +# define BCM476X_DEBUG_PHYS	0x000b2000
> >>> +# define BCM476X_DEBUG_VIRT	0xd00b2000
> >>> +#else
> >>> +# error Unknown BCM476x debug port
> >>> +#endif
> >>
> >> can't you detect it?
> > 
> > If I can assume that the boot loader will configure and enable only the
> > console port, I could use the first one in such state.
> > 
> > Where could I place such detection, in the maco addruart itself?
> 
> Auto-detection is not necessarily a good idea; there's no reason in
> general to believe that no future board will ever use a UART for any
> purposes other than console/debug. Being explicit is probably good.

After thinking at it a bit, I also prefer to leave the guessing out. It
can break things in non-obvious ways. I prefer a full consistent and
testable behaviour.

Thanks,
Domenico

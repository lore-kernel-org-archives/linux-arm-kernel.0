From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 01:18:52 -0700
Subject: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
Message-ID: <20120710081851.GL1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120709 23:30]:
> On Mon, Jul 09, 2012 at 18:41:58, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120709 01:55]:
> > > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> > > > --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > > +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > > @@ -39,6 +39,7 @@ struct omap_clk {
> > > >  #define CK_443X		(1 << 11)
> > > >  #define CK_TI816X	(1 << 12)
> > > >  #define CK_446X		(1 << 13)
> > > > +#define CK_54XX		(1 << 14)
> > > 
> > > This is conflicting with AM33XX, you may want to rebase it again, since
> > > AM33xx clock tree is already pushed and available in
> > > linux-omap/devel-am33xx-part2.
> > 
> > Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> > 
> > They really should be replaced with SoC specific lists of clocks
> > rather than bloating the cpu_mask and repeating it for every clock
> > that's compiled in for 800+ times.
> > 
> > Below (untested) is what could be done in the short term.
> > 
> > I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> > for non-shared clocks if they only get set in some *_data.c
> > file in a unique way?
> > 
> > Paul got any better ideas?
...

> This also will not scale up in the future and will end up again in the same 
> situation.

Right that's why we want to get rid of it.
 
> Just a quick thought, may work here,
> 
> I looked at the usage of cpu_mask and rates.flag and I believe we can 
> restrict both to given SoC, something like,
> 
> OMAP34XX ->
>           ES1
>           ES2PLUS
>           36XX
>           AM35XX
>           ...
> 
> OMAP4 ->
>           443X
>           446X
> 
> AM33XX ->
>           AM335X
>           TI816X
>           TI814X
>           ...
> 
> XYZ...  ->
>           ...
> 
> 
> The proposal would be,
> 
> To make cpu_mask and rate.flags 32 bit wide and divide it in 16-16 bits -
> 
> Lower 16 bits => describe SoC it is applicable to
> Upper 16 bit => describes silicon versions or families

No thanks.. We don't want to make it 32 bit and bloat all the compiled in
clock even further. 

Regards,

Tony

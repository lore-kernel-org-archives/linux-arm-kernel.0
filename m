From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 18 Aug 2016 13:30:39 +0000
Subject: [PATCH v2 4/4] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <6d3cb4b2-32d8-9304-a4a4-9e675e686bfb@ti.com>
References: <20160810110032.29295-1-kbeldan@baylibre.com>
 <20160810110032.29295-5-kbeldan@baylibre.com>
 <6d3cb4b2-32d8-9304-a4a4-9e675e686bfb@ti.com>
Message-ID: <20160818133039.GA8546@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 03:27:52PM +0530, Sekhar Nori wrote:
> On Wednesday 10 August 2016 04:30 PM, Karl Beldan wrote:
> > This adds DT support for the NAND connected to the SoC AEMIF.
> > The parameters (timings, ecc) are the same as what the board ships with
> > (default AEMIF timings, 1bit ECC) and improvements will be handled in
> > due course.
> > This passed elementary tests hashing a 20MB file on top of ubifs on my
> > LCDK.
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  arch/arm/boot/dts/da850-lcdk.dts | 107 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 107 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> > index dbcca0b..a3f9845 100644
> > --- a/arch/arm/boot/dts/da850-lcdk.dts
> > +++ b/arch/arm/boot/dts/da850-lcdk.dts
> > @@ -27,6 +27,27 @@
> 
> > +&aemif {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&nand_pins>;
> > +	status = "ok";
> > +	cs3 {
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +		clock-ranges;
> > +		ranges;
> > +
> > +		ti,cs-chipselect = <3>;
> > +
> > +		nand at 2000000,0 {
> > +			compatible = "ti,davinci-nand";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0 0x02000000 0x02000000
> > +			       1 0x00000000 0x00008000>;
> > +
> > +			ti,davinci-chipselect = <1>;
> > +			ti,davinci-mask-ale = <0>;
> > +			ti,davinci-mask-cle = <0>;
> > +			ti,davinci-mask-chipsel = <0>;
> > +
> > +			/*
> > +			 * nand_ecc_strength_good will emit a warning
> > +			 * but the LCDK ships with these settings [1].
> > +			 * Also HW 4bits ECC with 16bits NAND seems to
> > +			 * require some attention.
> > +			 *
> > +			 * ATM nand_davinci_probe handling of nand-ecc-*
> > +			 * is broken, e.g.
> > +			 * chip.ecc.strength = pdata->ecc_bits occurs after
> > +			 * scan_ident(), otherwise I would have used:
> > +			 * 	nand-ecc-mode = "hw";
> > +			 * 	nand-ecc-strength = <1>;
> > +			 * 	nand-ecc-step-size = <512>;
> > +			 */
> > +			ti,davinci-nand-buswidth = <16>;
> > +			ti,davinci-ecc-mode = "hw";
> > +			ti,davinci-ecc-bits = <1>;
> > +			ti,davinci-nand-use-bbt;
> 
> As discussed before, will apply this patch after 4-bit ECC support is
> sorted out.
> 

Ok. BTW it seems I might have the opportunity to look into this.

> > +
> > +			/*
> > +			 * LCDK original partitions:
> > +			 * 0x000000000000-0x000000020000 : "u-boot env"
> > +			 * 0x000000020000-0x0000000a0000 : "u-boot"
> > +			 * 0x0000000a0000-0x0000002a0000 : "kernel"
> > +			 * 0x0000002a0000-0x000020000000 : "filesystem"
> > +			 *
> > +			 * The 1st NAND block being guaranted to be valid w/o ECC (> 1k cycles),
> > +			 * it makes a perfect candidate as an SPL for the BootROM to jump to.
> > +			 * However the OMAP-L132/L138 Bootloader doc SPRAB41E reads:
> > +			 * "To boot from NAND Flash, the AIS should be written to NAND block 1
> > +			 * (NAND block 0 is not used by default)", which matches the LCDK
> > +			 * original partitioning.
> 
> FWIW, silicon version 2.1 supports booting from block 0, but needs new
> boot pin settings not possible in stock LCDK.
> 

That's a convenient improvement.

> > +			 * Also, the LCDK ships with only the u-boot partition provisioned and
> > +			 * boots on it in its default configuration while using the MMC for the
> > +			 * kernel and rootfs, so preserve that one as is for now.
> > +			 * [1]: Ensuring for example that U-Boot LCDK SPL can handle it properly
> > +			 * and a proper boot chain ROM->SPL->U-Boot->Linux wrt ECC, would allow
> > +			 * for a better partitioning.
> > +			 */
> 
> I would rather not refer to the software that LCDK ships with in the
> comments at all. Because that can change without notice. At some point,
> if mainline kernel works well enough on LCDK, TI might decide to ship
> LCDKs with mainline kernel flashed.
> 

That'd be a very good thing to get mainline well enough that it ships
with it. Given that information it would make sense to get rid of the
comments, which I'll keep in mind for when the ECC issue is sorted out.

Thanks for the review.

Regards, 
Karl

> > +			partitions {
> > +				compatible = "fixed-partitions";
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +
> > +				partition at 0 {
> > +					label = "u-boot env";
> > +					reg = <0 0x020000>;
> > +				};
> > +				partition at 0x020000 {
> > +					/* The LCDK defaults to booting from this partition */
> > +					label = "u-boot";
> > +					reg = <0x020000 0x080000>;
> > +				};
> > +				partition at 0x0a0000 {
> > +					label = "space";
> > +					reg = <0x0a0000 0>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> 
> Rest of the patch looks good to me.
> 
> Regards,
> Sekhar
> 
> 

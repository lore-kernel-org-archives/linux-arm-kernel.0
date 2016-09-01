From: karl.beldan@gmail.com (Karl Beldan)
Date: Thu, 1 Sep 2016 10:00:25 +0000
Subject: [PATCH] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <3945712b-d02f-d97a-2356-9383d7fe1984@ti.com>
References: <20160829153242.18615-1-kbeldan@baylibre.com>
 <7h37lk5wrd.fsf@baylibre.com>
 <3945712b-d02f-d97a-2356-9383d7fe1984@ti.com>
Message-ID: <20160901095857.GA27385@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 10:47:04AM +0530, Sekhar Nori wrote:
> On Thursday 01 September 2016 05:14 AM, Kevin Hilman wrote:
> > Karl Beldan <kbeldan@baylibre.com> writes:
> > 
> >> This adds DT support for the NAND connected to the SoC AEMIF.
> >> Passed torture hashing a 40MB file on top of UBIFS using subpages.
> >>
> >> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >> ---
> >> v2:
> >>
> >> - Removed comments pertaining to the BSP the LCDK ships with (Sekhar)
> >> - s/"ok"/"okay"/
> >> - Removed partitions since it relates to the BSP the LCDK ships with
> > 
> > IMO, some default partitions are nice to have, at least for u-boot and
> > u-boot env so factory-shipped u-boot is not accidentally overridden.
> > The left over space can be labeled "free space".
> > 
> > Anyways, after adding some partitions back, I tested with ubifs on my
> > LCDK:
> 
> This[1] is what I had commented on the partitions before. I did not 
> mean to remove partitions altogether, just comments referring to 
> compatibility with pre-flashed software shipping with LCDK (since that 
> changes without notice).
> 
> Apologies for any confusion caused. The "Rest of the patch looks good
> to me" in the end was to say that the partitions themselves look fine :)
> 

None necessary, I just pushed the logic further on my own as specified
in the changelog. I can add the partitions back as I don't have any
strong preference on this, but not without mentioning that it is because
that is what the LCDK ships with, as in my original version, please see
if the adjustments below accomodate your preferences.

> Can you please submit a v2 with partitions added?
> 
> Thanks,
> Sekhar
> 
> [1]
> 
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

I'd add [1]:
Same doc reads for ROM "Silicon Revision 2.1", "Updated NAND boot mode
to offer boot from block 0 or block 1", (Sekhar:) "but needs new boot pin
settings not possible in stock LCDK".

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

If you want me to keep the partitions, I would change that to [2] "Here
we keep the first two provisioned default partitions and labels the LCDK
ships with as is." (although FWIU it conflicts with your request above).

 
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

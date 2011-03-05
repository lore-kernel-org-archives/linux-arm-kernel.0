From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 5 Mar 2011 11:38:12 +0000
Subject: [PATCH] [ARM] orion5x: use safer FPGA ID 'default' for TS-78xx
In-Reply-To: <20110305112937.GA22117@chipmunk>
References: <20110305112937.GA22117@chipmunk>
Message-ID: <20110305113812.GC22117@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

....abort!

* Alexander Clouter <alex@digriz.org.uk> [2011-03-05 11:29:37+0000]:
>
> Originally the FPGA ID checking switch statement left disabled all the
> TS implemented FPGA devices if the ID was unknown to it.  Michael Spang
> created a fix in 3c390473 that changed the default to enable the devices
> in the event TS silently release more revisions into the wild, this
> unfortunately breaks custom FPGA bitstreams.
> 
> This patch amends the switch statement so that the TS devices are only
> enabled if on the revision number is unknown (whilst the magic matches).
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/mach-orion5x/ts78xx-fpga.h  |   19 ++++++++++---------
>  arch/arm/mach-orion5x/ts78xx-setup.c |   18 +++++++++++++-----
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion5x/ts78xx-fpga.h
> index 791f754..f0e3be1 100644
> --- a/arch/arm/mach-orion5x/ts78xx-fpga.h
> +++ b/arch/arm/mach-orion5x/ts78xx-fpga.h
> @@ -1,3 +1,4 @@
> +#define TS_78XX_FPGA_MAGIC 0x00b480
>  #define FPGAID(_magic, _rev) ((_magic << 8) + _rev)
>  
>  /*
> @@ -6,15 +7,15 @@
>   */
>  enum fpga_ids {
>  	/* Technologic Systems */
> -	TS7800_REV_1	= FPGAID(0x00b480, 0x01),
> -	TS7800_REV_2	= FPGAID(0x00b480, 0x02),
> -	TS7800_REV_3	= FPGAID(0x00b480, 0x03),
> -	TS7800_REV_4	= FPGAID(0x00b480, 0x04),
> -	TS7800_REV_5	= FPGAID(0x00b480, 0x05),
> -	TS7800_REV_6	= FPGAID(0x00b480, 0x06),
> -	TS7800_REV_7	= FPGAID(0x00b480, 0x07),
> -	TS7800_REV_8	= FPGAID(0x00b480, 0x08),
> -	TS7800_REV_9	= FPGAID(0x00b480, 0x09),
> +	TS7800_REV_1	= FPGAID(TS_78XX_FPGA_MAGIC, 0x01),
> +	TS7800_REV_2	= FPGAID(TS_78XX_FPGA_MAGIC, 0x02),
> +	TS7800_REV_3	= FPGAID(TS_78XX_FPGA_MAGIC, 0x03),
> +	TS7800_REV_4	= FPGAID(TS_78XX_FPGA_MAGIC, 0x04),
> +	TS7800_REV_5	= FPGAID(TS_78XX_FPGA_MAGIC, 0x05),
> +	TS7800_REV_6	= FPGAID(TS_78XX_FPGA_MAGIC, 0x06),
> +	TS7800_REV_7	= FPGAID(TS_78XX_FPGA_MAGIC, 0x07),
> +	TS7800_REV_8	= FPGAID(TS_78XX_FPGA_MAGIC, 0x08),
> +	TS7800_REV_9	= FPGAID(TS_78XX_FPGA_MAGIC, 0x09),
>  
>  	/* Unaffordable & Expensive */
>  	UAE_DUMMY	= FPGAID(0xffffff, 0x01),
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 1cac714..82e57a6 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -399,11 +399,19 @@ static void ts78xx_fpga_supports(void)
>  		ts78xx_fpga.supports.ts_rng.present = 1;
>  		break;
>  	default:
> -		printk(KERN_WARNING "Unrecognized TS-78XX FPGA ID 0x%02x",
> -		       ts78xx_fpga.id);
> -		ts78xx_fpga.supports.ts_rtc.present = 1;
> -		ts78xx_fpga.supports.ts_nand.present = 1;
> -		ts78xx_fpga.supports.ts_rng.present = 1;
> +		/* enable TS devices if at least the magic matches */
> +		if (((ts78xx_fpga.id >> 8) & 0xffffff) == TS_78XX_FPGA_MAGIC) {
> +			printk(KERN_WARNING "TS-78xx FPGA: unrecognized revision 0x%.2x\n",
> +					ts78xx_fpga.id & 0xff);
> +			ts78xx_fpga.supports.ts_rtc.present = 1;
> +			ts78xx_fpga.supports.ts_nand.present = 1;
> +			ts78xx_fpga.supports.ts_rng.present = 1;
> +			break;
> +		}
> +
> +		ts78xx_fpga.supports.ts_rtc.present = 0;
> +		ts78xx_fpga.supports.ts_nand.present = 0;
> +		ts78xx_fpga.supports.ts_rng.present = 0;
>  	}
>  }
>  
>

-- 
Alexander Clouter
.sigmonster says: Anger is momentary madness.
                  		-- Horace

From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 7 Dec 2011 10:44:35 +0000
Subject: [PATCH] arm,davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <1322991679-20947-1-git-send-email-hs@denx.de>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B603EFB2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Sun, Dec 04, 2011 at 15:11:19, Heiko Schocher wrote:

Please provide a patch description. Nice to see device tree
support being added for DaVinci devices.

> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: grant.likely at secretlab.ca
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  .../devicetree/bindings/arm/davinci/aemif.txt      |   85 ++++++++++++++++
>  arch/arm/mach-davinci/aemif.c                      |  105 +++++++++++++++++++-
>  arch/arm/mach-davinci/include/mach/aemif.h         |    1 +
>  3 files changed, 190 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/aemif.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci/aemif.txt b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
> new file mode 100644
> index 0000000..c9ed551
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/aemif.txt
> @@ -0,0 +1,85 @@
> +* Texas Instruments Davinci AEMIF
> +
> +This file provides information, what the device node for the
> +davinci aemifa interface contain.
           ^^^^^^
           aemif
> +
> +Required properties:
> +- compatible: "ti,davinci-emifa";
> +- #address-cells : Should be either two or three.  The first cell is the
> +                   chipselect number, and the remaining cells are the
> +                   offset into the chipselect.
> +- #size-cells : Either one or two, depending on how large each chipselect
> +                can be.
> +- ranges : Each range corresponds to a single chipselect, and cover
> +           the entire access window as configured.
> +
> +Optional properties:
> +- none
> +
> +Optional subnodes:
> +- Chipselect setup:
> +  - Required properties:
> +	- compatible: "ti,davinci-cs";
> +	- #address-cells = <1>;
> +	- #size-cells = <1>;
> +
> +    Timing setup, all timings in nanoseconds
> +	- cs:		chipselect (value 2,3,4 or 5)
> +	- asize:	Asynchronous Data Bus Width.
> +			value:
> +			0: 8 bit
> +			1: 16 bit
> +	- ta:		Minimum Turn-Around time.
> +	- rhold:	Read hold width
> +	- rstrobe:	Read strobe width
> +	- rsetup:	Read setup width
> +	- whold:	Write hold width
> +	- wstrobe:	Write strobe width
> +	- wsetup:	Write setup width
> +	- ew:		Extend Wait bit
> +			value:
> +			0: Extended wait cycles disabled.
> +			1: Extended wait cycles enabled.
> +	-ss:		Select Strobe bit.
> +			value:
> +			0: Normal Mode enabled.
> +			1: Select Strobe Mode enabled.
> +- CFI driver:
> +  see: Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> +
> +Example (enbw_cmc board):
> +	aemif at 60000000 {
> +		compatible = "ti,davinci-emifa";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <0x68000000 0x80000>;
> +		ranges = <2 0 0x60000000 0x02000000
> +			  3 0 0x62000000 0x02000000
> +			  4 0 0x64000000 0x02000000
> +			  5 0 0x66000000 0x02000000>;
> +		cs2 at 0x60000000 {
> +			compatible = "ti,davinci-cs";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* all timings in nanoseconds */
> +			cs = <2>;
> +			asize = <1>;
> +			ta = <0>;
> +			rhold = <7>;
> +			rstrobe = <42>;
> +			rsetup = <14>;
> +			whold = <7>;
> +			wstrobe = <42>;
> +			wsetup = <14>;
> +			ew = <0>;
> +			ss = <0>;
> +		};
> +		flash at 2,0 {
> +			compatible = "cfi-flash";
> +			reg = <2 0x0 0x400000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bank-width = <2>;
> +			device-width = <2>;
> +		};
> +	};
> diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
> index 1ce70a9..12c559f 100644
> --- a/arch/arm/mach-davinci/aemif.c
> +++ b/arch/arm/mach-davinci/aemif.c
> @@ -13,12 +13,14 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/time.h>
>  
>  #include <mach/aemif.h>
>  
>  /* Timing value configuration */
> -
> +#define ASIZE(x)	(x)
>  #define TA(x)		((x) << 2)
>  #define RHOLD(x)	((x) << 4)
>  #define RSTROBE(x)	((x) << 7)
> @@ -26,7 +28,10 @@
>  #define WHOLD(x)	((x) << 17)
>  #define WSTROBE(x)	((x) << 20)
>  #define WSETUP(x)	((x) << 26)
> +#define EW(x)		((x) << 30)
> +#define SS(x)		((x) << 31)

You are adding support for additional configuration
parameters which should be done in a separate patch.

>  
> +#define ASIZE_MAX	0x1
>  #define TA_MAX		0x3
>  #define RHOLD_MAX	0x7
>  #define RSTROBE_MAX	0x3f
> @@ -34,6 +39,8 @@
>  #define WHOLD_MAX	0x7
>  #define WSTROBE_MAX	0x3f
>  #define WSETUP_MAX	0xf
> +#define EW_MAX		0x1
> +#define SS_MAX		0x1
>  
>  #define TIMING_MASK	(TA(TA_MAX) | \
>  				RHOLD(RHOLD_MAX) | \
> @@ -131,3 +138,99 @@ int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
>  	return 0;
>  }
>  EXPORT_SYMBOL(davinci_aemif_setup_timing);
> +
> +#if defined(CONFIG_OF)
> +static int dv_get_value(struct device_node *np, const char *name)
> +{
> +	const u32 *data;
> +	int len;
> +
> +	data = of_get_property(np, name, &len);
> +	if (data)
> +		return be32_to_cpu(readl(data));
> +
> +	return -EINVAL;
> +}
> +
> +static int davinci_aemif_setup_timing_of_one(struct device_node *np,
> +		void __iomem *base)
> +{
> +	unsigned val;
> +	int asize, ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
> +	int ew, ss;
> +	int cs;
> +	unsigned offset;
> +	struct clk *aemif_clk;
> +	unsigned long clkrate;
> +
> +	aemif_clk = clk_get(NULL, "aemif");
> +	if (IS_ERR(aemif_clk))
> +		return PTR_ERR(aemif_clk);
> +
> +	clkrate = clk_get_rate(aemif_clk);
> +
> +	clkrate /= 1000;	/* turn clock into kHz for ease of use */
> +
> +	cs = dv_get_value(np, "cs");
> +	if (cs < 2)
> +		return -EINVAL;
> +
> +	offset = A1CR_OFFSET + (cs - 2) * 4;
> +	asize	= dv_get_value(np, "asize");
> +	ta	= aemif_calc_rate(dv_get_value(np, "ta"), clkrate, TA_MAX);
> +	rhold	= aemif_calc_rate(dv_get_value(np, "rhold"), clkrate,
> +			RHOLD_MAX);
> +	rstrobe	= aemif_calc_rate(dv_get_value(np, "rstrobe"), clkrate,
> +			RSTROBE_MAX);
> +	rsetup	= aemif_calc_rate(dv_get_value(np, "rsetup"), clkrate,
> +			RSETUP_MAX);
> +	whold	= aemif_calc_rate(dv_get_value(np, "whold"), clkrate,
> +			WHOLD_MAX);
> +	wstrobe	= aemif_calc_rate(dv_get_value(np, "wstrobe"), clkrate,
> +			WSTROBE_MAX);
> +	wsetup	= aemif_calc_rate(dv_get_value(np, "wsetup"), clkrate,
> +			WSETUP_MAX);
> +	ew	= dv_get_value(np, "ew");
> +	ss	= dv_get_value(np, "ss");
> +
> +	if (asize < 0 || ta < 0 || rhold < 0 || rstrobe < 0 || rsetup < 0 ||
> +			whold < 0 || wstrobe < 0 || wsetup < 0 || ew < 0 ||
> +			ss < 0) {
> +		pr_err("%s: cannot get suitable timings\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	val = ASIZE(asize) | TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) |
> +		RSETUP(rsetup) | WHOLD(whold) | WSTROBE(wstrobe) |
> +		WSETUP(wsetup) | EW(ew) | SS(ss);
> +
> +	__raw_writel(val, base + offset);
> +
> +	return 0;
> +}

This shares a large amount of code with davinci_aemif_setup_timing().
Can you try writing this as a OF wrapper to the existing function?

Thanks,
Sekhar

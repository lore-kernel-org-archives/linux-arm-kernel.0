From: b32955@freescale.com (Huang Shijie)
Date: Mon, 23 Apr 2012 16:10:41 +0800
Subject: [PATCH 3/3] mtd: gpmi: add device tree support for mx6q-arm2
 and mx28evk
In-Reply-To: <20120423064334.GQ26306@S2101-09.ap.freescale.net>
References: <1334913859-5314-1-git-send-email-b32955@freescale.com>
 <1334913859-5314-4-git-send-email-b32955@freescale.com>
 <20120423064334.GQ26306@S2101-09.ap.freescale.net>
Message-ID: <4F950E81.8040706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?04?23? 14:43, Shawn Guo ??:
> On Fri, Apr 20, 2012 at 05:24:19PM +0800, Huang Shijie wrote:
>> add DT support to mx6q-arm2 and mx28evk.
>>
> Again, this is not a support about board but soc.
>
thanks. I will change it in next version.
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   .../devicetree/bindings/mtd/gpmi-nand.txt          |   30 +++
>>   drivers/mtd/nand/Kconfig                           |    2 +-
>>   drivers/mtd/nand/gpmi-nand/bch-regs.h              |   42 +++-
>>   drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   18 +-
>>   drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  240 +++++++++-----------
>>   drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    6 +-
>>   6 files changed, 181 insertions(+), 157 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>> new file mode 100644
>> index 0000000..e1181ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>> @@ -0,0 +1,30 @@
>> +* Freescale General-Purpose Media Interface (GPMI)
>> +
>> +The GPMI nand controller provides an interface to control the
>> +NAND flash chips. We support only one NAND chips now.
>> +
>> +The GPMI nand controller required properties:
>> +  - compatible : should be "fsl,<chip>-gpmi-nand"
>> +  - reg : should contain registers location and length.
>> +  - interrupts : should contain the DMA interrupt number for GPMI.
>> +                 We do not use the GPMI interrupt.
>> +  - dma_channel: Should contain the dma channel it uses.
>> +
>> +The BCH required properties:
>> +  - compatible : should be "fsl,<chip>-bch"
>> +  - reg : should contain registers location and length.
>> +  - interrupts : should contain the BCH interrupt.
>> +
>> +Examples:
>> +
>> +gpmi-nand at 8000c000 {
>> +	compatible = "fsl,imx28-gpmi-nand";
>> +	reg =<0x8000c000 2000>;
>> +	interrupts =<88>;
>> +	dma_channel =<4>;
> Before generic dma helper is available, do not use such generic property
> name, and use something like "fsl,gpmi-dma-events".  Yes, "-" rather
> than "_" should be used in property name.
>
got it.
>> +};
>> +bch at 8000a000 {
>> +	compatible = "fsl,imx28-bch";
>> +	reg =<0x8000a000 2000>;
>> +	interrupts =<41>;
>> +};
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 7d17cec..bf0a28d 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -440,7 +440,7 @@ config MTD_NAND_NANDSIM
>>
>>   config MTD_NAND_GPMI_NAND
>>           bool "GPMI NAND Flash Controller driver"
>> -        depends on MTD_NAND&&  (SOC_IMX23 || SOC_IMX28)
>> +        depends on MTD_NAND&&  (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
>>           help
>>   	 Enables NAND Flash support for IMX23 or IMX28.
>>   	 The GPMI controller is very powerful, with the help of BCH
>> diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
>> index 4effb8c..a092451 100644
>> --- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
>> +++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
>> @@ -51,15 +51,26 @@
>>
>>   #define BP_BCH_FLASH0LAYOUT0_ECC0		12
>>   #define BM_BCH_FLASH0LAYOUT0_ECC0	(0xf<<  BP_BCH_FLASH0LAYOUT0_ECC0)
>> -#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
>> -	(((v)<<  BP_BCH_FLASH0LAYOUT0_ECC0)&  BM_BCH_FLASH0LAYOUT0_ECC0)
>> +#define MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0		11
>> +#define MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0	(0x1f<<  MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)
>> +#define BF_BCH_FLASH0LAYOUT0_ECC0(v, x)				\
>> +	(GPMI_IS_MX6Q(x)					\
>> +		? (((v)<<  MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)	\
>> +			&  MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0)	\
>> +		: (((v)<<  BP_BCH_FLASH0LAYOUT0_ECC0)		\
>> +			&  BM_BCH_FLASH0LAYOUT0_ECC0)		\
>> +	)
>>
>>   #define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
>>   #define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
>>   			(0xfff<<  BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
>> -#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
>> -	(((v)<<  BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)\
>> -					&  BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
>> +#define MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE	\
>> +			(0x3ff<<  BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
>> +#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v, x)				\
>> +	(GPMI_IS_MX6Q(x)						\
>> +		? (((v)>>  2)&  MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)	\
>> +		: ((v)&  BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)		\
>> +	)
>>
>>   #define HW_BCH_FLASH0LAYOUT1			0x00000090
>>
>> @@ -72,13 +83,24 @@
>>
>>   #define BP_BCH_FLASH0LAYOUT1_ECCN		12
>>   #define BM_BCH_FLASH0LAYOUT1_ECCN	(0xf<<  BP_BCH_FLASH0LAYOUT1_ECCN)
>> -#define BF_BCH_FLASH0LAYOUT1_ECCN(v)		\
>> -	(((v)<<  BP_BCH_FLASH0LAYOUT1_ECCN)&  BM_BCH_FLASH0LAYOUT1_ECCN)
>> +#define MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN		11
>> +#define MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN	(0x1f<<  MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)
>> +#define BF_BCH_FLASH0LAYOUT1_ECCN(v, x)				\
>> +	(GPMI_IS_MX6Q(x)					\
>> +		? (((v)<<  MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)	\
>> +			&  MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN)	\
>> +		: (((v)<<  BP_BCH_FLASH0LAYOUT1_ECCN)		\
>> +			&  BM_BCH_FLASH0LAYOUT1_ECCN)		\
>> +	)
>>
>>   #define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
>>   #define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
>>   			(0xfff<<  BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
>> -#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
>> -	(((v)<<  BP_BCH_FLASH0LAYOUT1_DATAN_SIZE) \
>> -					&  BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
>> +#define MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE	\
>> +			(0x3ff<<  BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
>> +#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v, x)				\
>> +	(GPMI_IS_MX6Q(x)						\
>> +		? (((v)>>  2)&  MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)	\
>> +		: ((v)&  BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)		\
>> +	)
>>   #endif
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> index fa5200b..a1f4332 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> @@ -224,13 +224,13 @@ int bch_set_geometry(struct gpmi_nand_data *this)
>>   	/* Configure layout 0. */
>>   	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
>>   			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
>> -			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)
>> -			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size),
>> +			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength, this)
>> +			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size, this),
>>   			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
>>
>>   	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
>> -			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)
>> -			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size),
>> +			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength, this)
>> +			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size, this),
>>   			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
>>
>>   	/* Set *all* chip selects to use layout 0. */
>> @@ -256,11 +256,12 @@ static unsigned int ns_to_cycles(unsigned int time,
>>   	return max(k, min);
>>   }
>>
>> +#define DEF_MIN_PROP_DELAY	5
>> +#define DEF_MAX_PROP_DELAY	9
>>   /* Apply timing to current hardware conditions. */
>>   static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
>>   					struct gpmi_nfc_hardware_timing *hw)
>>   {
>> -	struct gpmi_nand_platform_data *pdata = this->pdata;
>>   	struct timing_threshod *nfc =&timing_default_threshold;
>>   	struct nand_chip *nand =&this->nand;
>>   	struct nand_timing target = this->timing;
>> @@ -277,8 +278,8 @@ static int gpmi_nfc_compute_hardware_timing(struct gpmi_nand_data *this,
>>   	int ideal_sample_delay_in_ns;
>>   	unsigned int sample_delay_factor;
>>   	int tEYE;
>> -	unsigned int min_prop_delay_in_ns = pdata->min_prop_delay_in_ns;
>> -	unsigned int max_prop_delay_in_ns = pdata->max_prop_delay_in_ns;
>> +	unsigned int min_prop_delay_in_ns = DEF_MIN_PROP_DELAY;
>> +	unsigned int max_prop_delay_in_ns = DEF_MAX_PROP_DELAY;
>>
>>   	/*
>>   	 * If there are multiple chips, we need to relax the timings to allow
>> @@ -804,7 +805,8 @@ int gpmi_is_ready(struct gpmi_nand_data *this, unsigned chip)
>>   	if (GPMI_IS_MX23(this)) {
>>   		mask = MX23_BM_GPMI_DEBUG_READY0<<  chip;
>>   		reg = readl(r->gpmi_regs + HW_GPMI_DEBUG);
>> -	} else if (GPMI_IS_MX28(this)) {
>> +	} else if (GPMI_IS_MX28(this) || GPMI_IS_MX6Q(this)) {
>> +		/* MX28 shares the same R/B register as MX6Q. */
>>   		mask = MX28_BF_GPMI_STAT_READY_BUSY(1<<  chip);
>>   		reg = readl(r->gpmi_regs + HW_GPMI_STAT);
>>   	} else
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> index 75b1dde..5c6af5d 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> @@ -24,6 +24,9 @@
>>   #include<linux/module.h>
>>   #include<linux/mtd/gpmi-nand.h>
>>   #include<linux/mtd/partitions.h>
>> +#include<linux/of_address.h>
>> +#include<linux/of_device.h>
>> +#include<linux/of_irq.h>
>>   #include "gpmi-nand.h"
>>
>>   /* add our owner bbt descriptor */
>> @@ -306,36 +309,6 @@ int start_dma_with_bch_irq(struct gpmi_nand_data *this,
>>   	return 0;
>>   }
>>
>> -static int __devinit
>> -acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
>> -{
>> -	struct platform_device *pdev = this->pdev;
>> -	struct resources *res =&this->resources;
>> -	struct resource *r;
>> -	void *p;
>> -
>> -	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
>> -	if (!r) {
>> -		pr_err("Can't get resource for %s\n", res_name);
>> -		return -ENXIO;
>> -	}
>> -
>> -	p = ioremap(r->start, resource_size(r));
>> -	if (!p) {
>> -		pr_err("Can't remap %s\n", res_name);
>> -		return -ENOMEM;
>> -	}
>> -
>> -	if (!strcmp(res_name, GPMI_NAND_GPMI_REGS_ADDR_RES_NAME))
>> -		res->gpmi_regs = p;
>> -	else if (!strcmp(res_name, GPMI_NAND_BCH_REGS_ADDR_RES_NAME))
>> -		res->bch_regs = p;
>> -	else
>> -		pr_err("unknown resource name : %s\n", res_name);
>> -
>> -	return 0;
>> -}
>> -
> I think the patch goes to a wrong way for acquiring resources from
> device tree.
>
> You need to have a look at Documentation/devicetree/bindings/resource-names.txt
> and understand that DT core has populated the resources for device,
> and device driver can call the same suite of functions to retrieve
Do you mean I can merge the gpmi and bch into one device node such as :

gpmi-nand at xx {
compatible = "fsl, mx28-gpmi-nand";
reg = <xx>, <xx>;
reg-names = "gpmi", "bch";

};

Best Regards
Huang Shijie
> the resources.  That said device driver does not need any change on
> resource acquiring for device tree probe at all.
>
> Regards,
> Shawn
>

From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 09:24:11 +0800
Subject: [PATCH v1] rtc: snvs: add poweroff function
In-Reply-To: <1411611233-29919-1-git-send-email-b38343@freescale.com>
References: <1411611233-29919-1-git-send-email-b38343@freescale.com>
Message-ID: <20140926012410.GD21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 10:13:53AM +0800, Robin Gong wrote:
> On i.mx6 chips, PMIC_ON_REQ can be pulled by snvs LPCR. That can be
> used poweroff system if PMIC_ON_REQ connected with external PMIC or
> power control circuit.Power up again if PMIC_ON_REQ pulled high.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>

I'm not sure it's a good idea to plug poweroff support into RTC driver.
If RTC driver is built out, poweroff function is gone too.

Shawn

> ---
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt |  4 ++++
>  drivers/rtc/rtc-snvs.c                                | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index e402277..00d67f2 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -363,11 +363,15 @@ Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
>        Value type: <prop-encoded-array>
>        Definition: A standard property.  Specifies the physical
>            address and length of the SNVS LP configuration registers.
> +  - fsl,poweroff
> +      Usage: opertional, recommend if PMIC_ON_REQ connected with external
> +	PMIC or power control circuit.
>  
>  EXAMPLE
>  	sec_mon_rtc_lp at 314000 {
>  		compatible = "fsl,sec-v4.0-mon-rtc-lp";
>  		reg = <0x34 0x58>;
> +		fsl,poweroff;
>  	};
>  
>  =====================================================================
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index fa384fe..ef32541 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -29,6 +29,8 @@
>  #define SNVS_LPCR_SRTC_ENV	(1 << 0)
>  #define SNVS_LPCR_LPTA_EN	(1 << 1)
>  #define SNVS_LPCR_LPWUI_EN	(1 << 3)
> +#define SNVS_LPCR_DP		(1 << 5)
> +#define SNVS_LPCR_TOP		(1 << 6)
>  #define SNVS_LPSR_LPTA		(1 << 0)
>  
>  #define SNVS_LPPGDR_INIT	0x41736166
> @@ -41,6 +43,8 @@ struct snvs_rtc_data {
>  	spinlock_t lock;
>  };
>  
> +static void __iomem *snvs_base;
> +
>  static u32 rtc_read_lp_counter(void __iomem *ioaddr)
>  {
>  	u64 read1, read2;
> @@ -241,8 +245,17 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
>  	return events ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> +static void snvs_poweroff(void)
> +{
> +	u32 value;
> +
> +	value = readl(snvs_base + SNVS_LPCR);
> +	writel(value | SNVS_LPCR_DP | SNVS_LPCR_TOP, snvs_base + SNVS_LPCR);
> +}
> +
>  static int snvs_rtc_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct snvs_rtc_data *data;
>  	struct resource *res;
>  	int ret;
> @@ -260,6 +273,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
>  	if (data->irq < 0)
>  		return data->irq;
>  
> +	if (np && of_get_property(np, "fsl,poweroff", NULL)) {
> +		snvs_base = data->ioaddr;
> +		pm_power_off = snvs_poweroff;
> +	}
> +
>  	platform_set_drvdata(pdev, data);
>  
>  	spin_lock_init(&data->lock);
> -- 
> 1.9.1
> 

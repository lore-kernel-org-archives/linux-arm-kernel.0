From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Aug 2015 12:25:32 +0100
Subject: [PATCH v3 1/1][Resend] misc: sram: add dev_pm_ops to support
 module power gate
In-Reply-To: <1440540187-6208-1-git-send-email-shenwei.wang@freescale.com>
References: <1440540187-6208-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <55DDA22C.4090408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/15 23:03, Shenwei Wang wrote:
> When system goes into low power states like SUSPEND_MEM and
> HIBERNATION, the hardware IP block may be powered off to reduce
> the power consumption. This power down will lost all the
> data inside the ram. This patch added the dev_pm_ops and
> implemented two callbacks: suspend_noirq and resume_noirq, which
> will save the data in the on-chip-ram right before power down
> and restore it after system resumes.
>
> A new property string named "can-power-gate" is added to
> the devicetree bindings too.
>
> Based-on-a-patch-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
>
> ---
> Change log:
>
> PATCH v3
> 	Removed the unnecessary clk_enable/clk_disable.
>
> PATCH v2
> 	Use vmalloc to allocate the SRAM backup memory.
> 	Code clean up.
>
>   Documentation/devicetree/bindings/misc/sram.txt |  2 ++
>   drivers/misc/sram.c                             | 42 +++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
> index 36cbe5a..1170086 100644
> --- a/Documentation/devicetree/bindings/misc/sram.txt
> +++ b/Documentation/devicetree/bindings/misc/sram.txt
> @@ -33,6 +33,8 @@ Optional properties in the area nodes:
>
>   - compatible : standard definition, should contain a vendor specific string
>                  in the form <vendor>,[<device>-]<usage>
> +- can-power-gate: a property to tell the driver that the sram can support
> +		power gate
>
>   Example:
>
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 15c33cc..db9f1fa 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -30,7 +30,9 @@
>
>   struct sram_dev {
>   	struct device *dev;
> +	void *power_off_save;
>   	void __iomem *virt_base;
> +	u32 size;
>
>   	struct gen_pool *pool;
>   	struct clk *clk;
> @@ -156,6 +158,33 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
>   	return ret;
>   }
>
> +static int sram_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	/* Save necessary regs */
> +	memcpy(sram->power_off_save, sram->virt_base, sram->size);
> +
> +	return 0;
> +}
> +
> +static int sram_resume_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sram_dev *sram = platform_get_drvdata(pdev);
> +
> +	if (!sram->power_off_save)
> +		return 0;
> +
> +	memcpy(sram->virt_base, sram->power_off_save, sram->size);

As I objected in the original thread[1], I am just iterating myself here
again. IMO this is unnecessary and can be avoided. It's also not
scalable for large SRAM. I *still can't understand* what's the use-case
where you need to save/restore the entire SRAM content.

I see it's mostly used for audio/video and some crypto use-case(in the
mainline). In most of those cases, when you enter S2R, all the devices
*needs to be in quiescent state* which implies they no longer use SRAM.
So can you please care to provide your reasons for this save/restore ?

On some platforms, it's used for PM in which case it needs to be always on.

Regards,
Sudeep

[1] http://www.spinics.net/lists/arm-kernel/msg441449.html

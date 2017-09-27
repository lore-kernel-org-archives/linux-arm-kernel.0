From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Wed, 27 Sep 2017 16:48:46 +0100
Subject: [PATCH v10 6/7] perf: cavium: Support transmit-link PMU counters
In-Reply-To: <20170925123502.17289-7-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
 <20170925123502.17289-7-jglauber@cavium.com>
Message-ID: <20170927164846.00001cbe@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Sep 2017 14:35:01 +0200
Jan Glauber <jglauber@cavium.com> wrote:

> Add support for the transmit-link (OCX TLK) PMU counters found
> on Caviums SOCs with a processor interconnect.
> 
> Properties of the OCX TLK counters:
> - per-unit control
> - fixed purpose
> - writable
> - one PCI device with multiple TLK units
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Something odd happened in
drivers/soc/cavium/Kconfig...

Otherwise whole series looks sensible to me.

Jonathan

> ---
>  drivers/perf/Kconfig            |   7 ++
>  drivers/perf/cavium_pmu.c       | 230 ++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/cavium/Kconfig      |   4 +
>  drivers/soc/cavium/cavium_ocx.c |   4 +
>  include/linux/soc/cavium/ocx.h  |   3 +
>  5 files changed, 248 insertions(+)
> 

<snip>

>  static int __init cvm_pmu_init(void)
>  {
>  	INIT_LIST_HEAD(&cvm_pmu_lmcs);
> diff --git a/drivers/soc/cavium/Kconfig b/drivers/soc/cavium/Kconfig
> index fe56503d20f4..2c7406872b18 100644
> --- a/drivers/soc/cavium/Kconfig
> +++ b/drivers/soc/cavium/Kconfig
> @@ -8,3 +8,7 @@ config CAVIUM_LMC
>  config CAVIUM_OCX
>  	depends on ARCH_THUNDER
>  	def_tristate m
> +
> +config CAVIUM_OCX
> +        depends on ARCH_THUNDER
> +	def_tristate m

Something odd going on here...

> diff --git a/drivers/soc/cavium/cavium_ocx.c b/drivers/soc/cavium/cavium_ocx.c
> index fa3341b0744f..de1ad146c0dd 100644
> --- a/drivers/soc/cavium/cavium_ocx.c
> +++ b/drivers/soc/cavium/cavium_ocx.c
> @@ -13,6 +13,8 @@
>  static int cvm_ocx_probe(struct pci_dev *pdev,
>  			 const struct pci_device_id *ent)
>  {
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU_OCX_TLK))
> +		cvm_ocx_tlk_pmu_probe(pdev, ent);
>  	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
>  		thunderx_edac_ocx_probe(pdev, ent);
>  	return 0;
> @@ -20,6 +22,8 @@ static int cvm_ocx_probe(struct pci_dev *pdev,
>  
>  static void cvm_ocx_remove(struct pci_dev *pdev)
>  {
> +	if (IS_ENABLED(CONFIG_CAVIUM_PMU_OCX_TLK))
> +		cvm_ocx_tlk_pmu_remove(pdev);
>  	if (IS_ENABLED(CONFIG_EDAC_THUNDERX))
>  		thunderx_edac_ocx_remove(pdev);
>  }
> diff --git a/include/linux/soc/cavium/ocx.h b/include/linux/soc/cavium/ocx.h
> index 29f55b3d3171..f7b2caada671 100644
> --- a/include/linux/soc/cavium/ocx.h
> +++ b/include/linux/soc/cavium/ocx.h
> @@ -3,6 +3,9 @@
>  
>  #include <linux/pci.h>
>  
> +int cvm_ocx_tlk_pmu_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
> +void cvm_ocx_tlk_pmu_remove(struct pci_dev *pdev);
> +
>  int thunderx_edac_ocx_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
>  void thunderx_edac_ocx_remove(struct pci_dev *pdev);
>  

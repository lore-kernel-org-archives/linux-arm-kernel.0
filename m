From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 May 2018 09:43:55 +0100
Subject: [RFC 2/2] nvmem: zynqmp: Added zynqmp nvmem firmware driver
In-Reply-To: <20180324174638.12621-2-chinnikishore369@gmail.com>
References: <20180324174638.12621-1-chinnikishore369@gmail.com>
 <20180324174638.12621-2-chinnikishore369@gmail.com>
Message-ID: <4b6a5199-6226-965a-5dc0-f796f83a128e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/18 17:46, chinnikishore369 at gmail.com wrote:
> From: Nava kishore Manne <navam@xilinx.com>
> 
> This patch adds zynqmp nvmem firmware driver to access the
> SoC revision information from the hardware register.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>   drivers/nvmem/Kconfig        |  9 +++++
>   drivers/nvmem/Makefile       |  2 ++
>   drivers/nvmem/zynqmp_nvmem.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 96 insertions(+)
>   create mode 100644 drivers/nvmem/zynqmp_nvmem.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ff505af064ba..a9349281d05a 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -175,4 +175,13 @@ config NVMEM_SNVS_LPGPR
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-snvs-lpgpr.
>   
> +config NVMEM_ZYNQMP
> +        bool "Xilinx ZYNQMP SoC nvmem firmware support"
> +        depends on ARCH_ZYNQMP
> +        help
> +          This is a driver to access hardware related data like soc revision,
> +          IDCODE... etc.
> +
> +          If sure, say yes. If unsure, say no.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index e54dcfa6565a..932b4cebcb6c 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -37,3 +37,5 @@ obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
>   nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
>   obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
>   nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
> +obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
> +nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c

...
> +
> +static int zynqmp_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem;
> +
> +	econfig.dev = &pdev->dev;
> +	econfig.reg_read = zynqmp_nvmem_read;
> +
> +	nvmem = nvmem_register(&econfig);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
You could use devm version of this..

> +	platform_set_drvdata(pdev, nvmem);
> +
> +	return 0;
> +}
> 
...

> +module_platform_driver(zynqmp_nvmem_driver);
> +
> +MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
> +MODULE_DESCRIPTION("ZynqMP NVMEM driver");
> +MODULE_LICENSE("GPL");
> 

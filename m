From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Oct 2014 15:09:30 -0700
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Oh, a few more comments:

On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index c32d31981be3..1c932e7e7b8d 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  += fsl-corenet-cf.o
>  obj-$(CONFIG_FSL_IFC)          += fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)     += mvebu-devbus.o
>  obj-$(CONFIG_TEGRA20_MC)       += tegra20-mc.o
> -obj-$(CONFIG_TEGRA30_MC)       += tegra30-mc.o
> +
> +obj-$(CONFIG_ARCH_TEGRA)       += tegra/
> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
> new file mode 100644
> index 000000000000..51b9e8fcde1b
> --- /dev/null
> +++ b/drivers/memory/tegra/Makefile
> @@ -0,0 +1,5 @@
> +obj-y                                   = tegra-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                += tegra30-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       += tegra114-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       += tegra124-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       += tegra124-mc.o

You'll need a Kconfig and not just a makefile -- there are definitely
dependencies on this driver (IOMMU in particular).


Also, the problem of having a global enable bit that is only under
control of TrustZone FW is a big problem -- if the bit is not set, the
driver will not work (and the machine will crash).

I think you'll need to come up with a way to detect that in the
driver. I don't have a good idea of how it can be done though.


-Olof

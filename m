From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 7 May 2017 22:25:07 +0200
Subject: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
In-Reply-To: <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCDw2xhfgE69jhxAqExaOsKv+Q1VGXAJaiSgvQMFQQJwFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 6, 2017 at 7:18 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add a driver for the SDIO/MMC host found on the Amlogic Meson SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
>
> The controller provides an internal "mux" which allows connecting up to
> three MMC devices to it. Only one device can be used at a time though
> since the registers are shared across all devices. The driver takes care
> of synchronizing access (similar to the dw_mmc driver).
> The maximum supported bus-width is 4-bits.
>
> Amlogic's GPL kernel sources call the corresponding driver "aml_sdio" to
> differentiate it from the other MMC controller in (at least the Meson8
> and Meson8b) the SoCs (they call the other drivers aml_sdhc and
> aml_sdhc_m8, which seem to support a bus-width of up to 8-bits).
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/mmc/host/Kconfig         |  12 +
>  drivers/mmc/host/Makefile        |   1 +
>  drivers/mmc/host/meson-mx-sdio.c | 978 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 991 insertions(+)
>  create mode 100644 drivers/mmc/host/meson-mx-sdio.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a638cd0d80be..c557482ae327 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -343,6 +343,18 @@ config MMC_MESON_GX
>
>           If you have a controller with this interface, say Y here.
>
> +config MMC_MESON_MX_SDIO
> +       tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
> +       depends on ARCH_MESON || COMPILE_TEST
> +       depends on HAS_DMA
> +       depends on OF
just got an email from the kbuild test robot reminding me that I
missed a COMMON_CLK dependency here. not a big deal - I'll fix this in
the next version

> +       help
> +         This selects support for the SD/MMC Host Controller on
> +         Amlogic Meson6, Meson8 and Meson8b SoCs.
> +
> +         If you have a controller with this interface, say Y or M here.
> +         If unsure, say N.
> +
>  config MMC_MOXART
>         tristate "MOXART SD/MMC Host Controller support"
>         depends on ARCH_MOXART && MMC
[snip]

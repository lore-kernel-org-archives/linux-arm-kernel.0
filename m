From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Tue, 27 Dec 2016 11:05:24 +0100
Subject: [PATCH 1/6] ARM: mach-mx31_3ds: Remove camera support
In-Reply-To: <1482756987-12414-1-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
Message-ID: <CAM=E1R4L+BtFqAdRCUFzaZLkuZ7+8KUxO9iTkDqRz94RrOrz0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 26 December 2016 at 13:56, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
> mx3 driver") the mx3 camera driver has been removed, so remove the camera
> support from the board file as well.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/mach-imx/mach-mx31_3ds.c | 145 --------------------------------------
>  1 file changed, 145 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index 12b8a52..ada29d0 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
...
> -#define MX31_3DS_GPIO_CAMERA_PW IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
> -#define MX31_3DS_GPIO_CAMERA_RST IOMUX_TO_GPIO(MX31_PIN_RI_DTE1)
> -
> -static struct gpio mx31_3ds_camera_gpios[] = {
> -       { MX31_3DS_GPIO_CAMERA_PW, GPIOF_OUT_INIT_HIGH, "camera-power" },
> -       { MX31_3DS_GPIO_CAMERA_RST, GPIOF_OUT_INIT_HIGH, "camera-reset" },
> -};
...
>  static void __init mx31_3ds_late(void)
>  {
> -       int ret;
> -
>         mx31_3ds_spi_devs[0].irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
>         spi_register_board_info(mx31_3ds_spi_devs,
>                                 ARRAY_SIZE(mx31_3ds_spi_devs));
>
> -       platform_add_devices(devices, ARRAY_SIZE(devices));
> -
>         mx31_3ds_usbotg_init();
>         if (otg_mode_host) {
>                 otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
> @@ -751,17 +625,6 @@ static void __init mx31_3ds_late(void)
>                        "devices on the debug board are unusable.\n");
>
>         imx31_add_mxc_mmc(0, &sdhc1_pdata);
> -
> -       /* CSI */
> -       /* Camera power: default - off */
> -       ret = gpio_request_array(mx31_3ds_camera_gpios,
> -                                ARRAY_SIZE(mx31_3ds_camera_gpios));
> -       if (ret) {
> -               pr_err("Failed to request camera gpios");
> -               iclink_ov2640.power = NULL;
> -       }

CSI_D5 is marked as "not floating" by default, as opposed to "input,
pulled up" on many other pins on the i.MX31. That makes me wonder if
it's best to keep the initialization of CSI_D5 and RI_DTE1 to make
sure the pins are set to a defined state (that also will set the
camera off).

Will test the patch on hardware in a couple of days.

Regards, Magnus

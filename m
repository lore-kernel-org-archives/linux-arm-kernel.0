From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 30 Nov 2010 12:43:30 +0200
Subject: [PATCH] Kirkwood: Add support for 6282 based QNAP devices
In-Reply-To: <20101129174440.GA14799@jirafa.cyrius.com>
References: <20101129174440.GA14799@jirafa.cyrius.com>
Message-ID: <AANLkTim=30kESuyy7b6xLtCSFY1J9o0PhR1privVsDbb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 7:44 PM, Martin Michlmayr <tbm@cyrius.com> wrote:
> Add support for the QNAP NAS devices based on Marvell's 6282 Kirkwood
> chip (TS-119P+, TS-219P+ and TS-419P+). ?The differences to the 6281
> based devices are:
> ?- Ethernet PHY address
> ?- GPIOs used for buttons (TS-119P+/TS-219P+)
>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
>
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -48,15 +48,15 @@ config MACH_TS219
> ? ? ? ?bool "QNAP TS-110, TS-119, TS-210, TS-219 and TS-219P Turbo NAS"
please add the new devices to the title as well.
> ? ? ? ?help
> ? ? ? ? ?Say 'Y' here if you want your kernel to support the
> - ? ? ? ? QNAP TS-110, TS-119, TS-210, TS-219 and TS-219P Turbo NAS
> - ? ? ? ? devices.
> + ? ? ? ? QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
> + ? ? ? ? TS-219P+ Turbo NAS devices.
>
> ?config MACH_TS41X
> ? ? ? ?bool "QNAP TS-410, TS-410U, TS-419P and TS-419U Turbo NAS"
> ? ? ? ?help
> ? ? ? ? ?Say 'Y' here if you want your kernel to support the
> - ? ? ? ? QNAP TS-410, TS-410U, TS-419P and TS-419U Turbo NAS
> - ? ? ? ? devices.
> + ? ? ? ? QNAP TS-410, TS-410U, TS-419P, TS-419P+ and TS-419U Turbo
> + ? ? ? ? NAS devices.
>
> ?config MACH_DOCKSTAR
> ? ? ? ?bool "Seagate FreeAgent DockStar"
> diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
> index 6710bd7..dc999c4 100644
> --- a/arch/arm/mach-kirkwood/ts219-setup.c
> +++ b/arch/arm/mach-kirkwood/ts219-setup.c
> @@ -80,15 +80,19 @@ static unsigned int qnap_ts219_mpp_config[] __initdata = {
> ? ? ? ?MPP11_UART0_RXD,
> ? ? ? ?MPP13_UART1_TXD, ? ? ? ?/* PIC controller */
> ? ? ? ?MPP14_UART1_RXD, ? ? ? ?/* PIC controller */
> - ? ? ? MPP15_GPIO, ? ? ? ? ? ? /* USB Copy button */
> - ? ? ? MPP16_GPIO, ? ? ? ? ? ? /* Reset button */
> + ? ? ? MPP15_GPIO, ? ? ? ? ? ? /* USB Copy button (on devices with 88F6281) */
> + ? ? ? MPP16_GPIO, ? ? ? ? ? ? /* Reset button (on devices with 88F6281) */
> ? ? ? ?MPP36_GPIO, ? ? ? ? ? ? /* RAM: 0: 256 MB, 1: 512 MB */
> + ? ? ? MPP37_GPIO, ? ? ? ? ? ? /* Reset button (on devices with 88F6282) */
> + ? ? ? MPP43_GPIO, ? ? ? ? ? ? /* USB Copy button (on devices with 88F6282) */
> ? ? ? ?MPP44_GPIO, ? ? ? ? ? ? /* Board ID: 0: TS-11x, 1: TS-21x */
> ? ? ? ?0
> ?};
>
> ?static void __init qnap_ts219_init(void)
> ?{
> + ? ? ? u32 dev, rev;
> +
> ? ? ? ?/*
> ? ? ? ? * Basic setup. Needs to be called early.
> ? ? ? ? */
> @@ -100,6 +104,14 @@ static void __init qnap_ts219_init(void)
> ? ? ? ?qnap_tsx1x_register_flash();
> ? ? ? ?kirkwood_i2c_init();
> ? ? ? ?i2c_register_board_info(0, &qnap_ts219_i2c_rtc, 1);
> +
> + ? ? ? kirkwood_pcie_id(&dev, &rev);
> + ? ? ? if (dev == MV88F6282_DEV_ID) {
> + ? ? ? ? ? ? ? qnap_ts219_buttons[0].gpio = 43; /* USB Copy button */
> + ? ? ? ? ? ? ? qnap_ts219_buttons[1].gpio = 37; /* Reset button */
> + ? ? ? ? ? ? ? qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
> + ? ? ? }
> +
> ? ? ? ?kirkwood_ge00_init(&qnap_ts219_ge00_data);
> ? ? ? ?kirkwood_sata_init(&qnap_ts219_sata_data);
> ? ? ? ?kirkwood_ehci_init();
> diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
> index 3587a28..9a44029 100644
> --- a/arch/arm/mach-kirkwood/ts41x-setup.c
> +++ b/arch/arm/mach-kirkwood/ts41x-setup.c
> @@ -119,6 +119,8 @@ static unsigned int qnap_ts41x_mpp_config[] __initdata = {
>
> ?static void __init qnap_ts41x_init(void)
> ?{
> + ? ? ? u32 dev, rev;
> +
> ? ? ? ?/*
> ? ? ? ? * Basic setup. Needs to be called early.
> ? ? ? ? */
> @@ -130,8 +132,15 @@ static void __init qnap_ts41x_init(void)
> ? ? ? ?qnap_tsx1x_register_flash();
> ? ? ? ?kirkwood_i2c_init();
> ? ? ? ?i2c_register_board_info(0, &qnap_ts41x_i2c_rtc, 1);
> +
> + ? ? ? kirkwood_pcie_id(&dev, &rev);
> + ? ? ? if (dev == MV88F6282_DEV_ID) {
> + ? ? ? ? ? ? ? qnap_ts41x_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
> + ? ? ? ? ? ? ? qnap_ts41x_ge01_data.phy_addr = MV643XX_ETH_PHY_ADDR(1);
> + ? ? ? }
> ? ? ? ?kirkwood_ge00_init(&qnap_ts41x_ge00_data);
> ? ? ? ?kirkwood_ge01_init(&qnap_ts41x_ge01_data);
> +
> ? ? ? ?kirkwood_sata_init(&qnap_ts41x_sata_data);
> ? ? ? ?kirkwood_ehci_init();
> ? ? ? ?platform_device_register(&qnap_ts41x_button_device);
>
> --
> Martin Michlmayr
> http://www.cyrius.com/
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Mar 2011 11:39:31 -0800
Subject: [PATCH 1/3] ARM: tegra: seaboard: register i2c devices
In-Reply-To: <AANLkTin6kCEnOFuua70ze4D3igtZuUEVTNRf4zq-qD4D@mail.gmail.com>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<1299486399-21761-2-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF045687B855@HQMAIL01.nvidia.com>
	<AANLkTin6kCEnOFuua70ze4D3igtZuUEVTNRf4zq-qD4D@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687B8E2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Monday, March 07, 2011 12:30 PM:
> [oops, missed reply-all]
> 
> Hi,
> 
> On Mon, Mar 7, 2011 at 9:24 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Monday, March 07, 2011 1:27 AM:
> >> Register the base i2c devices on seaboard. A few more are pending,
> >> but it's a start.
> >>
> >> Signed-off-by: Olof Johansson <olof@lixom.net>
> >> ---
> >> ?arch/arm/mach-tegra/board-seaboard-pinmux.c | ? ?1 +
> >> ?arch/arm/mach-tegra/board-seaboard.c ? ? ? ?| ? 83
> >> +++++++++++++++++++++++++++
> >> ?2 files changed, 84 insertions(+), 0 deletions(-)
>...
> >> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
> >> +
> >> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
> >> +
> >> + ? ? common_i2c_init();
> >> +}
> >> +
> >> +static void __init kaen_i2c_init(void)
> >> +{
> >
> > {seaboard,kaen,wario}_i2c_init seem identical. Should this be a single
> > shared function, and only the board-specific bits in the non-common
> > functions? Also, see below.
> 
> They are now -- they weren't when all i2c devices were registered. I
> can re-join them and split them when devices are re-introduced later.

Perhaps move the common code into common_i2c_init, then put only the
differences in ${boardname}_i2c_init(), which would currently be empty
except to call the common function?

> >> + ? ? gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
> >> + ? ? gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
> >> +
> >> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
> >> +
> >> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
> >> +
> >> + ? ? common_i2c_init();
> >> +}
> >> +
> >> +static void __init wario_i2c_init(void)
> >> +{
> >> + ? ? gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
> >> + ? ? gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
> >> +
> >> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
> >> +
> >> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
> >> +
> >> + ? ? common_i2c_init();
> >> +}
> >> +
> >> ?static void __init __tegra_seaboard_init(void)
> >> ?{
> >> ? ? ? seaboard_pinmux_init();
> >> @@ -145,6 +222,8 @@ static void __init tegra_seaboard_init(void)
> >> ? ? ? debug_uart_platform_data[0].irq = INT_UARTD;
> >>
> >> ? ? ? __tegra_seaboard_init();
> >> +
> >> + ? ? seaboard_i2c_init();
> >> ?}
> >>
> >> ?static void __init tegra_kaen_init(void)
> >> @@ -155,6 +234,8 @@ static void __init tegra_kaen_init(void)
> >> ? ? ? debug_uart_platform_data[0].irq = INT_UARTB;
> >>
> >> ? ? ? __tegra_seaboard_init();
> >
> > __tegra_seaboard_init calls seaboard_i2c_init.
> 
> It shouldn't be (note __tegra* vs tegra*). Maybe I should rename
> __tegra_seaboard_init to something less alike.

Oh right. I double-checked that, but made the same reading mistake
both times; the __ version appeared right above the diff, so I 
must have skipped reading the @@ line.

> >
> >> +
> >> + ? ? kaen_i2c_init();
> >
> > kaen_i2c_init is the same as seaboard_i2c_init.
> >
> > So, all the registration happens twice?
> 
> Shouldn't be. The code I am looking at doesn't, so please check your side
> again?

Yes, it looks functionally OK when read correctly.

If you want, I can ack this, but perhaps reworking the code duplication
and making that __tegra_seaboard_init rename would make sense;
common_seaboard_init or common_board_init?

-- 
nvpublic

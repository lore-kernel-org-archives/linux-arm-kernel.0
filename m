From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 11:29:53 -0800
Subject: [PATCH 1/3] ARM: tegra: seaboard: register i2c devices
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF045687B855@HQMAIL01.nvidia.com>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
	<1299486399-21761-2-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF045687B855@HQMAIL01.nvidia.com>
Message-ID: <AANLkTin6kCEnOFuua70ze4D3igtZuUEVTNRf4zq-qD4D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[oops, missed reply-all]

Hi,

On Mon, Mar 7, 2011 at 9:24 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Monday, March 07, 2011 1:27 AM:
>> Register the base i2c devices on seaboard. A few more are pending,
>> but it's a start.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> ?arch/arm/mach-tegra/board-seaboard-pinmux.c | ? ?1 +
>> ?arch/arm/mach-tegra/board-seaboard.c ? ? ? ?| ? 83
>> +++++++++++++++++++++++++++
>> ?2 files changed, 84 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-
>> tegra/board-seaboard-pinmux.c
>> index 7e96d49..d84d1dd 100644
>> --- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
>> +++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
>> @@ -166,6 +166,7 @@ static struct tegra_gpio_table gpio_table[] = {
>> ? ? ? { .gpio = TEGRA_GPIO_SD2_POWER, ? ? ? ? .enable = true },
>> ? ? ? { .gpio = TEGRA_GPIO_LIDSWITCH, ? ? ? ? .enable = true },
>> ? ? ? { .gpio = TEGRA_GPIO_POWERKEY, ? ? ? ? ?.enable = true },
>> + ? ? { .gpio = TEGRA_GPIO_ISL29018_IRQ, ? ? ?.enable = true },
>
> The indentation between fields looks different there.

No, shouldn't be? I just checked the code, it uses the same whitespace
(tabs/spaces).
[...]

[...]

>> +static void __init seaboard_i2c_init(void)
>> +{
>> + ? ? gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
>> + ? ? gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
>
> Hmm. For some reason I thought drivers did this themselves, or IRQ
> registration did this for them. However, I looked and that's not true. I
> think I was remembering snd_soc_jack_add_gpios instead.
>
> So, this code looks fine, but I guess equivalent calls are missing for the
> WM8903 IRQ in my patches?

Yeah, probably.

>> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
>> +
>> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
>> +
>> + ? ? common_i2c_init();
>> +}
>> +
>> +static void __init kaen_i2c_init(void)
>> +{
>
> {seaboard,kaen,wario}_i2c_init seem identical. Should this be a single shared
> function, and only the board-specific bits in the non-common functions? Also,
> see below.

They are now -- they weren't when all i2c devices were registered. I
can re-join them and split them when devices are re-introduced later.



>
>> + ? ? gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
>> + ? ? gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
>> +
>> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
>> +
>> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
>> +
>> + ? ? common_i2c_init();
>> +}
>> +
>> +static void __init wario_i2c_init(void)
>> +{
>> + ? ? gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
>> + ? ? gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
>> +
>> + ? ? i2c_register_board_info(0, &isl29018_device, 1);
>> +
>> + ? ? i2c_register_board_info(4, &adt7461_device, 1);
>> +
>> + ? ? common_i2c_init();
>> +}
>> +
>> ?static void __init __tegra_seaboard_init(void)
>> ?{
>> ? ? ? seaboard_pinmux_init();
>> @@ -145,6 +222,8 @@ static void __init tegra_seaboard_init(void)
>> ? ? ? debug_uart_platform_data[0].irq = INT_UARTD;
>>
>> ? ? ? __tegra_seaboard_init();
>> +
>> + ? ? seaboard_i2c_init();
>> ?}
>>
>> ?static void __init tegra_kaen_init(void)
>> @@ -155,6 +234,8 @@ static void __init tegra_kaen_init(void)
>> ? ? ? debug_uart_platform_data[0].irq = INT_UARTB;
>>
>> ? ? ? __tegra_seaboard_init();
>
> __tegra_seaboard_init calls seaboard_i2c_init.

It shouldn't be (note __tegra* vs tegra*). Maybe I should rename
__tegra_seaboard_init to something less alike.

>
>> +
>> + ? ? kaen_i2c_init();
>
> kaen_i2c_init is the same as seaboard_i2c_init.
>
> So, all the registration happens twice?

Shouldn't be. The code I am looking at doesn't, so please check your side again?


-Olof

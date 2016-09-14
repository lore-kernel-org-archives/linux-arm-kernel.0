From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 16:37:53 +0200
Subject: [PATCH 3/4] ARM: orion5x: avoid NO_IRQ in orion_ge00_switch_init
In-Reply-To: <3683516.te4PblbMyt@wuerfel> (Arnd Bergmann's message of "Thu, 08
 Sep 2016 17:20:21 +0200")
References: <20160906140623.2853066-1-arnd@arndb.de>
 <20160906140623.2853066-3-arnd@arndb.de>
 <20160907020316.GC10007@lunn.ch> <3683516.te4PblbMyt@wuerfel>
Message-ID: <87k2eebl8e.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On jeu., sept. 08 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, September 7, 2016 4:03:16 AM CEST Andrew Lunn wrote:
>> On Tue, Sep 06, 2016 at 04:06:22PM +0200, Arnd Bergmann wrote:
>> > As of commit 5be9fc23cdb4 ("ARM: orion5x: fix legacy orion5x IRQ numbers"),
>> > IRQ zero is no longer a valid interrupt on Orion5x, so we can use the
>> > normal convention of using '0' to indicate an invalid interrupt, rather
>> > than the deprecated NO_IRQ constant
>> > 
>> > My first approach was to pass a pointer to the resource into
>> > orion_ge00_switch_init(), but it seemed to just add complexity
>> > for no good.
>> 
>> Hi Arnd
>> 
>> You can simply this. DSA has never as far as i remember used an
>> interrupt passed via platform data. Two boards do seem to pass an
>> interrupt via a GPIO line, but it has never been used.
>> 
>> So if you want, you could strip all this interrupt code out.
>> 
>> There might be some patches coming soon which does add interrupt
>> support to DSA, but it will only be via device tree, since i don't
>> have a platform which is capable of using platform data for DSA.
>
> Ok, good idea!
>
> This is what I came up with, let me know if I should repost the
> whole series with this.
>
> 	Arnd
>
> From 75669f969287e9479f280642d251c1bac68f8d7c Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 5 Sep 2016 16:18:45 +0200
> Subject: [PATCH] ARM: orion: simplify orion_ge00_switch_init
>
> One of the last users of NO_IRQ on ARM is the switch initialization
> code on orion5x, which sometimes passes a GPIO based IRQ number.
>
> However, the driver doesn't actually use this number, and according
> to Andrew Lunn never will do it for non-DT based machines, so
> we can simply drop the irq argument.
>
> Simplifying it further, we can also drop the static platform_device
> and instead call platform_device_register_data(), which in turn
> lets us mark the platform_data structures as __initdata and slightly
> reduce the memory consumption.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


I applied this version f the patch on mvebu/soc

Thanks,

Gregory

>
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 058994e99570..04910764c385 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -105,9 +105,9 @@ void __init orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data)
>  /*****************************************************************************
>   * Ethernet switch
>   ****************************************************************************/
> -void __init orion5x_eth_switch_init(struct dsa_platform_data *d, int irq)
> +void __init orion5x_eth_switch_init(struct dsa_platform_data *d)
>  {
> -	orion_ge00_switch_init(d, irq);
> +	orion_ge00_switch_init(d);
>  }
>  
>  
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index cd0389c6e822..8a4115bd441d 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -41,7 +41,7 @@ void orion5x_setup_wins(void);
>  void orion5x_ehci0_init(void);
>  void orion5x_ehci1_init(void);
>  void orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data);
> -void orion5x_eth_switch_init(struct dsa_platform_data *d, int irq);
> +void orion5x_eth_switch_init(struct dsa_platform_data *d);
>  void orion5x_i2c_init(void);
>  void orion5x_sata_init(struct mv_sata_platform_data *sata_data);
>  void orion5x_spi_init(void);
> diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> index c742e7b40b0d..dccadf68ea2b 100644
> --- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
> @@ -101,7 +101,7 @@ static struct dsa_chip_data rd88f5181l_fxo_switch_chip_data = {
>  	.port_names[7]	= "lan3",
>  };
>  
> -static struct dsa_platform_data rd88f5181l_fxo_switch_plat_data = {
> +static struct dsa_platform_data __initdata rd88f5181l_fxo_switch_plat_data = {
>  	.nr_chips	= 1,
>  	.chip		= &rd88f5181l_fxo_switch_chip_data,
>  };
> @@ -120,7 +120,7 @@ static void __init rd88f5181l_fxo_init(void)
>  	 */
>  	orion5x_ehci0_init();
>  	orion5x_eth_init(&rd88f5181l_fxo_eth_data);
> -	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data, NO_IRQ);
> +	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data);
>  	orion5x_uart0_init();
>  
>  	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> index 7e977b794b0c..affe5ec825de 100644
> --- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
> @@ -102,7 +102,7 @@ static struct dsa_chip_data rd88f5181l_ge_switch_chip_data = {
>  	.port_names[7]	= "lan3",
>  };
>  
> -static struct dsa_platform_data rd88f5181l_ge_switch_plat_data = {
> +static struct dsa_platform_data __initdata rd88f5181l_ge_switch_plat_data = {
>  	.nr_chips	= 1,
>  	.chip		= &rd88f5181l_ge_switch_chip_data,
>  };
> @@ -125,8 +125,7 @@ static void __init rd88f5181l_ge_init(void)
>  	 */
>  	orion5x_ehci0_init();
>  	orion5x_eth_init(&rd88f5181l_ge_eth_data);
> -	orion5x_eth_switch_init(&rd88f5181l_ge_switch_plat_data,
> -				gpio_to_irq(8));
> +	orion5x_eth_switch_init(&rd88f5181l_ge_switch_plat_data);
>  	orion5x_i2c_init();
>  	orion5x_uart0_init();
>  
> diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> index 8ffaead76771..67ee8571b03c 100644
> --- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> +++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
> @@ -40,7 +40,7 @@ static struct dsa_chip_data rd88f6183ap_ge_switch_chip_data = {
>  	.port_names[5]	= "cpu",
>  };
>  
> -static struct dsa_platform_data rd88f6183ap_ge_switch_plat_data = {
> +static struct dsa_platform_data __initdata rd88f6183ap_ge_switch_plat_data = {
>  	.nr_chips	= 1,
>  	.chip		= &rd88f6183ap_ge_switch_chip_data,
>  };
> @@ -89,8 +89,7 @@ static void __init rd88f6183ap_ge_init(void)
>  	 */
>  	orion5x_ehci0_init();
>  	orion5x_eth_init(&rd88f6183ap_ge_eth_data);
> -	orion5x_eth_switch_init(&rd88f6183ap_ge_switch_plat_data,
> -				gpio_to_irq(3));
> +	orion5x_eth_switch_init(&rd88f6183ap_ge_switch_plat_data);
>  	spi_register_board_info(rd88f6183ap_ge_spi_slave_info,
>  				ARRAY_SIZE(rd88f6183ap_ge_spi_slave_info));
>  	orion5x_spi_init();
> diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
> index 4e1e5c8f6111..4dbcdbe1de7c 100644
> --- a/arch/arm/mach-orion5x/wnr854t-setup.c
> +++ b/arch/arm/mach-orion5x/wnr854t-setup.c
> @@ -106,7 +106,7 @@ static struct dsa_chip_data wnr854t_switch_chip_data = {
>  	.port_names[7] = "lan2",
>  };
>  
> -static struct dsa_platform_data wnr854t_switch_plat_data = {
> +static struct dsa_platform_data __initdata wnr854t_switch_plat_data = {
>  	.nr_chips	= 1,
>  	.chip		= &wnr854t_switch_chip_data,
>  };
> @@ -124,7 +124,7 @@ static void __init wnr854t_init(void)
>  	 * Configure peripherals.
>  	 */
>  	orion5x_eth_init(&wnr854t_eth_data);
> -	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
> +	orion5x_eth_switch_init(&wnr854t_switch_plat_data);
>  	orion5x_uart0_init();
>  
>  	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> index 61e9027ef224..a6a8c4648d74 100644
> --- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> +++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
> @@ -191,7 +191,7 @@ static struct dsa_chip_data wrt350n_v2_switch_chip_data = {
>  	.port_names[7]	= "lan4",
>  };
>  
> -static struct dsa_platform_data wrt350n_v2_switch_plat_data = {
> +static struct dsa_platform_data __initdata wrt350n_v2_switch_plat_data = {
>  	.nr_chips	= 1,
>  	.chip		= &wrt350n_v2_switch_chip_data,
>  };
> @@ -210,7 +210,7 @@ static void __init wrt350n_v2_init(void)
>  	 */
>  	orion5x_ehci0_init();
>  	orion5x_eth_init(&wrt350n_v2_eth_data);
> -	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data, NO_IRQ);
> +	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data);
>  	orion5x_uart0_init();
>  
>  	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index 7b9b70785a54..272f49b2c68f 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -470,37 +470,15 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
>  /*****************************************************************************
>   * Ethernet switch
>   ****************************************************************************/
> -static struct resource orion_switch_resources[] = {
> -	{
> -		.start	= 0,
> -		.end	= 0,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct platform_device orion_switch_device = {
> -	.name		= "dsa",
> -	.id		= 0,
> -	.num_resources	= 0,
> -	.resource	= orion_switch_resources,
> -};
> -
> -void __init orion_ge00_switch_init(struct dsa_platform_data *d, int irq)
> +void __init orion_ge00_switch_init(struct dsa_platform_data *d)
>  {
>  	int i;
>  
> -	if (irq != NO_IRQ) {
> -		orion_switch_resources[0].start = irq;
> -		orion_switch_resources[0].end = irq;
> -		orion_switch_device.num_resources = 1;
> -	}
> -
>  	d->netdev = &orion_ge00.dev;
>  	for (i = 0; i < d->nr_chips; i++)
>  		d->chip[i].host_dev = &orion_ge_mvmdio.dev;
> -	orion_switch_device.dev.platform_data = d;
>  
> -	platform_device_register(&orion_switch_device);
> +	platform_device_register_data(NULL, "dsa", 0, d, sizeof(d));
>  }
>  
>  /*****************************************************************************
> diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
> index 8519727faa5e..9347f3c58a6d 100644
> --- a/arch/arm/plat-orion/include/plat/common.h
> +++ b/arch/arm/plat-orion/include/plat/common.h
> @@ -57,8 +57,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long mapbase,
>  			    unsigned long irq);
>  
> -void __init orion_ge00_switch_init(struct dsa_platform_data *d,
> -				   int irq);
> +void __init orion_ge00_switch_init(struct dsa_platform_data *d);
>  
>  void __init orion_i2c_init(unsigned long mapbase,
>  			   unsigned long irq,
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

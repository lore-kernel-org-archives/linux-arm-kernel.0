From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 10 Aug 2010 22:20:58 +0200
Subject: [PATCH] Added support board sbc9261-I v2
In-Reply-To: <1279037618-6293-1-git-send-email-andrei.pushkin@promwad.com>
References: <1279037618-6293-1-git-send-email-andrei.pushkin@promwad.com>
Message-ID: <AANLkTinPwOqfpFASLD+HPjRGnX1jcP7R2qyn_ANyQ9+2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Andrew,

> Added support board sbc9261 http://www.embedinfo.com/English/product/sbc9261-i.asp .

> +config SBC9261_100MHz
> + ? ? ? bool "99.5328 MHz"
> +
> +config SBC9261_120MHz
> + ? ? ? bool "119.8080 MHz"

These config options don't seem to select anything.


> +# AT91SAM9RL board-specific support
> +obj-$(CONFIG_MACH_SBC9261) ? ? ? ? ? ? += board-sbc9261.o

It's an AT91SAM9261-based board, so please add it to that section of
the Makefile.


> +/* EBI Chip Select 2 base address */
> +#define AT91C_EBI_CS2(0x30000000)

An unused define?
AT91_CHIPSELECT_2 is already defined in hardware,h

+       /*
+        * Configure Chip-Select 2 on SMC for the DM9000.
+        * Note: These timings were calculated for MASTER_CLOCK = 100000000
+        *  according to the DM9000 timings.
+        */
+       at91_sys_write(AT91_SMC_SETUP(2), \
+                                       AT91_SMC_NWESETUP_(2) |
+                                       AT91_SMC_NCS_WRSETUP_(0) |
+                                       AT91_SMC_NRDSETUP_(2) |
+                                       AT91_SMC_NCS_RDSETUP_(0));
+       at91_sys_write(AT91_SMC_PULSE(2), \
+                                       AT91_SMC_NWEPULSE_(4) |
+                                       AT91_SMC_NCS_WRPULSE_(8) |
+                                       AT91_SMC_NRDPULSE_(4) |
+                                       AT91_SMC_NCS_RDPULSE_(8));
+       at91_sys_write(AT91_SMC_CYCLE(2),
+                                       AT91_SMC_NWECYCLE_(16) |
+                                       AT91_SMC_NRDCYCLE_(16));
+       at91_sys_write(AT91_SMC_MODE(2),
+                                       AT91_SMC_READMODE |
+                                       AT91_SMC_WRITEMODE |
+                                       AT91_SMC_EXNWMODE_DISABLE |
+                                       AT91_SMC_BAT_WRITE |
+                                       AT91_SMC_DBW_16 |
+                                       AT91_SMC_TDF_(1));

Please rather use the sam9_smc_configure() mechanism to setting up the SMC.
You can look at arch/arm/mach-at91/board-sam9261ek.c for an example.


> +#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
> + ? ? ? .bus_width_16 ? = 1,
> +#else
> + ? ? ? .bus_width_16 ? = 0,
> +#endif

You don't need the "#else" section - it defaults to 0.


> +int mcp251x_setup(struct spi_device *spi)
> +{
> + ? ? ? printk(KERN_INFO "mcp251x_setup\n");
> + ? ? ? return 0;
> +}
> +
> +int mcp251x_power_enable(int enable)
> +{
> + ? ? ? printk(KERN_INFO "mcp251x_power_enable\n");
> + ? ? ? return 0;
> +}

Looks like left-over debugging code...


> +static struct mcp251x_platform_data mcp251x_data = {
> + ? ? ? .oscillator_frequency = 12 * 1000 * 1000,
> + ? ? ? .model = CAN_MCP251X_MCP2510,
> + ? ?.board_specific_setup = &mcp251x_setup,
> + ? ?.power_enable = mcp251x_power_enable,
> + ? ?.transceiver_enable = NULL,
> +};

Whitespace.


> +static struct platform_device sbc9261_cf_device = {
> + ? ? ? .name ? ? ? ? ? = "at91_cf",
> + ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? .dev ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &sbc9261_cf_data,
> + ? ? ? },
> + ? ? ? .resource ? ? ? = sbc9261_cf_resources,
> + ? ? ? .num_resources ?= ARRAY_SIZE(sbc9261_cf_resources),
> +};
> +static void __init sbc9261_add_device_cf(void)


The Compact Flash interface initialization should preferably be added
to the at91sam9261_devices.c file - like for the other AT91
processors.   Have a look at arch/arm/mach-at91/at91sam9263_devices.c
for an example.


> +MACHINE_START(SBC9261, "SBC9261")
> + ? ? ? /* Maintainer: Atmel */

You should rather be listed as maintainer for this board.


Regards,
  Andrew Victor

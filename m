From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 25 Mar 2012 17:34:41 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4OwhcFDMC4dWjU7x4u2CPT7C2BxVuCDkTN0j14gTndi3tA@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <201203231931.06376.arnd@arndb.de>
 <CAKON4OwhcFDMC4dWjU7x4u2CPT7C2BxVuCDkTN0j14gTndi3tA@mail.gmail.com>
Message-ID: <201203251734.41780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 March 2012, jonsmirl at gmail.com wrote:
> The dm9000 is on the LPC3131 reference design board. It is not our
> hardware so I'm not sure what it is doing with the GPIO pin. I'm
> porting the reference board code in the hopes that someone will help
> out in this effort.

Ok, so it's possible that nobody knows why the gpio read was put
in then and it might be completely bogus?

> Another piece of board specific glue is this bit that needs to be
> executed before accessing the dm9000. It puts the bus in the board's
> range in 8/16/32b mode, timings, etc.
> 
> static void __init ea_add_device_dm9000(void)
> {
>         /*
>          * Configure Chip-Select 2 on SMC for the DM9000.
>          * Note: These timings were calculated for MASTER_CLOCK = 90000000
>          *  according to the DM9000 timings.
>          */
>         MPMC_STCONFIG1 = 0x81;
>         MPMC_STWTWEN1 = 1;
>         MPMC_STWTOEN1 = 1;
>         MPMC_STWTRD1 = 4;
>         MPMC_STWTPG1 = 1;
>         MPMC_STWTWR1 = 1;
>         MPMC_STWTTURN1 = 2;
>         /* enable oe toggle between consec reads */
>         SYS_MPMC_WTD_DEL1 = _BIT(5) | 4;
> 

I would try to describe the MPMC static memory configuration using a device
node containing these, if you can't reliably move the configuration into the
boot loader itself.

In the device tree, this can look like:

/ {

	ahb {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		mpmc at 17008200 {
			compatible = "nxp,lpc31xx-mpmc";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x20000000 0x20000>; /* map to sram0 */
			reg = <0x17008200 0x20>;
			status = "disabled"; /* unused here */
		};

		mpmc at 17008220 {
			compatible = "nxp,lpc31xx-mpmc";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x20020000 0x20000>; /* map to sram1 */
			reg = <0x17008220 0x20>;

			/* mpmc configuration */
			mpmc-static-config     = <0x81>;
			mpmc-static-wait-wen   = <1>;
			mpmc-static-wait-oen   = <1>;
			mpmc-static-wait-rd    = <4>;
			mpmc-static-wait-page  = <1>;
			mpmc-static-wait-write = <1>;
			mpmc-static-wait-turn  = <2>;

			ethernet at 20020000 {
				compatible = "davicom,dm9000";
				reg = <0 100  10000 100>; /* local address */
				interrupts = <0x1>; /* ??? */
				gpios = <&gpio-i2stx 0>;
			}
		};
	};
};

This means you will need a driver for mpmc, but since all its code is only
run at boot time, it can live entirely in the init section.

	Arnd

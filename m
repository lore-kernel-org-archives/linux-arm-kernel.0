From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Dec 2013 20:19:51 +0100
Subject: [PATCH 6/6] at91: dt: sam9261: Added DM9000 in the device tree
In-Reply-To: <1388507534-10570-7-git-send-email-jjhiblot@traphandler.com>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
 <1388507534-10570-7-git-send-email-jjhiblot@traphandler.com>
Message-ID: <4526077.qASk8HSHKP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 December 2013 17:32:14 jjhiblot at traphandler.com wrote:
> 
> +                       ethernet at 30000000 {
> +                               compatible = "davicom,dm9000";
> +                               reg = <0x30000000 0x2 0x30000004 0x2>;
> +                               interrupt-parent = <&pioC>;
> +                               interrupts = <11 IRQ_TYPE_EDGE_BOTH>;
> +                               local-mac-address = [00 00 de ad be ef];
> +                               davicom,no-eeprom;
> +
> +                               smc,cs = <2>;
> +                               smc,ncs_read_setup = <0>;
> +                               smc,nrd_setup = <2>;
> +                               smc,ncs_write_setup = <0>;
> +                               smc,nwe_setup = <2>;
> +                               smc,ncs_read_pulse = <8>;
> +                               smc,nrd_pulse = <4>;
> +                               smc,ncs_write_pulse = <8>;
> +                               smc,nwe_pulse = <4>;
> +                               smc,read_cycle = <16>;
> +                               smc,write_cycle = <16>;
> +                               smc,tdf_cycles = <1>;
> +                               smc,tdf_optimized = <0>;
> +                               smc,page_size = <0>;
> +                               smc,byte_access_type = <1>;
> +                               smc,bus_width = <1>;
> +                               smc,nwait_mode = <0>;
> +                               smc,read_mode = <1>;
> +                               smc,write_mode = <1>;
> +                       };

I don't like how this forces you to mix the properties
of the ethernet device with the properties of the smc
port. I would also like to see the address translation
reflected in the DT nodes. This should probably just work
out if you restructure the DT representation, and won't need
changes in the driver.

How about this:

	smc: smc at ffffec00 {
		#address-cells = <2>; /* cs, address */
		#size-cells = <1>;
		ranges = <2 0 0x30000000 0x10000000>
			 <3 0 0x40000000 0x10000000>;

		extbus at 2.0 {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 2 0 0x10000000>;
			smc,ncs_read_setup = <0>;
			smc,nrd_setup = <2>;
			smc,...

			ethernet at 0 {
				compatible = "davicom,dm9000";
				reg = <0x0 0x2> <0x4 0x2>;
			};
		};
	};

If each bus interface has a fixed range of registers, you can actually
collapse the upper two nodes again and just have one device per
chipselect.

	Arnd

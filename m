From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 6 Jul 2013 01:35:47 +0200
Subject: [PATCH v6 00/21] MBus DT binding: PCIe strikes back
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130706013547.3ce7280b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Arnd,

On Fri,  5 Jul 2013 18:39:11 -0300, Ezequiel Garcia wrote:
> See the previous version of this patchset for further context:
> 
> http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg35753.html
> 
> This new proposal is an attempt to address some issues raised about the PCIe
> 'fake' windows mapping present in the previous version.
> 
> Instead of defining a 'fake' MBUS_ID(0xf0, 0x02) region for the whole
> PCIe memory and IO space, we use real target ID and attribute for the windows.
> 
> See the example below, where a somewhat complete device tree extract is shown:
> 
> 	soc {
> 		compatible = "marvell,armadaxp-mbus", "simple-bus";
> 		controller = <&mbusc>;
> 
> 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
> 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> 
> 		bootrom {
> 			compatible = "marvell,bootrom";
> 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
> 		};
> 
> 		devbus-bootcs {
> 			status = "okay";
> 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x8000000>;
> 
> 			/* NOR */
> 			nor {
> 				compatible = "cfi-flash";
> 				reg = <0 0x8000000>;
> 				bank-width = <2>;
> 			};
> 		};
> 
> 		pcie-controller {
> 			compatible = "marvell,armada-xp-pcie";
> 			status = "okay";
> 			device_type = "pci";
> 
> 			#address-cells = <3>;
> 			#size-cells = <2>;
> 
> 			ranges =
> 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> 				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> 				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
> 				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */>;
> 
> 
> 			pcie at 1,0 {
> 				/* Port 0, Lane 0 */
> 				status = "okay";
> 			};
> 		};
> 
> 		internal-regs {
> 			compatible = "simple-bus";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
> 
> 			mbusc: mbus-controller at 20000 {
> 				reg = <0x20000 0x100>, <0x20180 0x20>;
> 			};
> 
> 			interrupt-controller at 20000 {
> 			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> 			};
> 		};
> 	};

After a discussion with Arnd on IRC, here is the new DT layout we came
up with:

	soc {
		compatible = "marvell,armadaxp-mbus", "simple-bus";
		controller = <&mbusc>;

		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
		pcie-mem-aperture = <0xe0000000 0x8000000>;
                pcie-io-aperture  = <0xe8000000 0x100000>;

		bootrom {
			compatible = "marvell,bootrom";
			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
		};

		devbus-bootcs {
			status = "okay";
			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x8000000>;

			/* NOR */
			nor {
				compatible = "cfi-flash";
				reg = <0 0x8000000>;
				bank-width = <2>;
			};
		};

		pcie-controller {
			compatible = "marvell,armada-xp-pcie";
			status = "okay";
			device_type = "pci";

			#address-cells = <3>;
			#size-cells = <2>;

			ranges =
			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
				0x82000000 1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
				0x81000000 1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO */
                                0x82000000 2 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
                                0x81000000 2 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO */>;


                        pcie at 1,0 {
                                device_type = "pci";
                                assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
                                reg = <0x0800 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                ranges = <0x82000000 0 0 0x82000000 1 0 1 0
                                          0x81000000 0 0 0x81000000 1 0 1 0>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 58>;
                                marvell,pcie-port = <0>;
                                marvell,pcie-lane = <0>;
                                clocks = <&gateclk 5>;
                                status = "disabled";
                        };

                        pcie at 2,0 {
                                device_type = "pci";
                                assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
                                reg = <0x1000 0 0 0 0>;
                                #address-cells = <3>;
                                #size-cells = <2>;
                                #interrupt-cells = <1>;
                                ranges = <0x82000000 0 0 0x82000000 2 0 1 0
                                          0x81000000 0 0 0x81000000 2 0 1 0>;
                                interrupt-map-mask = <0 0 0 0>;
                                interrupt-map = <0 0 0 0 &mpic 62>;
                                marvell,pcie-port = <1>;
                                marvell,pcie-lane = <0>;
                                clocks = <&gateclk 9>;
                                status = "disabled";
                        };
		};

		internal-regs {
			compatible = "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;

			mbusc: mbus-controller at 20000 {
				reg = <0x20000 0x100>, <0x20180 0x20>;
			};

			interrupt-controller at 20000 {
			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
			};
		};
	};

I.e, the changes are :

 (1) The main soc {} node gains two new additional DT properties:
     pcie-mem-aperture and pcie-io-aperture. The mvebu-mbus reads those
     informations, and provides an API
     mvebu_mbus_alloc_pcie_{mem,io}_aperture(phys_addr_t *base, size_t
     *size) that allows the PCIe driver to get the mem and I/O
     apertures for PCIe. In the future, the mvebu-mbus driver may
     decide to allocate those apertures dynamically rather than have
     values hardcoded in the DT: this is the private business of
     mvebu-mbus. For now, the mvebu-mbus driver will use those static
     values from the DT, as we don't want to do a full dynamic window
     base address allocation for now. This makes sense, as mvebu-mbus
     is the "gake keeper" of what gets mapped in terms of mbus windows.

 (2) The ranges property of the main pcie-controller {} node is changed
     to use 0x82000000 and 0x81000000 for all PCIe interfaces, as requested
     by the OF spec. The second 32 bits word of the child address is used
     to encode the port number (in our example 1 for the first MEM and I/O
     ranges, and 2 for the next MEM and I/O ranges).

 (3) A non-empty range property is added in the child pcie at x,y nodes to
     translate back into regular PCIe addresses the child addresses
     described in the ranges property in pcie-controller. I.e, it
     simply translate (0x82000000 0 0) into (0x8200000 <port> 0).

Arnd, Jason, if you could confirm that you both agree with this DT
binding soon, Ezequiel and I would quickly adapt the code accordingly,
and hopefully converge towards a final patch set.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

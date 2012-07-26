From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:33:28 +0100
Subject: [PATCH 00/24] Introduce Xen support on ARM
Message-ID: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series implements Xen support for ARMv7 with virtualization
extensions.  It allows a Linux guest to boot as dom0 and
as domU on Xen on ARM. PV console, disk and network frontends and
backends are all working correctly.

It has been tested on a Versatile Express Cortex A15 emulator, using the
latest Xen, and a simple ad-hoc tool to build guest domains
(marc.info/?l=xen-devel&m=134089788016546).

The patch marked with [HACK] shouldn't be applied and is part of the
series only because it is needed to create domUs.

I am also attaching to this email the dts'es that I am currently using
for dom0 and domU: vexpress-v2p-ca15-tc1.dts is the dts used for dom0
and it is passed to Linux by Xen, while vexpress-virt.dts is the dts
used for other domUs and it is appended in binary form to the guest
kernel image. I am not sure where they are supposed to live yet, so I am
just attaching them here so that people can actually try out this series
if they want to.

Comments are very welcome!


Ian Campbell (2):
      ARM: enable earlyprintk=xen
      [HACK] xen/arm: implement xen_remap_domain_mfn_range

Stefano Stabellini (22):
      arm: initial Xen support
      xen/arm: hypercalls
      xen/arm: page.h definitions
      xen/arm: sync_bitops
      xen/arm: empty implementation of grant_table arch specific functions
      xen: missing includes
      xen/arm: Xen detection and shared_info page mapping
      xen/arm: Introduce xen_pfn_t for pfn and mfn types
      xen/arm: compile and run xenbus
      xen: do not compile manage, balloon, pci, acpi and cpu_hotplug on ARM
      xen/arm: introduce CONFIG_XEN on ARM
      xen/arm: Introduce xen_guest_init
      xen/arm: get privilege status
      xen/arm: initialize grant_table on ARM
      xen/arm: receive Xen events on ARM
      xen/arm: implement alloc/free_xenballooned_pages with alloc_pages/kfree
      xen: allow privcmd for HVM guests
      xen/arm: compile blkfront and blkback
      xen/arm: compile netback
      xen: update xen_add_to_physmap interface
      arm/v2m: initialize arch_timers even if v2m_timer is not present
      hvc_xen: allow dom0_write_console for HVM guests

 arch/arm/Kconfig                           |   10 ++
 arch/arm/Makefile                          |    1 +
 arch/arm/include/asm/hypervisor.h          |    6 +
 arch/arm/include/asm/sync_bitops.h         |   17 ++
 arch/arm/include/asm/xen/hypercall.h       |   69 ++++++++
 arch/arm/include/asm/xen/hypervisor.h      |   19 +++
 arch/arm/include/asm/xen/interface.h       |   66 ++++++++
 arch/arm/include/asm/xen/page.h            |   77 +++++++++
 arch/arm/kernel/early_printk.c             |   11 ++-
 arch/arm/mach-vexpress/v2m.c               |   11 +-
 arch/arm/xen/Makefile                      |    1 +
 arch/arm/xen/enlighten.c                   |  244 ++++++++++++++++++++++++++++
 arch/arm/xen/grant-table.c                 |   53 ++++++
 arch/arm/xen/hypercall.S                   |   65 ++++++++
 arch/ia64/include/asm/xen/interface.h      |    2 +-
 arch/x86/include/asm/xen/interface.h       |    2 +
 arch/x86/xen/enlighten.c                   |    9 +
 arch/x86/xen/irq.c                         |    1 +
 arch/x86/xen/xen-ops.h                     |    1 -
 drivers/block/xen-blkback/blkback.c        |    1 +
 drivers/net/xen-netback/netback.c          |    1 +
 drivers/net/xen-netfront.c                 |    1 +
 drivers/tty/hvc/hvc_xen.c                  |   14 +-
 drivers/xen/Makefile                       |    9 +-
 drivers/xen/events.c                       |   18 ++-
 drivers/xen/grant-table.c                  |    3 +-
 drivers/xen/privcmd.c                      |   20 +--
 drivers/xen/xenbus/xenbus_comms.c          |    2 +-
 drivers/xen/xenbus/xenbus_probe.c          |   27 ++--
 drivers/xen/xenbus/xenbus_probe_frontend.c |    1 +
 drivers/xen/xenbus/xenbus_xs.c             |    1 +
 drivers/xen/xenfs/super.c                  |    7 +
 include/xen/events.h                       |    2 +
 include/xen/interface/features.h           |    3 +
 include/xen/interface/grant_table.h        |    4 +-
 include/xen/interface/io/protocols.h       |    3 +
 include/xen/interface/memory.h             |   19 ++-
 include/xen/interface/platform.h           |    4 +-
 include/xen/interface/xen.h                |    9 +-
 include/xen/privcmd.h                      |    3 +-
 include/xen/xen.h                          |    4 +-
 41 files changed, 763 insertions(+), 58 deletions(-)


A branch based on 3.5-rc7 is available here:

git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git 3.5-rc7-arm-1

Cheers,

Stefano
-------------- next part --------------
/*
 * ARM Ltd. Versatile Express
 *
 * CoreTile Express A15x2 (version with Test Chip 1)
 * Cortex-A15 MPCore (V2P-CA15)
 *
 * HBI-0237A
 */

/dts-v1/;

/ {
	model = "V2P-CA15";
	arm,hbi = <0x237>;
	compatible = "arm,vexpress,v2p-ca15,tc1", "arm,vexpress,v2p-ca15", "arm,vexpress";

	#address-cells = <1>;
	#size-cells = <1>;

	interrupt-parent = <&gic>;

	chosen {
                 bootargs = "dom0_mem=128M";
                 xen,dom0-bootargs = "earlyprintk=xenboot console=ttyAMA1 root=/dev/mmcblk0 debug rw";
	};


	aliases {
		serial0 = &v2m_serial0;
		serial1 = &v2m_serial1;
		serial2 = &v2m_serial2;
		serial3 = &v2m_serial3;
		i2c0 = &v2m_i2c_dvi;
		i2c1 = &v2m_i2c_pcie;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu at 0 {
			device_type = "cpu";
			compatible = "arm,cortex-a15";
			reg = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0x80000000 0x80000000>;
	};

	gic: interrupt-controller at 2c001000 {
		compatible = "arm,cortex-a9-gic";
		#interrupt-cells = <3>;
		#address-cells = <0>;
		interrupt-controller;
		reg = <0x2c001000 0x1000>,
		      <0x2c002000 0x100>;
	};

	pmu {
		compatible = "arm,cortex-a9-pmu";
		interrupts = <0 68 4>,
			     <0 69 4>;
	};

	xen {
		compatible = "arm,xen";
		reg = <0xb0000000 0x20000>;
		interrupts = <1 15 0xf08>;
	};

	motherboard {
		ranges = <0 0 0x08000000 0x04000000>,
			 <1 0 0x14000000 0x04000000>,
			 <2 0 0x18000000 0x04000000>,
			 <3 0 0x1c000000 0x04000000>,
			 <4 0 0x0c000000 0x04000000>,
			 <5 0 0x10000000 0x04000000>;

		interrupt-map-mask = <0 0 63>;
		interrupt-map = <0 0  0 &gic 0  0 4>,
				<0 0  1 &gic 0  1 4>,
				<0 0  2 &gic 0  2 4>,
				<0 0  3 &gic 0  3 4>,
				<0 0  4 &gic 0  4 4>,
				<0 0  5 &gic 0  5 4>,
				<0 0  6 &gic 0  6 4>,
				<0 0  7 &gic 0  7 4>,
				<0 0  8 &gic 0  8 4>,
				<0 0  9 &gic 0  9 4>,
				<0 0 10 &gic 0 10 4>,
				<0 0 11 &gic 0 11 4>,
				<0 0 12 &gic 0 12 4>,
				<0 0 13 &gic 0 13 4>,
				<0 0 14 &gic 0 14 4>,
				<0 0 15 &gic 0 15 4>,
				<0 0 16 &gic 0 16 4>,
				<0 0 17 &gic 0 17 4>,
				<0 0 18 &gic 0 18 4>,
				<0 0 19 &gic 0 19 4>,
				<0 0 20 &gic 0 20 4>,
				<0 0 21 &gic 0 21 4>,
				<0 0 22 &gic 0 22 4>,
				<0 0 23 &gic 0 23 4>,
				<0 0 24 &gic 0 24 4>,
				<0 0 25 &gic 0 25 4>,
				<0 0 26 &gic 0 26 4>,
				<0 0 27 &gic 0 27 4>,
				<0 0 28 &gic 0 28 4>,
				<0 0 29 &gic 0 29 4>,
				<0 0 30 &gic 0 30 4>,
				<0 0 31 &gic 0 31 4>,
				<0 0 32 &gic 0 32 4>,
				<0 0 33 &gic 0 33 4>,
				<0 0 34 &gic 0 34 4>,
				<0 0 35 &gic 0 35 4>,
				<0 0 36 &gic 0 36 4>,
				<0 0 37 &gic 0 37 4>,
				<0 0 38 &gic 0 38 4>,
				<0 0 39 &gic 0 39 4>,
				<0 0 40 &gic 0 40 4>,
				<0 0 41 &gic 0 41 4>,
				<0 0 42 &gic 0 42 4>;
	};
};

/include/ "vexpress-v2m-rs1-rtsm.dtsi"
-------------- next part --------------
/*
 * ARM Ltd. Versatile Express
 *
 * ARM Envelope Model v7A (single CPU).
 */

/dts-v1/;

/include/ "skeleton.dtsi"

/ {
	model = "V2P-AEMv7A";
	compatible = "arm,vexpress,v2p-aem,v7a", "arm,vexpress,v2p-aem", "arm,vexpress";
	interrupt-parent = <&gic>;

        chosen {
                bootargs = "earlyprintk=xen debug loglevel=9 console=hvc0 root=/dev/xvda";
        };

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu at 0 {
			device_type = "cpu";
			compatible = "arm,cortex-a15";
			reg = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0x80000000 0x08000000>;
	};

	gic: interrupt-controller at 2c001000 {
		compatible = "arm,cortex-a9-gic";
		#interrupt-cells = <3>;
		#address-cells = <0>;
		interrupt-controller;
		reg = <0x2c001000 0x1000>,
		      <0x2c002000 0x100>;
	};

	timer {
		compatible = "arm,armv7-timer";
		interrupts = <1 13 0xf08>,
			     <1 14 0xf08>,
			     <1 11 0xf08>,
			     <1 10 0xf08>;
	};

	xen {
		compatible = "arm,xen";
		reg = <0xb0000000 0x20000>;
		interrupts = <1 15 0xf08>;
	};

	motherboard {
		ranges = <0 0 0x08000000 0x04000000>,
			 <1 0 0x14000000 0x04000000>,
			 <2 0 0x18000000 0x04000000>,
			 <3 0 0x1c000000 0x04000000>,
			 <4 0 0x0c000000 0x04000000>,
			 <5 0 0x10000000 0x04000000>;

		interrupt-map-mask = <0 0 63>;
		interrupt-map = <0 0  0 &gic 0  0 4>,
				<0 0  1 &gic 0  1 4>,
				<0 0  2 &gic 0  2 4>,
				<0 0  3 &gic 0  3 4>,
				<0 0  4 &gic 0  4 4>,
				<0 0  5 &gic 0  5 4>,
				<0 0  6 &gic 0  6 4>,
				<0 0  7 &gic 0  7 4>,
				<0 0  8 &gic 0  8 4>,
				<0 0  9 &gic 0  9 4>,
				<0 0 10 &gic 0 10 4>,
				<0 0 11 &gic 0 11 4>,
				<0 0 12 &gic 0 12 4>,
				<0 0 13 &gic 0 13 4>,
				<0 0 14 &gic 0 14 4>,
				<0 0 15 &gic 0 15 4>,
				<0 0 16 &gic 0 16 4>,
				<0 0 17 &gic 0 17 4>,
				<0 0 18 &gic 0 18 4>,
				<0 0 19 &gic 0 19 4>,
				<0 0 20 &gic 0 20 4>,
				<0 0 21 &gic 0 21 4>,
				<0 0 22 &gic 0 22 4>,
				<0 0 23 &gic 0 23 4>,
				<0 0 24 &gic 0 24 4>,
				<0 0 25 &gic 0 25 4>,
				<0 0 26 &gic 0 26 4>,
				<0 0 27 &gic 0 27 4>,
				<0 0 28 &gic 0 28 4>,
				<0 0 29 &gic 0 29 4>,
				<0 0 30 &gic 0 30 4>,
				<0 0 31 &gic 0 31 4>,
				<0 0 32 &gic 0 32 4>,
				<0 0 33 &gic 0 33 4>,
				<0 0 34 &gic 0 34 4>,
				<0 0 35 &gic 0 35 4>,
				<0 0 36 &gic 0 36 4>,
				<0 0 37 &gic 0 37 4>,
				<0 0 38 &gic 0 38 4>,
				<0 0 39 &gic 0 39 4>,
				<0 0 40 &gic 0 40 4>,
				<0 0 41 &gic 0 41 4>,
				<0 0 42 &gic 0 42 4>;
	};
};

/* /include/ "vexpress-v2m-rs1-rtsm.dtsi" */

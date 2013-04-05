From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Apr 2013 15:02:00 +0200
Subject: mvebu-mbus: defining a DT binding
Message-ID: <20130405150200.7b6dee63@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Arnd,

Now that the non-DT version of mvebu-mbus has been picked up by Jason
Cooper for 3.10, I'd like to start working on a proper DT binding for
mvebu-mbus, probably targeting 3.11. I've already started writing a bit
of code just to see how things were going, and I have a couple of
questions.

The last proposal from Jason Gunthorpe was the following one:

========================================================================

/* MAPDEF is a 2 dw value, top DW encodes the target id, bottom dword is
   usally 0. The special target id of '0' is no target/no window. */
#define MAPDEF(x,y,z) ((x << 16) | (y << 8) | z) 0
#define MAPDEF_INTERNAL MAPDEF(...)
[..]
#define PCI_MMIO_APERTURE 0xe0000000
#define PCI_IO_APERTURE 0xe8000000

mbus {
  ranges = <MAPDEF_INTERNAL 0xf1000000 0x100000
            MAPDEF_NAND     0xf4000000 0x10000
            MAPDEF_CRYPTO   0xf5000000 0x10000

 	    /* These two are *not* mbus windows but are required to
   	       model the PCI aperture abstraction. Windows are
	       allocated within these regions dynamically
               as neeed. */
            0 PCI_MMIO_APERTURE PCI_MMIO_APERTURE 0x08000000
            0 PCI_IO_APERTURE PCI_MMIO_APERTURE 0x00100000>
  #address-cells = <2>;
  [..]

  // Internal regs special target
  internal_regs at f1000000 {
       compatible = "simple-bus";
       ranges = <0x00000000 MAPDEF_INTERNAL 0x100000>;
       #address-cells = <1>;

       serial at 12000 {
              compatible = "ns16550a";
              reg = <0x12000 0x100>;
              reg-shift = <2>;
              interrupts = <33>;
        };
       [..]
  }

  // All the PCI-E targets
  pcie-controller {
     compatible = "marvell,armada-370-pcie";
     reg = <MAPDEF_INTERNAL + 0x40000 0x2000>,
           <MAPDEF_INTERNAL + 0x80000 0x2000>;
     ranges = <0x82000000 0 PCI_MMIO_APERTURE PCI_MMIO_APERTURE 0 0x08000000   /* non-prefetchable memory */
               0x81000000 0 0                 PCI_IO_APERTURE 0  0x00100000>; /* downstream I/O */
     [..]
     pcie at 0,0 {
          reg = <0x0800 0 0 0 0>;
          marvell,mbus-targets = <MAPDEF_PCIE0_MEM MAPDEF_PCIE0_IO>;
     }
  }

  // Target id 1,0x2f
  nand at 0xf4000000 {
          #address-cells = <1>;
          #size-cells = <1>;
          cle = <0>;
          ale = <1>;
          bank-width = <1>;
          compatible = "marvell,orion-nand";
          reg = <MAPDEF_NAND 0x400>;
  };

  // Target id 0x3,0x1
  crypto at f5000000 {
          reg = <MAPDEF_INTERNAL + 0x30000 0x10000>,
                <MAPDEF_CRYPTO 0x800>;
  }
}

========================================================================

It raises the following questions:

 * The address decoding windows are in fact defined by the ranges =
   <...> property of the mbus node. Here, in the example provided by
   Jason, this ranges = <...> property is part of the SoC-level .dtsi.
   However, some boards will have to add some board-specific windows
   (adjusted to the size of their NOR, or FPGA, for example).

   As far as I know, we can 'extend' an existing property in a .dts
   file, we have to completely overload it. So this means that boards
   wanting to add an additional address decoding window will have to
   copy/paste the 'ranges' property from the included .dtsi file and
   add their own entry. This is of course possible, but it doesn't look
   very nice: if a new window is added in the SoC-level .dtsi file for
   some reason, this change will have to be replicated on all the
   including .dts files that overload this ranges property.

   Is this the intended behavior?

 * I am not sure to understand why the nand, crypto and pcie-controller
   nodes are outside of the internal registers. Well, I understand it's
   because those devices need a special address decoding window. But it
   sounds strange because those devices also have internal registers
   (which is why Jason used 'MAPDEF_INTERNAL + offset' in the reg
   property).

   Is this really the desired DT binding?

 * Regarding the PCIe binding, Jason Gunthorpe suggests the use of a
   'marvell,mbus-targets' attribute so that the PCIe driver knows what
   target/attribute values to use to create the window. Currently, the
   PCIe driver uses a name (like "pcie0.3") that it gives to the
   mvebu-mbus driver, which then translates this name to the real
   target/attribute values using per-SoC tables that associate names
   (pcie0.3) with values (say 0x4 / 0x42).

   Is this marvell,mbus-targets really the suggested solution? This
   would basically mean that the entire name -> value mapping tables of
   the driver would ultimately become useless (note that I'm not
   necessarily saying it is bad, I just want to check where we are
   going before doing useless work). Of course, those tables would
   remain at the beginning, once all platforms are converted to the
   mvebu-mbus DT binding, which may take a bit of time since it requires
   quite a lot of code movement in the .dtsi/.dts files.

I already have some basic code in the mvebu-mbus driver that parses the
ranges = <...> property and creates the corresponding windows, it seems
to work fine.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

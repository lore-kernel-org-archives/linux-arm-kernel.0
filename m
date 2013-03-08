From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 12:47:55 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308164804.GR23237@titan.lakedaemon.net>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de>
 <20130307063513.GA31330@obsidianresearch.com>
 <20130308164804.GR23237@titan.lakedaemon.net>
Message-ID: <20130308194755.GB29435@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 11:48:04AM -0500, Jason Cooper wrote:
 
> Thanks to JasonG and Arnd for clearing up my misunderstandings.  The
> only thing I would really like to see at this point is a clear,
> thought-through migration path from Thomas' patches to JasonG's
> proposal.  Obviously, it would be nice if the proposer took a crack at
> this. ;-)

The patch to add the top level ranges is a bit major because it
restructures the DT to be organized by mbus target. It also would
depend on Steven's preprocesor patchset (for our own sanity).

To my mind this is best done after Thomas's work goes in, because it
is a complex change to the DT and has dependencies.

Eg kirkwood.dtsi would change to place, as best as possible, mbus
targets directly below the mbus top level. Here is a sample that shows
most of the main points:

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

Which then results in mirroring changes to all the including dts:

mbus {
        internal_regs at f1000000 {
                timer at 20300 {
                        clock-frequency = <166666667>;
                };
}

A word on the PCI aperture: It is possible to directly show the mbus
windows for PCI in the DT, and rely on runtime updating to keep
everything in sync with the dynamic choices made by the PCI driver,
but there is no point in doing all this work since we have no use for
this information within the DT. A simple CPU address range 'aperture'
to indicate where we want to place the PCI region is all that is
needed. If the region is someday selected dynamically then the two
ranges would be updated at runtime.

I think I can prepare a patch for this if we reach agreement, but I
can only test it on Kirkwood today.. Also, I'm guessing there is some
opinions on what should be after the @.. ?

>From there..

Future patches would have the mbus driver read the top level ranges at
boot and program those windows. Then we remove the code in the board
specific files that does the same.

For kirwood, move the PCI specific window setup code into the non-dt
pcie driver, and then we are ready to use Thomas's DT driver on
kirkwood.

When the non-DT code is removed many of the the tables in the mbus
driver can then be purged.

Future patches could support fully dyanmic window address assignment,
but I'm honestly having a hard time seeing a use case for this..

Jason

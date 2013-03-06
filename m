From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 12:08:21 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130306190821.GA4689@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 02:43:40PM +0100, Thomas Petazzoni wrote:

> The Marvell EBU SoCs have a configurable physical address space
> layout: the physical ranges of memory used to address PCI(e)
> interfaces, NOR flashes, SRAM and various other types of memory are
> configurable by software, through a mechanism of so-called 'address
> decoding windows'.

This is a nice forward step improvement, but I think it would be nicer
to read the HW specific information from the DT rather than encoding
it in tables in the driver. It would make the driver smaller and
simpler..

> +static const struct mvebu_mbus_mapping armada_370_map[] = {
> +	MAPDEF("bootrom",     1, 0xe0, MAPDEF_NOMASK),
> +	MAPDEF("devbus-boot", 1, 0x2f, MAPDEF_NOMASK),
> +	MAPDEF("devbus-cs0",  1, 0x3e, MAPDEF_NOMASK),
> +	MAPDEF("devbus-cs1",  1, 0x3d, MAPDEF_NOMASK),
> +	MAPDEF("devbus-cs2",  1, 0x3b, MAPDEF_NOMASK),
> +	MAPDEF("devbus-cs3",  1, 0x37, MAPDEF_NOMASK),
> +	MAPDEF("pcie0.0",     4, 0xe0, MAPDEF_PCIMASK),
> +	MAPDEF("pcie1.0",     8, 0xe0, MAPDEF_PCIMASK),
> +	{},
> +};

These tables could be encoded using the approach Arnd described:

/* 2 adress cell value with MAPDEF value (target attributes) in the
   first cell and 0 in the 2nd. */
#define MAPDEF(t,a,m) ((t<<16) | (a<<8) | m) 0

mbus {
   compatible = "marvell,mbus";
   #address-cells = <2>;
   #size-cells = <1>;
   regs = <...>

   windows = <0 1 2 3 4>;
   remappable-windows = <7 8 9>;
   internal-window = 5;

   // Names and numbers made up for illistration
   // The 2nd column is where to place the MBUS target in the CPU address map
   ranges < MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
            MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
            MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
             [..]

   // MBUS target for internal registers
   internal_regs {
       compatible = "simple-bus";
       ranges <MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0  0x10000>;
       #address-cells = <1>;
       #size-cells = <1>;

       // Serial controller at offset 0x3000 from the start of internal registers
       serial at 0x3000 {
           reg = <0x3000 0x100>;
       }
   }

   // MBUS target for boot rom
   bootrom {
       compatible = "simple-bus";
       ranges <MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0  0x10000>;
       #address-cells = <1>;
       #size-cells = <1>;
   }
}

Where:
  - The top ranges is the table 'mvebu_mbus_mapping', combined with
    the board specific code that sets the target CPU address. The
    mbus driver can directly setup mappings without requiring board
    support.
  - Something like the 'bootrom' bus is where devices under that
    window would be placed.

This also replaces code like this from the board files:

       mvebu_mbus_add_window("nand", KIRKWOOD_NAND_MEM_PHYS_BASE,
                             KIRKWOOD_NAND_MEM_SIZE);
       mvebu_mbus_add_window("sram", KIRKWOOD_SRAM_PHYS_BASE,
                             KIRKWOOD_SRAM_SIZE);

And lets us make the DT self-consistent with the value of
KIRKWOOD_SRAM_PHYS_BASE and others

> + * Some variants of Orion5x have 4 remappable windows, some other have
> + * only two of them.
> + */
> +static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
> +	.num_wins            = 8,
> +	.num_remappable_wins = 4,

These values also seem like something worth reading from the DT as
well.. See above for an idea.

Jason

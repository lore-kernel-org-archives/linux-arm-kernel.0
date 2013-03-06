From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 20:27:10 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306190821.GA4689@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
Message-ID: <20130306202710.15a6aa2c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Mar 2013 12:08:21 -0700, Jason Gunthorpe wrote:

> This is a nice forward step improvement, but I think it would be nicer
> to read the HW specific information from the DT rather than encoding
> it in tables in the driver. It would make the driver smaller and
> simpler..
> 
> > +static const struct mvebu_mbus_mapping armada_370_map[] = {
> > +	MAPDEF("bootrom",     1, 0xe0, MAPDEF_NOMASK),
> > +	MAPDEF("devbus-boot", 1, 0x2f, MAPDEF_NOMASK),
> > +	MAPDEF("devbus-cs0",  1, 0x3e, MAPDEF_NOMASK),
> > +	MAPDEF("devbus-cs1",  1, 0x3d, MAPDEF_NOMASK),
> > +	MAPDEF("devbus-cs2",  1, 0x3b, MAPDEF_NOMASK),
> > +	MAPDEF("devbus-cs3",  1, 0x37, MAPDEF_NOMASK),
> > +	MAPDEF("pcie0.0",     4, 0xe0, MAPDEF_PCIMASK),
> > +	MAPDEF("pcie1.0",     8, 0xe0, MAPDEF_PCIMASK),
> > +	{},
> > +};
> 
> These tables could be encoded using the approach Arnd described:
> 
> /* 2 adress cell value with MAPDEF value (target attributes) in the
>    first cell and 0 in the 2nd. */
> #define MAPDEF(t,a,m) ((t<<16) | (a<<8) | m) 0
> 
> mbus {
>    compatible = "marvell,mbus";
>    #address-cells = <2>;
>    #size-cells = <1>;
>    regs = <...>
> 
>    windows = <0 1 2 3 4>;
>    remappable-windows = <7 8 9>;
>    internal-window = 5;
> 
>    // Names and numbers made up for illistration
>    // The 2nd column is where to place the MBUS target in the CPU address map
>    ranges < MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
>             MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
>             MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
>              [..]
> 
>    // MBUS target for internal registers
>    internal_regs {
>        compatible = "simple-bus";
>        ranges <MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0  0x10000>;
>        #address-cells = <1>;
>        #size-cells = <1>;
> 
>        // Serial controller at offset 0x3000 from the start of internal registers
>        serial at 0x3000 {
>            reg = <0x3000 0x100>;
>        }
>    }
> 
>    // MBUS target for boot rom
>    bootrom {
>        compatible = "simple-bus";
>        ranges <MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0  0x10000>;
>        #address-cells = <1>;
>        #size-cells = <1>;
>    }
> }
> 
> Where:
>   - The top ranges is the table 'mvebu_mbus_mapping', combined with
>     the board specific code that sets the target CPU address. The
>     mbus driver can directly setup mappings without requiring board
>     support.
>   - Something like the 'bootrom' bus is where devices under that
>     window would be placed.
> 
> This also replaces code like this from the board files:
> 
>        mvebu_mbus_add_window("nand", KIRKWOOD_NAND_MEM_PHYS_BASE,
>                              KIRKWOOD_NAND_MEM_SIZE);
>        mvebu_mbus_add_window("sram", KIRKWOOD_SRAM_PHYS_BASE,
>                              KIRKWOOD_SRAM_SIZE);
> 
> And lets us make the DT self-consistent with the value of
> KIRKWOOD_SRAM_PHYS_BASE and others

I personally dislike this proposal quite a lot. I believe it puts way
too many things into the Device Tree. Seems like these days, people
want to write thousands of lines of data in Device Trees rather than
having drivers properly abstract the differences between SoC.

Also, I don't believe that windows should be described in the Device
Tree. My long term plan is rather to make the allocation of the base
address of each window entirely dynamic, because there is absolutely no
reason for those addresses to be fixed in stone in the Device Tree.

> 
> > + * Some variants of Orion5x have 4 remappable windows, some other have
> > + * only two of them.
> > + */
> > +static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
> > +	.num_wins            = 8,
> > +	.num_remappable_wins = 4,
> 
> These values also seem like something worth reading from the DT as
> well.. See above for an idea.

No: there will anyway be different functions to be called depending on
the SoC family. So the driver will anyway have to have different
compatible strings for the different SoC families, because we can't put
code into the Device Tree. So rather than having some of the
SoC-specific data encoded in the DT and some of the SoC-specific code
in the driver, I'd rather have all the SoC-specific things (data *and*
code) into the driver, and leave the DT only the responsibility of
telling which SoC variant we're running on, and where the window
registers are.

Another reason is that the DT bindings become part of the kernel ABI,
so they can't be changed once they are defined and have started to be
used seriously on production devices. This leads to a very simple
choice: limit the amount of things we put in the DT, and instead put
more of the internal logic into the driver.

So this was for the fundamental disagreement.

No, I also have a temporary disagreement: I think what you're asking is
way too far away from the current code. I've already been asked to make
gazillions of cleanups and changes to get the PCIe driver in, and I
don't think it's honest and reasonable to ask me to redo the entire
Marvell world just to get the PCIe driver in. I've already refactored
this address decoding stuff, which should make future evolutions much
easier. I've also taken care of migrating all the legacy SoC families.
So now asking me to rework the entire thing in one step, as a
requirement to get the PCIe stuff in, it's really going beyond what's
reasonable, I feel.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

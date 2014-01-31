From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 30 Jan 2014 20:44:03 -0800
Subject: recommended action for bootloaders regarding modifying
 device-tree nodes
In-Reply-To: <20140130211512.GD13372@obsidianresearch.com>
References: <CAJ+vNU366GiY4k_rnh1Jf0kra+PU99w4tDdM2sNioUAJCiZqOA@mail.gmail.com>
 <20140130204558.GC29184@titan.lakedaemon.net>
 <20140130211512.GD13372@obsidianresearch.com>
Message-ID: <CAJ+vNU1KDcJTD_Jm8-enNjqnOGtdVGuFw-uFjzN_u7Vt-iybaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 1:15 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
>
> On Thu, Jan 30, 2014 at 03:45:58PM -0500, Jason Cooper wrote:
>
> > This is more of a process question:  Is there any information captured
> > in your EEPROM that can't be represented in the dtb?  iow, at the point
> > when you write the EEPROM, why not write the dtb to it as configured?
>
> I can share what we do here.. In our systems the serial EEPROM is only
> 256 bytes, so storing things in DT format would be challenging.
>
> What we do is have a master DTB that has the union of all our
> configurations. The boot process has a very simple bit of code that
> runs down the DTB in binary format and replaces entire
> OF_DT_BEGIN_NODE->OF_DT_END_NODE regions with OF_DT_NOP.
>
> The NOP approach is very simple, no other changes (eg offset
> recalculation) needs to be done to the DT, so we can do this process
> with a very small code footprint and without libfdt.
>
> Choosing which sections to drop is done with some combination of
> hardwired code and searching for specific property patterns. There are
> also a few places where placeholder sections are directly fixed up, eg
> a mac address is written into a placeholder of 0s, etc.
>
> So an example might be
>
>    optional_peripheral at 10000 {
>       orc,board-style = <1>;
>       [..]
>    }
>
> Eg The board-style number comes from the EEPROM and if board-style !=
> 1 then the entire stanza is replaced with NOP.
>
> Jason

Jason,

Sounds pretty much like what we are doing.  I am using u-boot and my
current code looks like this:

        /*
         * Peripheral Config:
         *  remove nodes by alias path if EEPROM config tells us the
         *  peripheral is not loaded on the board.
         */
        if (!test_bit(EECONFIG_ETH0, info->config))
                fdt_del_node_and_alias(blob, "ethernet0");
        if (!test_bit(EECONFIG_ETH1, info->config))
                fdt_del_node_and_alias(blob, "ethernet1");
        if (!test_bit(EECONFIG_HDMI_OUT, info->config))
                fdt_del_node_and_alias(blob, "hdmi_out");
        if (!test_bit(EECONFIG_SATA, info->config))
                fdt_del_node_and_alias(blob, "ahci0");
        if (!test_bit(EECONFIG_PCIE, info->config))
                fdt_del_node_and_alias(blob, "pcie");
        if (!test_bit(EECONFIG_SSI0, info->config))
                fdt_del_node_and_alias(blob, "ssi0");
        if (!test_bit(EECONFIG_SSI1, info->config))
                fdt_del_node_and_alias(blob, "ssi1");
...

I've submitted my code to u-boot and have been asked if its more
appropriate to remove nodes as I'm doing above or to mark them as
'disabled'.  From what I can tell there really isn't a rule or
recommendation for this so I think I'll keep doing what I'm doing
above.

Thanks!

Tim

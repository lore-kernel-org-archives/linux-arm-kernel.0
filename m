From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 May 2012 13:50:01 -0600
Subject: Handling of modular boards
In-Reply-To: <20120504185850.GO14230@opensource.wolfsonmicro.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
Message-ID: <4FA432E9.9050606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 12:58 PM, Mark Brown wrote:
> Quite a few reference platforms (including Wolfson ones, which is why
> I'm particularly interested) use replaceable modules to allow
> configuration changes.  Since we can often identify the configuration at
> runtime we should ideally do that but currently there's no infrastructure 
> to help with that...

So, I'll respond within the context of device tree, although perhaps you
were looking for something more general?

I was just asked basically the same question internally to NVIDIA. One
option that was floated was to store the device tree in chunks and have
the bootloader piece them together. You'd start with the DT for the
basic CPU board, probe what HW was available, and then graft in the
content of additional DT chunks and pass the final result to the kernel.
The advantages here are:

a) The DT is stored in chunks for each plugin board, so there's no bloat
in the DT that gets passed to the kernel; it contains exactly what's on
the board.

b) The kernel doesn't have to do anything much; it gets an exact
description of what's on this particular board configuration and doesn't
even care that it's modular.

c) This is probably pretty easy to implement in the bootloader; I
imagine libfdt already has the ability to graft together or overlay
different chunks of DT, and if not, it's most likely easy enough to add.

Disadvantages are:

a) Relies on the bootloader, so is somewhat out of our control.

b) Doesn't integrate well with hotplug; the DT for the board
configuration is static at boot. What if a board can be unplugged and
another plugged in; a reboot or similar would be needed to adjust the
kernel to this.

Another approach would be to put everything in a single DT, with some
representation of how to identify the child boards, and then have the
kernel only use/parse certain chunks of the DT based on the ID results.
I?m not sure how complex that would be. Perhaps something like:

daughter-board {
    compatible = ?daughter-board-mux-eeprom?;
    eeprom = <&i2c_eeprom_node>;
    eeprom-offset = <0x10>; // ID address within EEPOM
    #address-cells = <2>; // # bytes in EEPROM

    board-a {
        compatible = ?daughter-board?;
        reg = <0x1234>;
        ? nodes for devices on this daughter board
        ? or perhaps a list of phandles elsewhere to go activate?
    };

    board-b {
        compatible = ?daughter-board?;
        reg = <0x9876>;
        ? nodes for devices on this daughter board
    };
};

The complexity here is that all the devices on the daughter board would
end up being on different buses (e.g. 2 different I2C busses, an SPI
bus, even an MMIO bus) so representing this in the daughter board nodes
would be complex. Do we insert a "daughter board mux" onto every single
bus that's routed to the daughter board connectors, or add the ability
to dynamically add nodes into pre-existing busses, e.g. add
/daughter-board/board-a/i2c-0 into /tegra-i2c at xxx/?

One advantage here is that everything is explicitly represented to the
kernel, so it has full knowledge of what's going on. Hotplug could
presumably be integrated pretty easily by making the
daughter-board-mux-eeprom able to react to plug events, and re-probe the
ID EEPROM.

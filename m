From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Apr 2018 09:25:26 -0700
Subject: ioremap() use with specific mailbox drivers and SCMI
Message-ID: <be5f7ed4-4b2c-2a6a-0a41-19e30172a048@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,
	
I am looking at the following files:

arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts:
        memory at 0 {
                device_type = "memory";
                reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
                      <0x00000000 0x05f00000 0x00000000 0x00001000>,
                      <0x00000000 0x05f02000 0x00000000 0x00efd000>,
                      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
                      <0x00000000 0x07410000 0x00000000 0x1aaf0000>,
                      <0x00000000 0x22000000 0x00000000 0x1c000000>;
        };

arch/arm64/boot/dts/hisilicon/hi6220.dtsi:
                mailbox: mailbox at f7510000 {
                        compatible = "hisilicon,hi6220-mbox";
                        reg = <0x0 0xf7510000 0x0 0x1000>, /* IPC_S */
                              <0x0 0x06dff800 0x0 0x0800>; /* Mailbox
buffer */
                        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
                        #mbox-cells = <3>;
                };

and this is quite an interesting approach, although it appears to be
quite fragile and simplistic to me for a number of reasons:

- if the mailbox at f7510000 was ever to be relocated within a parent "bus"
node that had a "ranges" property mapping the parent space from
0xf000_0000 to produce offset relative nodes, the translation for its
"reg" properties would apply relative to both cells, which means that
now, the second cell may no longer point to DRAM anymore. This can be
worked around by keeping that particular node outside of the "bus" node,
but it is essentially means we mixed address spaces within the "reg"
property

- punching holes in DRAM by omitting this mailbox's shared buffer from
the top-level memory "reg" property is extremely error prone, and seems
to be a shortcut/hack to allow the ARM/ARM64 implementations to
successfully call ioremap() against these regions. I am not commenting
about the other regions mentioned in the DTS, but pstore is possibly
another example where using ioremap() is convenient, but still not quite
correct.

Using a reserved-memory entry would be far less error prone, would
clearly show the intents of the specific regions being declared, and
could, through the use of additional properties (e.g: "map", as opposed
to "no-map") indicate a possible need to map that DRAM region into
kernel virtual memory and using e.g: memremap() APIs.

Also the semantics of ioremap() are not particularly portable from one
architecture to another whereas memremap() is IMHO.

Thank you
-- 
Florian

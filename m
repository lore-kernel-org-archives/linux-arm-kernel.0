From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 15 Aug 2014 13:42:21 -0400
Subject: Random MAC address on my BeagleBone White
Message-ID: <20140815134221.08c546a0@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm using my BeagleBone White to debug some ftrace code and with the
help from people like Robert Nelson I was finally able to boot it and
test my kernel.

But I'm still having some other issues. The most annoying one is that
the new kernel assigns some random MAC address to my NIC and I can't
give my board the proper IP address via DHCP.

Seems there was talk about adding this via the device tree, but it was
rejected because U-Boot can do it. The problem I have is that U-Boot
doesn't!

I downloaded the latest U-Boot from git://git.denx.de/u-boot.git (Is
that the right place?) and had to tweak it so that I can boot a kernel
via tftp and still use the filesystem on the SD card.

When I place the 3.2 kernel that came with the board on my tftp server,
all works fine. I get the same MAC addr each boot and things just work.
But if I place the 3.16 kernel that I build on the tftp server, I get
some random MAC address, and then a dynamic IP to go with it :-(

This is in my dmesg:

[    2.304970] cpsw 4a100000.ethernet: Random MACID = 8a:fc:f5:aa:b6:e1

I can also see in the file arch/arm/boot/dts/am33xx.dtsi:


                        cpsw_emac0: slave at 4a100200 {
                                /* Filled in by U-Boot */
                                mac-address = [ 00 00 00 00 00 00 ];
                        };

Well, it's not filled in by U-Boot.

My question to all of you is, how do I fix this? I need a static mac
addr.

One way is that I might have to update that file myself with a temp
patch, but I think that's a hack and not something worth doing.

What's the proper way to have the board always come up with the same
MAC addr?

Thanks, this is rather annoying.

-- Steve

From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 6 Oct 2010 16:33:46 +0200
Subject: Kirkwood DMA engine transfer to PCI memory space?
In-Reply-To: <20101006093134.GA32436@debian-wegner1.datadisplay.de>
References: <20101006093134.GA32436@debian-wegner1.datadisplay.de>
Message-ID: <20101006143346.GA23416@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

I found the reason this why this could not work.
Somehow I overlooked the address windows of the XOR engine,
which are only set for the memory regions. I see no way to
cleanly set these windows in our case without some kind of
infrastructure in place, because we use PCI hotplug to rescan
the bus after the FPGA is loaded.

So for testing I just added this quick and dirty code to
mv_xor_conf_mbus_windows() right after setting the memory
windows:
        if (i < 8) {
                printk("setting up DMA window@0xe0000000 (64MB)\n");
                writel(0xe0000000 | (0xe8 << 8) | 0x04, base + WINDOW_BASE(i));
                writel((64*1024*1024 - 1) & 0xffff0000, base + WINDOW_SIZE(i));
                win_enable |= (1 << i);
                win_enable |= 3 << (16 + (2 * i));
        }

Now I can get transfers to reach our FPGA, which then crashes
because it can not handle the bursts. Ouch. :)

The remaining question is if this is some special case for
Kirkwood, or is it a design feature/flaw that anything but
memory is not handled by current dmaengine code?

Regards,
Wolfgang

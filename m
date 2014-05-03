From: ijc@hellion.org.uk (Ian Campbell)
Date: Sat, 03 May 2014 14:19:27 +0100
Subject: Automatically detecting when to use kirkwood-tsXXX-6281.dtb vs
 -6282.dtb (Was: Re: [PATCH 21/21] ARM: Kirkwood: Remove DT support)
In-Reply-To: <20140224162413.GE18601@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
 <1392896356.23342.40.camel@kazak.uk.xensource.com>
 <20140220232649.GU7862@titan.lakedaemon.net>
 <1393257630.16570.95.camel@kazak.uk.xensource.com>
 <20140224162413.GE18601@lunn.ch>
Message-ID: <1399123167.23380.163.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-24 at 17:24 +0100, Andrew Lunn wrote:
> > > back in v3.2, lspci should still work.  Would that given you the
> > > information you need?
> > 
> > I expect it will, yes.
> 
> 3.14 with the new PCIe driver will also work. The patch was accepted
> and considered a regression so made it into one of the -rc's.

I've finally gotten around to doing something about detecting the
various different ts-xxx platforms in order to select between the 6281
and 6282 dtbs (reminder: I need to do this when running both old board
file kernels and new dtb based ones in order to support upgrades).

On TS-419 the PCI ID method works fine when running under 3.2 and 3.14
both using a board file. I'm currently building 3.15 with dts support so
I can test that too (and the soc subsystem export of the SoC ID which
was added in 3.15) but I'm relatively confident that'll all be OK.

However on my 6281 based TS-219 system there seems to be no visible PCI
bus when running the 3.2 kernel in the current Debian stable release
(which of course uses board support). Some info:
        $ grep ^Hardw /proc/cpuinfo 
        Hardware	: QNAP TS-119/TS-219
        $ cat /proc/device-tree/model ; echo
        cat: /proc/device-tree/model: No such file or directory
        
        $ lspci
        $ ls /sys/bus/pci/devices/
        $ ls /sys/class/pci_bus/
        0000:00@
        $ dmesg | grep -i pci
        [    5.024108] Kirkwood PCIe port 0: 
        [    5.024126] Kirkwood PCIe port 1: 
        [    5.024143] PCI: bus0 uses PCIe port 1
        [    5.024342] PCI: bus0: Fast back to back transfers enabled
        [    5.048486] PCI: CLS 0 bytes, default 32
        $ dmesg | grep 628
        [    5.022263] Kirkwood: MV88F6281-A1, TCLK=200000000.
        
ts219-setup.c and ts41x-setup.c don't appear to differ meaningfully in
their pcie setup -- i.e. they both call kirkwood_pcie_init, so I suppose
the difference is whether there is anything on the bus or not.

Is the lack of anything on the PCI bus itself sufficient to determine
that this is a 6281 based ts219 rather than a 6282 one (I don't have any
6282 ts219 systems to try)?

Might PHYAD (reported by ethtool eth0) be a useful fallback mechanism?
AIUI the phy addr is 8 for 6281 systems and 0 for 6282 ones.

Any other ideas?

Also the ts219-setup.c board file supports the ts119 as well, but I
don't see a DTB for that, is that in the works? Any ideas how I can
distinguish a 219 from a 119? On the 219 /sys/class/pci_bus/0000:00
exists (there is nothing under /sys/bus/pci/devices/ though), and since
the main difference in ts219-setup.c is that 119 doesn't call
kirkwood_pcie_init() I suspect the presence or absence
of /sys/class/pci_bus/0000:00 might be sufficient to distinguish them,
does that sound likely? (I don't have a ts119 to try either).

Thanks for any advice.

Ian.

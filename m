From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2016 19:31:44 +0000
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160127193143.GF10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:08:19PM +0100, Thomas Petazzoni wrote:
> On Armada 38x, the available network interfaces are:
> 
>  - port 0, at 0x70000
>  - port 1, at 0x30000
>  - port 2, at 0x34000
> 
> Due to the rule saying that DT nodes should be ordered by register
> addresses, the network interfaces are probed in this order:
> 
>  - port 1, at 0x30000, which gets named eth0
>  - port 2, at 0x34000, which gets named eth1
>  - port 0, at 0x70000, which gets named eth2
> 
> (if all three ports are enabled at the board level)
> 
> Unfortunately, the network subsystem doesn't provide any way to rename
> network interfaces from the kernel (it can only be done from
> userspace). So, the default naming of the network interfaces is very
> confusing as it doesn't match the datasheet, nor the naming of the
> interfaces in the bootloader, nor the naming of the interfaces on
> labels printed on the board.
> 
> For example, on the Armada 388 GP, the board has two ports, labelled
> GE0 and GE1. One has to know that GE0 is eth1 and GE1 is eth0, which
> isn't really obvious.
> 
> In order to solve this, this patch proposes to exceptionaly violate
> the rule of "order DT nodes by register address", and put the 0x70000
> node before the 0x30000 node, so that network interfaces get named in
> a more natural way.

The danger is that this will completely mess up people's existing
scripts/distro configuration which are now used to the current
labelling of the network ports.

Not every distro provides a sane way to deal with this...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

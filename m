From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Oct 2013 04:30:04 +0200
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <0E83723C55F66F43A6041464FE31119D40A9C9@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40A9C9@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <201310120430.04282.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> Hi Tim:
> As I know that the clock of pcie controller should be always running.
> There are not clock gate on/off operations in host driver after the
> initialization.

I think the problem might happen when the PCIe device (Ethernet adapter) is bus-
master and either initiates PCIe->AXI->memory write or memory->AXI->PCIe read 
transfer. This is because when the Intel ethernet (igb) is probed, it only uses 
the MEM window that's mapped into the AXI space (that window at 0x01100000). On 
the other hand, when some packet is transfered, the Intel controller operates 
with structures in DRAM directly. And the stall only happens when the interface 
either receives or attempts to send a packet.

Is this theory of mine even reasonable? If this doesn't work properly, could 
this stall the CPU? How can I check if this works correctly? What can I try if 
it does not?

Thanks!

btw. Please be careful about the top-posting ;-)

Best regards,
Marek Vasut

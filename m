From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Feb 2016 15:06:08 +0100
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <56C356F8.8080105@arm.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C19B18.8090005@arm.com>
 <20160216173155.4f832646@free-electrons.com>
 <56C356F8.8080105@arm.com>
Message-ID: <20160217150608.2c9cdb02@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Tue, 16 Feb 2016 17:06:00 +0000, Marc Zyngier wrote:

> > According to the datasheet I have, the GICD, GICC, GICV and GICH blocks
> > are all 0x10000 in size. Not sure the entire 0x10000 is actually used,
> > but th memory map is pretty clear.
> 
> No, that's just a way to make sure that you can give the GICV block to a
> guest while using 64k pages.
> 
> Talking about GICV: are you sure it is 0x10000 and not 0x20000? SBSA
> recommends to have the first 4kB GICV page aliased over 64kB, and the
> second 4kB page over the second 64kB block. That is to ensure that a
> hypervisor can trap access to GICV_DIR register independently of the
> rest of the virtual CPU interface.
> 
> But hey, almost everybody got it wrong so far, so I wouldn't be
> surprised if that was broken on this platform as well...

It seems like Marvell didn't get it wrong, and that my eyes were the
issue.

What I have in the datasheet is:

GICD 0x210000 0x21FFFF Distributor
GICC 0x220000 0x23FFFF Banked per CPU
GICV 0x240000 0x25FFFF Virtual Control
GICH 0x260000 0x27FFFF Hypervisor Control

So: GICD is 64 KB in size, while GICC, GICV and GICH are all 128 KB in
size. I'll fix that up in my v2.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

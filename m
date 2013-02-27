From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 27 Feb 2013 08:16:28 -0300
Subject: [PATCH] arm: plat-orion: fix address decoding when > 4GB is used
In-Reply-To: <1361958575-2328-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1361958575-2328-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130227111627.GA2718@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 10:49:35AM +0100, Thomas Petazzoni wrote:
> During the system initialization, the orion_setup_cpu_mbus_target()
> function reads the SDRAM address decoding registers to find out how
> many chip-selects of SDRAM have been enabled, and builds a small array
> with one entry per chip-select. This array is then used by device
> drivers (XOR, Ethernet, etc.) to configure their own address decoding
> windows to the SDRAM.
> 
> However, devices can only access the first 32 bits of the physical
> memory. Even though LPAE is not supported for now, some Marvell boards
> are not showing up with 8 GB of RAM, configured using two SDRAM

Tiny nitpick:

s/not/now

> address decoding windows: the first covering the first 4 GB, the
> second covering the last 4 GB. The array built by
> orion_setup_cpu_mbus_target() has therefore two entries, and device
> drivers try to set up two address decoding windows to the
> SDRAM. However, in the device registers for the address decoding, the
> base address is only 32 bits, so those two windows overlap each other,
> and the devices do not work at all.
> 
> This patch makes sure that the array built by
> orion_setup_cpu_mbus_target() only contains the SDRAM decoding windows
> that correspond to the first 4 GB of the memory. To do that, it
> ignores the SDRAM decoding windows for which the 3 low-order bits are
> not zero (the 3 low-order bits of the base register are used to store
> bits 32:35 of the base address, so they actually indicate whether the
> base address is above 4 GB).
> 
> This patch allows the newly introduced armada-xp-gp board to properly
> operate when it is mounted with more than 4 GB of RAM. Without that,
> all devices doing DMA (for example XOR and Ethernet) do not work at
> all.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On the Armada XP GP board, ethernet doesn't work at all without this patch.

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

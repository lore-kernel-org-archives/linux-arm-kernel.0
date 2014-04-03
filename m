From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 3 Apr 2014 15:42:00 +0000
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <20140403152746.GQ7528@n2100.arm.linux.org.uk>
References: <1396358832-15828-1-git-send-email-zhangfei.gao@linaro.org>
 <1396358832-15828-4-git-send-email-zhangfei.gao@linaro.org>
 <9532591.5yuCbpL4pV@wuerfel> <20140403152746.GQ7528@n2100.arm.linux.org.uk>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6EF663@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux
> DMA coherent memory is write combining, so multiple writes will be
> coalesced.  This also means that barriers may be required to ensure the
> descriptors are pushed out in a timely manner if something like writel()
> is not used in the transmit-triggering path.

You also have to ensure that the write that changes the 'owner'
bit is the one that happens last.

If (for example) a descriptor has two words, one containing the
buffer address and the other containing the length and flags,
then you have to absolutely ensure that the hardware will not
read the new 'flags' with the old 'buffer address'.
Any write to tell the hardware to look at the tx ring won't
help you - the hardware might be reading the descriptor anyway.

Even if the accesses are uncached, you need the appropriate
barrier (or volatiles) to stop gcc reordering the writes.
(I think accesses to volatiles can't be reordered - check.)

	David

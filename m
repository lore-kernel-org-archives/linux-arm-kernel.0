From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 29 Jun 2015 14:48:08 +0100
Subject: [PATCH] kvmtool: don't use PCI config space IRQ line field
In-Reply-To: <20150629101004.GB17474@arm.com>
References: <1433431245-23227-1-git-send-email-andre.przywara@arm.com>
 <20150605164158.GL7420@arm.com> <557EACD2.1030500@arm.com>
 <20150616170657.GO30522@arm.com> <5582FDB9.3020700@arm.com>
 <20150629101004.GB17474@arm.com>
Message-ID: <55914C98.1070507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 29/06/15 11:10, Will Deacon wrote:
> Hi Andre,
> 
> On Thu, Jun 18, 2015 at 06:19:53PM +0100, Andre Przywara wrote:
>> I am tempted to remove shmem, since it's broken:
>> a) there is no upstream driver, only some out-of-tree uio driver module
>> in some Github repo
> 
> Right, but that's the same for qemu and we've already made the jump of
> merging the driver, so I don't think that's a good argument for throwing
> it out of the tree.

If this driver has some future in the Linux tree, I agree it's worth to
keep it in, though I didn't see any effort to merge it lately.

>> b) the PCI device BARs do not match what QEMU implements and what the
>> uio driver expects (IO BAR vs. MMIO BAR)
> 
> In what way? A quick look suggests that kvmtool is at least aligned with
> said github repo.

The first BAR holds the control registers, QEMU and the UIO driver
require an MMIO region, kvmtool uses PIO :-(

>> c) there is (at least one) bug in kvmtool (easily fixed, though)

The size of the control register region in BAR0 is set to the size of
the shared memory region, where it should be some constant size (at
least 16 Bytes, QEMU uses 256, the spec says 1K, pick one ;-)
As PIO on x86 is at most 64K, this BAR gets ignored by the kernel with
any shmem size above that (it defaults to 4M).
As said the fix is easy, but ...

Those two bugs alone make we wonder if that ever worked on kvmtool,
obviously not with that UIO driver (which seems to work on QEMU).
I have fixes for both issues, but I haven't had a chance of testing this
in real action (just the driver loaded and lspci looking sensible). I
may send the patches later, but this doesn't have high priority for me
(unless someone bugs me ;-)

Cheers,
Andre.

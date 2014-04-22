From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 11:28:35 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140422102834.GE7484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Mon, Apr 21, 2014 at 07:03:10PM +0100, Santosh Shilimkar wrote:
> ARM coherent CPU dma map APIS are assumed to be nops on cache coherent
> machines. While this is true, one still needs to ensure that no
> outstanding writes are pending in CPU write buffers. To take care
> of that, we at least need a memory barrier to commit those changes
> to main memory.
> 
> Patch is trying to fix those cases. Without such a patch, you will
> end up patching device drivers to avoid the synchronisation issues.

Don't you only need these barriers if you're passing ownership of a CPU
buffer to a device? In that case, I would expect a subsequent writel to tell
the device about the new buffer, which includes the required __iowmb().
That's the reason for the relaxed accessors: to avoid this barrier when it's
not needed. Perhaps you're using the relaxed accessors where you actually
need the stronger ordering guarantees?

Will

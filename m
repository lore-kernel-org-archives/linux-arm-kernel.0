From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 10:16:24 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140424090927.GB8521@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com> <20140424090927.GB8521@arm.com>
Message-ID: <20140424091624.GG26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:09:27AM +0100, Catalin Marinas wrote:
> If we only do D-cache maintenance by MVA, the ARM ARM (both v7 and v8)
> claims that these are ordered relative to any explicit load/stores to
> the same address. So in theory we don't even need a DMB for unmapping
> with DMA_FROM_DEVICE. But in practice, we may have the outer cache,
> hence a DSB is required before the outer_sync() (we could move it there
> though).

The general usecase for outer_sync() is: dsb(); outer_sync();  Why would
we want to change this to dsb(); dmb(); outer_sync(); (where the dmb is
in outer_sync itself?)

Seems more sensible for it to stay at the outer_sync() call site where
it's needed.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

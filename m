From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Wed, 15 Jun 2011 13:53:22 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106142030.07549.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106141803.00876.arnd@arndb.de>
	<op.vw2r3xrj3l0zgt@mnazarewicz-glaptop>
	<201106142030.07549.arnd@arndb.de>
Message-ID: <BANLkTi=XTJuF4np7+rYHzJqWK20OxMrBsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 20:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 14 June 2011 18:58:35 Michal Nazarewicz wrote:
>> Ah yes, I forgot that separate regions for different purposes could
>> decrease fragmentation.
>
> That is indeed a good point, but having a good allocator algorithm
> could also solve this. I don't know too much about these allocation
> algorithms, but there are probably multiple working approaches to this.

imo no allocator algorithm is gonna help if you have comparably large,
variable-sized contiguous allocations out of a restricted address range.
It might work well enough if there are only a few sizes and/or there's
decent headroom. But for really generic workloads this would require
sync objects and eviction callbacks (i.e. what Thomas Hellstrom pushed
with ttm).

So if this is only a requirement on very few platforms and can be
cheaply fixed with multiple cma allocation areas (heck, we have
slabs for the same reasons in the kernel), it might be a sensible
compromise.
-Daniel
-- 
Daniel Vetter
daniel.vetter at ffwll.ch - +41 (0) 79 365 57 48 - http://blog.ffwll.ch

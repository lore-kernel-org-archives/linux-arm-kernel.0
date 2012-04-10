From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Apr 2012 14:51:55 +0200
Subject: [PATCHv8 07/10] ARM: dma-mapping: move all dma bounce code to
 separate dma ops structure
In-Reply-To: <201204101224.24959.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
 <201204101224.24959.arnd@arndb.de>
Message-ID: <002801cd1718$b556a1e0$2003e5a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, April 10, 2012 2:24 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > This patch removes dma bounce hooks from the common dma mapping
> > implementation on ARM architecture and creates a separate set of
> > dma_map_ops for dma bounce devices.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I could be misunderstanding something, but it looks like this
> one should come before patch 6, where you remove
> some of the dmabounce functions. Can you clarify?

Before patch no 6, there were custom methods for all scatter/gather
related operations. They iterated over the whole scatter list and called
cache related operations directly (which in turn checked if we use dma
bounce code or not and called respective version). Patch no 6 changed
them not to use such shortcut for direct calling cache related operations.

Instead it provides similar loop over scatter list and calls methods
from the current device's dma_map_ops structure. This way, after patch no 
7 these functions call simple dma_map_page() method for all standard 
devices and dma bounce aware version for devices registered for dma 
bouncing (with use different dma_map_ops).

I can provide a separate set of scatter/gather list related functions for
the linear dma mapping implementation and dma bouncing implementation 
if you think that the current approach is too complicated or 
over-engineered.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center

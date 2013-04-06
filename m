From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 6 Apr 2013 10:22:00 -0400 (EDT)
Subject: [RFC][PATCH] arm: highmem: Add support for flushing kmap_atomic
 mappings
In-Reply-To: <1365198171-8469-1-git-send-email-lauraa@codeaurora.org>
References: <1365198171-8469-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <alpine.LFD.2.03.1304061006530.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Laura Abbott wrote:

> The highmem code provides kmap_flush_unused to ensure all kmap
> mappings are really removed if they are used. This code does not

You meant "if they are *not* used", right?

> handle kmap_atomic mappings since they are managed separately.
> This prevents an issue for any code which relies on having absolutely
> no mappings for a particular page. Rather than pay the penalty of
> having CONFIG_DEBUG_HIGHMEM on all the time, add functionality
> to remove the kmap_atomic mappings in a similar way to kmap_flush_unused.

Could you elaborate on that code that relies on having absolutely no 
mappings for a particular page please?

> This is intended to be an RFC to make sure this approach is
> reasonable. The goal is to have kmap_atomic_flush_unused be a public
> API.

The clearing code is going to be costly since you do a 
set_top_pte(vaddr, __pte(0)) unconditionally on the whole range, 
regardless if the PTE is already set to 0.

Using it via an hotplug callback is rather strange, but I'm assuming 
that this was only for testing?


Nicolas

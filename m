From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 20:01:23 +0000
Subject: [PATCH] ARM: relax conditions required for enabling Contiguous
 Memory Allocator
In-Reply-To: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
References: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201208202001.23443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Marek Szyprowski wrote:
> Contiguous Memory Allocator requires only paging and MMU enabled not
> particular CPU architectures, so there is no need for strict dependency
> on CPU type. This enables to use CMA on some older ARM v5 systems which
> also might need large contiguous blocks for the multimedia processing hw
> modules.
> 
> Reported-by: Prabhakar Lad <prabhakar.csengg@gmail.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

The patch looks simple, but I want a better explanation for it.
When we went through all possible cases, we decided that:

* ARMv6+ need CMA to avoid the double mapping problem.
* ARMv4/v5 cannot generally use CMA because it doesn't work
  together with DMABOUNCE. I don't remember if it was the
  only problem, but I definitely remember this was intentional.
* We want a common kernel for all ARMv6+ eventually, and a
  separate kernel for all ARMv4/v5 ones.

If the reasoning has changed, please try to explain the full
situation. On a related topic, what happened to the idea that
ARMv6+ is broken without CMA? I noticed that it's optional
now.

	Arnd

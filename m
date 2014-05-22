From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 May 2014 15:45:03 +0100
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5678119.IM3FN0FlT6@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
 <5678119.IM3FN0FlT6@wuerfel>
Message-ID: <20140522144503.GA27931@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 09:31:37AM +0100, Arnd Bergmann wrote:
> commit 42c4dafe803dcad82980fd8b0831a89032156f93
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Thu Jul 1 13:22:48 2010 +0100
> 
>     ARM: 6202/1: Do not ARM_DMA_MEM_BUFFERABLE on RealView boards with L210/L220
>     
>     RealView boards with certain revisions of the L210/L220 cache controller
>     may have issues (hardware deadlock) with the mandatory barriers (DSB
>     followed by an L2 cache sync) when ARM_DMA_MEM_BUFFERABLE is enabled.
>     The patch disables ARM_DMA_MEM_BUFFERABLE for these boards.
>     
>     Tested-by: Linus Walleij <linus.walleij@stericsson.com>
>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looking through the L220 errata document, I think this relates to 425331
which says that a cache sync can deadlock the system if the write buffer
is not empty. By making the DMA memory Strongly Ordered, we avoid the
L220 write buffer. In addition to the above commit, we also had
2503a5ecd86c (ARM: 6201/1: RealView: Do not use outer_sync() on
ARM11MPCore boards with L220).

The above only solves the issue for coherent DMA allocations. Streaming
DMA requires additional changes to cache-l2x0.c but they are all weird
and depend on how the L2x0 is wired (for example, using SWP to access
the L2x0 registers works on one RealView board but not on another).
Anyway, I don't think we have any streaming DMA used on these RealView
boards.

If we only use the DMA coherent buffers for CLCD on these boards, we
don't really need the outer_sync() either so we could go back to
bufferable DMA memory (strangely enough, this L2 cache workaround looks
similar to Marvell's PCI+PL310 problem where we want to avoid
outer_sync()).

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Mar 2015 17:17:51 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF21BE.2040506@list.ru>
References: <54FF21BE.2040506@list.ru>
Message-ID: <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:54:22PM +0300, Stas Sergeev wrote:
> Hello, the patch below is needed for a successful boot on armada-xp.
> 
> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
> This fixes the following crash at boot:
> 
>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>  Internal error: : 808 [#1] SMP ARM

I think you have some other problems. That's an external abort, which
means that the original vmalloc'ed memory was not mapping RAM but some
empty physical address space.

That's unless strex hits device memory and not having an exclusive
monitor causes such external abort. But vmalloc() memory is Normal
Cacheable. Some pointer could go wrong and it hits ioremap'ed memory
which is in the same range as vmalloc'ed memory.

-- 
Catalin

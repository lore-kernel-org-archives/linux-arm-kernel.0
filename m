From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jul 2010 17:54:33 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <002801cb243c$e0a70130$a1f50390$@deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
	<1279209238-16234-3-git-send-email-will.deacon@arm.com>
	<20100715163216.GI29322@n2100.arm.linux.org.uk>
	<002801cb243c$e0a70130$a1f50390$@deacon@arm.com>
Message-ID: <1279212873.6664.60.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-15 at 17:43 +0100, Will Deacon wrote:
> Russell King wrote:
> > So, what CPUs report themselves as having VIPT non-aliasing caches but
> > actually have an aliasing I-cache?
> 
> As far as I understand, all ARM cores have aliasing I-caches if it's a
> VIPT cache with way size greater than the page size. The D-cache has
> additional logic for handling aliasing which is what the VIPT non-aliasing
> characteristics refer to.

Just to confirm what Will said (and I checked this in the past with our
lead architect) - if the CTR reports VIPT I-cache, it is a true VIPT
I-cache with potential aliases if the way size is greater than the page
size (e.g. on vexpress, C-A9 has 32K I-cache and 4 ways).

On the D side, the VIPT on ARMv7 is always non-aliasing (e.g. it behaves
like PIPT).

Anyway, it's not that bad since most places where this matters use
__flush_icache_all(). This includes my patches for cache maintenance via
set_pte_at().

-- 
Catalin

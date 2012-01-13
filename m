From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 13 Jan 2012 19:12:31 +0200
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
In-Reply-To: <20120113140520.GE16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com>
 <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
 <alpine.LFD.2.02.1201121447270.2722@xanadu.home>
 <20120112195951.GB2287@atomide.com>
 <20120113140520.GE16726@n2100.arm.linux.org.uk>
Message-ID: <CAMP44s2XNnOAiDCf1mbtpRV5MAk4LLFdgBpuOQg=pc9aakiDEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 4:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> +phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> +{
> + ? ? ? phys_addr_t phys;
> +
> + ? ? ? if (!arm_memblock_steal_permitted)
> + ? ? ? ? ? ? ? panic("arm_memblock_steal used in an unsafe manner\n");
> +
> + ? ? ? phys = memblock_alloc(size, align);
> + ? ? ? memblock_free(phys, size);
> + ? ? ? memblock_remove(phys, size);
> +
> + ? ? ? return phys;
> +}

Excellent! I think I suggested a function like that at some point.

But I wonder about the 'align' argument. I think most people just
copy-pasted SZ_1M, although I think originally you suggested SZ_2M,
maybe it would make sense to align 'align' to SZ_1M, or set SZ_1M if
it's 0 for convenience.

Also, what about people that need memblock_alloc_base? AFAIK OMAP 3
secure ram needs to be below certain area (I wonder why the current
code is not handling that).

Cheers.

-- 
Felipe Contreras

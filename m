From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Oct 2015 17:18:17 +0100
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <3AD5938C-4109-4B95-A13B-5D45525B39FB@gmail.com>
References: <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com>
 <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com>
 <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
 <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com>
 <561FCD59.1090600@arm.com>
 <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
 <20151016160606.GE6613@e104818-lin.cambridge.arm.com>
 <3AD5938C-4109-4B95-A13B-5D45525B39FB@gmail.com>
Message-ID: <20151019161816.GE11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 10:38:16PM +0900, Jungseok Lee wrote:
> On Oct 17, 2015, at 1:06 AM, Catalin Marinas wrote:
> > BTW, a static allocation (DEFINE_PER_CPU for the whole irq stack) would
> > save us from another stack address reading on the IRQ entry path. I'm
> > not sure exactly where the 16K image increase comes from but at least it
> > doesn't grow with NR_CPUS, so we can probably live with this.
> 
> I've tried the approach, a static allocation using DEFINE_PER_CPU, but
> it dose not work on a top-bit comparison method (for IRQ re-entrance
> check). The top-bit idea is based on the assumption that IRQ stack is
> aligned with THREAD_SIZE. But, tpidr_el1 is PAGE_SIZE aligned. It leads
> to IRQ re-entrance failure in case of 4KB page system.
> 
> IMHO, it is hard to avoid 16KB size increase for 64KB page support.
> Secondary cores can rely on slab.h, but a boot core cannot. So, IRQ
> stack for at least a boot cpu should be allocated statically.

Ah, I forgot about the alignment check. The problem we have with your v5
patch is that kmalloc() doesn't guarantee this either (see commit
2a0b5c0d1929, "arm64: Align less than PAGE_SIZE pgds naturally", where
we had to fix this for pgd_alloc).

I'm leaning more and more towards the x86 approach as I mentioned in the
two messages below:

http://article.gmane.org/gmane.linux.kernel/2041877
http://article.gmane.org/gmane.linux.kernel/2043002

With a per-cpu stack you can avoid another pointer read, replacing it
with a single check for the re-entrance. But note that the update only
happens during do_softirq_own_stack() and *not* for every IRQ taken.

-- 
Catalin

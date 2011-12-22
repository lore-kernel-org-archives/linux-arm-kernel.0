From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Dec 2011 16:49:13 +0000
Subject: insmod problem on ARM with more than 16MB of RAM?
In-Reply-To: <20111222203531.0c4f80f1@emcraft.com>
References: <20111222203531.0c4f80f1@emcraft.com>
Message-ID: <CAHkRjk7105PLe=98mMKmSKkWDmyFjWpBkZ5_iy-U-ZiNKHFNLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2011 16:35, Sergei Poselenov <sposelenov@emcraft.com> wrote:
> I'm working with an ARM Cortex-M3 port of Linux 2.6.33. Everything is
> fine except the target board has 32MB memory and this breaks the
> loadable modules support:
> ...
> ~ # insmod sample.ko
> sample: relocation out of range, section 2 reloc 0 sym 'printk'
> insmod: can't insert 'sample.ko': invalid module format
> ~ #
> ..
>
> The reason for this error is that the module_alloc() for non-MMU
> ARM target is just kmalloc(size), which obviously returns the memory
> area too far for allowed range of the thumb2 branch instructions.
>
> Currently, I worked around this by restricting kernel memory usage with
> "mem=16M".
>
> Is anybody solved this problem in 2.6 no-MMU ARM kernels?

You could change the testofs-y in arch/arm/Makefile to something like
16MB and it could be reachable from all 32MB of RAM.

A more general solution may be to move the kernel in the top 16MB of
RAM (in case you have more than 32MB), enable ZONE_DMA and make all
the memory up to the kernel part of the DMA zone. The top 16MB would
be ZONE_NORMAL and modules would in general be allocated from there
(but there is no guarantee).

A completely generic solution would be to modify the module loader to
cope with longer relocations by setting up some trampoline code.

-- 
Catalin

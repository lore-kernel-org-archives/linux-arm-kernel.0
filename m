From: sposelenov@emcraft.com (Sergei Poselenov)
Date: Thu, 22 Dec 2011 20:35:31 +0400
Subject: insmod problem on ARM with more than 16MB of RAM?
Message-ID: <20111222203531.0c4f80f1@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm working with an ARM Cortex-M3 port of Linux 2.6.33. Everything is
fine except the target board has 32MB memory and this breaks the
loadable modules support:
...
~ # insmod sample.ko 
sample: relocation out of range, section 2 reloc 0 sym 'printk'
insmod: can't insert 'sample.ko': invalid module format
~ # 
..

The reason for this error is that the module_alloc() for non-MMU
ARM target is just kmalloc(size), which obviously returns the memory
area too far for allowed range of the thumb2 branch instructions.

Currently, I worked around this by restricting kernel memory usage with
"mem=16M".

Is anybody solved this problem in 2.6 no-MMU ARM kernels?

In the lists I only found this thread
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/037837.html
, but it discussed different problem.

I looked at the recent 3.x kernels and didn't see support for loadable
modules at all for the non-mmu ARM. Any plans to add it there?

Merry Christmas!

Regards,
Sergei

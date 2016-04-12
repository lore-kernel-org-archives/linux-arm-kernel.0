From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Apr 2016 11:14:39 +0300
Subject: [RFC 0/1] ARM: mm: cache shareability tweak
Message-ID: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This RFC patch attempts to implement support for specifying cache
shareability setting via kernel cmdline. This is required at least
for TI keystone2 generation SoCs, where DMA masters are snooping on
the cache maintenance messages to maintain coherency. Currently we
are carrying an internal hack that modifies the macros via #ifdefs,
this is obviously bad as the same kernel image can only work with
keystone2 (or at least might be causing problems with other SoCs.)
It would be very much preferred to replace this hardcoded
implementation with a runtime solution.

Some obvious holes in this implementation:

1) during execution of arch/arm/kernel/head.S, the tweaked MMU shareability
   settings are not in place. However, I am not too sure how much that
   matters, as I am not sure what is mapped at this point. Kernel image
   mapping should not matter at least, as we typically should not be doing
   any DMA transfers from the kernel image. I would like some comments on
   this, if handling during head.S should be fixed also, how can this be
   done? Some hack under compressed/keystone-head.S?

2) the cmdline parameter could be something more descriptive

3) The single RFC patch should probably be split up a bit

- Tero

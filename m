From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed,  9 Apr 2014 20:08:13 +0200
Subject: [PATCH v3 0/4] ARM: pxa: Fix out of vmalloc space bug
Message-ID: <1397066897-31826-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(Resending due to a typo in an e-mail address that caused LAKML to reject the
mails. Sorry about the noise.)

This patch set reworks Ezequiel Garcia's previous fix [1] of an out of vmalloc
space bug on PXA2[57]x platforms caused by an attempt to map the start of
physical uncached outside of the vmalloc space.

This first three patches perform a couple of cleanups, and the last patch
fixes the problem. I've decided to map the memory at address 0xfe000000 to
minimize changes to the code, but this causes a bit of fragmentation of
vmalloc space. I could map it to the very end of vmalloc space (0xfef00000)
instead if preferred, which would involve replacing a mov by an ldr in
pxa2[57]x_finish_suspend and pm_enter_standby_start.

I've tested the patch set on a PXA270-based system.

[1] https://lkml.org/lkml/2013/11/28/474

Ezequiel Garcia (1):
  ARM: pxa: Move iotable mapping inside vmalloc region

Laurent Pinchart (3):
  ARM: pxa: Don't hardcode addresses and size in map_desc tables
  ARM: pxa: Move UNCACHED_PHYS_0 mapping from generic.c to pxa2[57]x.c
  ARM: pxa: pxa27x: Don't map IMEMC region statically

 arch/arm/mach-pxa/generic.c               | 11 +++--------
 arch/arm/mach-pxa/include/mach/hardware.h |  4 ++--
 arch/arm/mach-pxa/pxa25x.c                |  7 ++++++-
 arch/arm/mach-pxa/pxa27x.c                | 10 +++++-----
 arch/arm/mach-pxa/pxa3xx.c                |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
Regards,

Laurent Pinchart

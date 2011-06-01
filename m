From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed,  1 Jun 2011 11:03:22 -0400
Subject: [PATCH v3 0/3] davinci: ioremap SRAM instead of iotables
In-Reply-To: <20110601051753.GA5153@game.jcrosoft.org>
References: <20110601051753.GA5153@game.jcrosoft.org>
Message-ID: <cover.1306940448.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci platforms are mapping their io regions using iotables. This patch
series converts them to mapping using ioremap.

This version of the series is based on-top-of '[RFC PATCH v4] Consolidate
SRAM support' from Russell King and Jean-Christophe PLAGNIOL-VILLARD. V3 has
a fix to the commit message of 1/3 as requested by Jean-Christophe PLAGNIOL-
VILLARD and also his Acks added to the series.

The davinci sram init is first changed to ioremap the regions specified by
each of the soc_infos; then the iotables are each removed; then the SRAM_VIRT
definition is removed. Finally, the da850's sram region is changed from
the ARM local RAM region to the Shared RAM region. This change is needed
to support mcasp ping-pong buffers on da850. Suspend was tested with rtcwake
and was found to work.

Ben Gardiner (2):
  [v3] davinci: sram: ioremap the davinci_soc_info specified sram
    regions
  [v3] davinci: da850-dm646x: remove the SRAM_VIRT iotable entry

Subhasish Ghosh (1):
  [v3] davinci: da850: changed SRAM allocator to shared ram.

 arch/arm/mach-davinci/da850.c               |   10 ++--------
 arch/arm/mach-davinci/dm355.c               |    6 ------
 arch/arm/mach-davinci/dm365.c               |    6 ------
 arch/arm/mach-davinci/dm644x.c              |    6 ------
 arch/arm/mach-davinci/dm646x.c              |    6 ------
 arch/arm/mach-davinci/include/mach/common.h |    2 --
 arch/arm/mach-davinci/include/mach/da8xx.h  |    1 +
 arch/arm/mach-davinci/sram.c                |   10 ++++++++--
 8 files changed, 11 insertions(+), 36 deletions(-)

-- 
1.7.4.1

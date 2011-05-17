From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Tue, 17 May 2011 17:41:56 -0400
Subject: [PATCH 0/9] 
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
Message-ID: <cover.1305668470.git.bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci platforms are mapping their io regions using iotables. This patch
series converts them to mapping using ioremap. 

This series is based on-top-of '[RFC PATCH v3] Consolidate SRAM support' from
Russell King.

The first patch in the series is a squash of the neccessary changes as
reported by Sekhar Nori in that thread.

The davinci sram init is first changed to ioremap the regions specified by 
each of the soc_infos; then the iotables are each removed; then the SRAM_VIRT
definition is removed. Finally, the da850's sram region is changed from 
the ARM local RAM region to the Shared RAM region. This change is needed
to support mcasp ping-pong buffers on da850. Suspend was tested with rtcwake
and was found to work.

Ben Gardiner (7):
  davinci: sram: ioremap the davinci_soc_info specified sram regions
  davinci: da850: remove the SRAM_VIRT iotable entry
  davinci: dm355: remove the SRAM_VIRT iotable entry
  davinci: dm365: remove the SRAM_VIRT iotable entry
  davinci: dm644x: remove the SRAM_VIRT iotable entry
  davinci: dm646x: remove the SRAM_VIRT iotable entry
  davinci: remove definition of SRAM_VIRT

Nori, Sekhar (1):
  davinci: pm: fix compiler errors and kernel panics from sram
    consolidation

Subhasish Ghosh (1):
  davinci: da850: changed SRAM allocator to shared ram.

 arch/arm/mach-davinci/da850.c               |   10 ++--------
 arch/arm/mach-davinci/dm355.c               |    6 ------
 arch/arm/mach-davinci/dm365.c               |    6 ------
 arch/arm/mach-davinci/dm644x.c              |    6 ------
 arch/arm/mach-davinci/dm646x.c              |    6 ------
 arch/arm/mach-davinci/include/mach/common.h |    2 --
 arch/arm/mach-davinci/include/mach/da8xx.h  |    1 +
 arch/arm/mach-davinci/pm.c                  |    2 +-
 arch/arm/mach-davinci/sleep.S               |    1 +
 arch/arm/mach-davinci/sram.c                |   12 ++++++++++--
 10 files changed, 15 insertions(+), 37 deletions(-)

-- 
1.7.4.1

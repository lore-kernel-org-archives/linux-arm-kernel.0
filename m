From: dianders@chromium.org (Doug Anderson)
Date: Tue,  6 Aug 2013 14:37:47 -0700
Subject: [PATCH v4 0/4] mmc: dw_mmc: fixes for suspend/resume on exynos
In-Reply-To: <1373470926-19314-1-git-send-email-dianders@chromium.org>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
Message-ID: <1375825071-20922-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches addresses some suspend/resume problems with
dw_mmc on exynos platforms, espeically exynos5420.  Since
suspend/resume is not fully working on ToT Linux (v3.11-rc4) on
exynos5250-snow, this series was tested against the current ToT
ChromeOS 3.8 tree.  I have confirmed basic booting and eMMC / SD card
usage (and compiling, honest!) against ToT Linux.

I have received confirmation from Samsung that the problem solved is a
silicon errata on exynos5420 and that this is a good fix.

Changes in v4:
- Take Seungwon's suggestion and don't add any dw_mmc-pltfm code.

Changes in v3:
- Add freeze/thaw and poweroff/restore noirq entries.

Changes in v2:
- Fix typo (some -> come)
- Use ~0 instead of 0xFFFFFFFF; add comment about value
- Use suspend_noirq as per James Hogan.

Doug Anderson (4):
  mmc: dw_mmc: Invalidate cache of current_speed after suspend/resume
  mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
  mmc: dw_mmc: Always setup the bus after suspend/resume
  mmc: dw_mmc: Set timeout to max upon resume

 drivers/mmc/host/dw_mmc-exynos.c | 51 ++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.c        | 15 ++++++++----
 2 files changed, 60 insertions(+), 6 deletions(-)

-- 
1.8.3

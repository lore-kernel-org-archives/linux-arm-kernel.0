From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 26 May 2015 17:54:44 +0800
Subject: [PATCH v5 0/3] media: atmel-isi: rework on the clock part and add
 runtime pm support
Message-ID: <1432634087-3356-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fix the peripheral clock code and enable runtime support.
Also it clean up the code which is for the compatiblity of mck.

Changes in v5:
- add new patch to fix the condition that codec request still in work.
- fix the error path in start_streaming() thanks to Laurent.

Changes in v4:
- need to call pm_runtime_disable() in atmel_isi_remove().
- merged the patch which remove isi disable code in atmel_isi_probe() as
  isi peripherial clock is not enabled in this moment.
- refine the commit log

Changes in v3:
- remove useless definition: ISI_DEFAULT_MCLK_FREQ

Changes in v2:
- merged v1 two patch into one.
- use runtime_pm_put() instead of runtime_pm_put_sync()
- enable peripheral clock before access ISI registers.
- totally remove clock_start()/clock_stop() as they are optional.

Josh Wu (3):
  media: atmel-isi: disable ISI even it has codec request in
    stop_streaming()
  media: atmel-isi: add runtime pm support
  media: atmel-isi: remove mck back compatiable code as it's not need

 drivers/media/platform/soc_camera/atmel-isi.c | 105 ++++++++++++--------------
 1 file changed, 48 insertions(+), 57 deletions(-)

-- 
1.9.1

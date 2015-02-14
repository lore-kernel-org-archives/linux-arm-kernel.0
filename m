From: addy.ke@rock-chips.com (Addy Ke)
Date: Sat, 14 Feb 2015 14:17:45 +0800
Subject: [PATCH v4 0/3] about data busy
In-Reply-To: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch 1: This patch can fix bug that controller is still data busy after
	 reset all blocks. After this patch, I still get data busy in
	 set_ios().

patch 2: This patch fix bug 'Timeout sending command'. After patch1 and
	 patch2, there is no mmc errors after:
	 cd /sys/bus/platform/drivers/dwmmc_rockchip
	 for i in $(seq 1 10000); do
  		echo "========================" $i
  		echo ff0c0000.dwmmc > unbind
  		sleep .5
  		echo ff0c0000.dwmmc > bind
  		sleep 2
	done
 
patch3: This patch fix bug that there is data busy before sdio send CMD53.
        But This patch is necessary for sd and mmc too.

Addy Ke (3):
  mmc: dw_mmc: update clock after host reach a stable voltage
  mmc: dw_mmc: fix bug that cause 'Timeout sending command'
  mmc: dw_mmc: Don't start command while data busy

 drivers/mmc/host/dw_mmc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

-- 
1.8.3.2

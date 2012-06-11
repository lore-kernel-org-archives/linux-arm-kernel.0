From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 11:03:26 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org> <20120604101447.GF8262@n2100.arm.linux.org.uk>
 <4FCDE3D7.9030006@linaro.org> <20120605105249.GK8262@n2100.arm.linux.org.uk>
 <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
Message-ID: <4FD5C26E.9080902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Lee can you provide an incremental fixup that makes the current
> code textually equivalent to what Russell ACKed (devm_kzalloc()),
> and funnel to Chris for the -rc:s ASAP?

Your wish is my command:

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Jun 2012 10:41:00 +0100
Subject: [PATCH] mmc: mmci: Allocate platform memory during Device Tree boot

When booting with Device Tree enabled, platform specific information
is gathered by parsing the DT binary. Platform data is subsequently
populated with the result. The memory required for this is not
automatically allocated during Device Tree boot, so we'll do it here
instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mmci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f0fcce4..0045ee0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1276,6 +1276,12 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		return -EINVAL;
 	}
 
+	if (!plat) {
+		plat = devm_kzalloc(&dev->dev, sizeof(*plat), GFP_KERNEL);
+		if (!plat)
+			return -ENOMEM;
+	}
+
 	if (np)
 		mmci_dt_populate_generic_pdata(np, plat);
 
-- 
1.7.9.5

From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Mar 2013 15:06:23 -0300
Subject: [PATCH v3 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <20130320160418.GG20530@pengutronix.de>
References: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
 <20130320160418.GG20530@pengutronix.de>
Message-ID: <CAOMZO5BZ6Zqowd+gCXFy9QbU0HKD1HAsy+a_-cZuYQujHLgoXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 1:04 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Jan 04, 2013 at 10:04:23AM +0800, Frank Li wrote:
>> MX6 and mx28 support enhanced DMA descriptor buff to support 1588
>> ptp. But MX25, MX3x, MX5x can't support enhanced DMA descriptor buff.
>> Check fec type and choose correct DMA descriptor buff type.
>>
>> Remove static config CONFIG_FEC_PTP.
>> ptp function will be auto detected.
> Your patch (now as ff43da86c69d76a726ffe7d1666148960dc1d108 in v3.9-rc1)
> breaks building with CONFIG_FEC=m:
>
>         ERROR: "fec_ptp_init" [drivers/net/ethernet/freescale/fec.ko] undefined!
>         ERROR: "fec_ptp_ioctl" [drivers/net/ethernet/freescale/fec.ko] undefined!
>         ERROR: "fec_ptp_start_cyclecounter" [drivers/net/ethernet/freescale/fec.ko] undefined!

What about this fix?

---
 drivers/net/ethernet/freescale/fec_ptp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
b/drivers/net/ethernet/freescale/fec_ptp.c
index 1f17ca0..0d8df40 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -128,6 +128,7 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)

 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 }
+EXPORT_SYMBOL(fec_ptp_start_cyclecounter);

 /**
  * fec_ptp_adjfreq - adjust ptp cycle frequency
@@ -318,6 +319,7 @@ int fec_ptp_ioctl(struct net_device *ndev, struct
ifreq *ifr, int cmd)
 	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
 	    -EFAULT : 0;
 }
+EXPORT_SYMBOL(fec_ptp_ioctl);

 /**
  * fec_time_keep - call timecounter_read every second to avoid timer overrun
@@ -383,3 +385,4 @@ void fec_ptp_init(struct net_device *ndev, struct
platform_device *pdev)
 		pr_info("registered PHC device on %s\n", ndev->name);
 	}
 }
+EXPORT_SYMBOL(fec_ptp_init);
-- 
1.7.9.5

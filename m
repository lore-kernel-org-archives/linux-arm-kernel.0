From: addy.ke@rock-chips.com (addy ke)
Date: Thu, 16 Oct 2014 17:26:02 +0800
Subject: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed
 out in DMA duplex mode
In-Reply-To: <20141015130547.GE27755@sirena.org.uk>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130547.GE27755@sirena.org.uk>
Message-ID: <543F8F2A.9040904@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

The following changes is nessarry:(if tx complete, spi must be disabled too)
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 153269b..87bc16f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -418,8 +418,10 @@ static void rockchip_spi_dma_txcb(void *data)
        spin_lock_irqsave(&rs->lock, flags);

        rs->state &= ~TXBUSY;
-       if (!(rs->state & RXBUSY))
+       if (!(rs->state & RXBUSY)) {
+               spi_enable_chip(rs, 0);
                spi_finalize_current_transfer(rs->master);
+       }

        spin_unlock_irqrestore(&rs->lock, flags);
 }

Sorry for my mistake, I have not put these changes to this patch.

Do I need send patch v2 or a new patch to fix this issure?

On 2014/10/15 21:05, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 07:26:18PM +0800, Addy Ke wrote:
>> In rx mode, dma must be prepared before spi is enabled.
>> But in tx and tr mode, spi must be enabled first.
> 
> Applied, thanks.
> 

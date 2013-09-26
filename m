From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 26 Sep 2013 17:11:37 +0200
Subject: [PATCH 2/3] dma: mxs-dma: Track number of irqs for callback
In-Reply-To: <1380207996-27257-3-git-send-email-mpa@pengutronix.de>
References: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
 <1380207996-27257-3-git-send-email-mpa@pengutronix.de>
Message-ID: <52444EA9.1090502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 05:06 PM, Markus Pargmann wrote:
> Currently there is one tasklet scheduled for all interrupts between two
> mxs_dma_tasklet calls for one channel. With more than one interrupts,
> the tasklet is only called once.
> 
> Using low latency audio playback, can lead to problems. When using
> sound/soc/soc-dmaengine-pcm.c, the dmaengine_pcm_dma_complete relies on
> being called for each interrupt that occures. This function is the
> callback which is called from the mxs-dma driver in mxs_dma_tasklet.
> This can cause wrong position counters and can lead to a wrong DMA
> buffer offset. In this situation the DMA engine and pcm lib may write
> and read from the same buffer segment.
> 
> This patch adds a locked per-channel irq counter and calls the callback
> function in a loop for irq-counter times.

If you have two counters, one for generated interrupts and one for
handled interrupts, you don't need any locking.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/c342f684/attachment.sig>

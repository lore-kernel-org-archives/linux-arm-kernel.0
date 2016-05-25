From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 May 2016 15:46:23 -0700
Subject: [PATCH] tty: serial: msm: Disable restoring Rx interrupts for
 DMA Mode
In-Reply-To: <5cce36b3c1d62816feffb4048f782b20@codeaurora.org>
References: <1462896580-11554-1-git-send-email-absahu@codeaurora.org>
 <20160512014126.GK3492@codeaurora.org>
 <20160512050245.GD8453@hector.attlocal.net>
 <5cce36b3c1d62816feffb4048f782b20@codeaurora.org>
Message-ID: <20160525224623.GS3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13, charanya at codeaurora.org wrote:
> Hi Stephen/Andy,
> 
> If both Tx and Rx are used simultaneously, restoring Rx interrupts in
> msm_complete_rx_dma could lead to RXSTALE interrupt being triggered,
> when
> the ISR execution for TXLEV interrupt is completed, since
> msm_port->imr is
> rewritten to UART_IMR in msm_uart_irq. Hence, we do not have to restore
> Rx interrupts since Rx is always in DMA mode once enabled.
> 

Ok, but what's the exact sequence of events that happens? I think
we unlock the spinlock in the dma completion handler and then the
txlev interrupt runs? At that point we may have more data to push
out and then rx stale handling runs and corrupts the fifo state?

I was hoping for some sort of CPU sequence of events like:

 CPU0                   CPU1
 ----                   ----

 msm_start_rx_dma()
                       msm_complete_rx_dma()
		        spin_unlock_irqrestore(&port->lock)
 msm_uart_irq()
  msm_handle_rx_dm()
   <Read from FIFO and breaks>
                        
This patch seems correct, but the commit text isn't fully
describing the sequence of events that causes this to happen, so
it's taking a while to convince myself that this patch fixes
anything.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

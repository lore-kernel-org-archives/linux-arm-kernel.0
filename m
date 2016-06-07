From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 7 Jun 2016 16:08:44 -0700
Subject: [PATCH v3] tty:serial:msm:Do not restore Rx interrupts in DMA
In-Reply-To: <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
References: <1462896580-11554-1>
 <1465295321-10506-1-git-send-email-charanya@codeaurora.org>
Message-ID: <20160607230844.GA28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Charanya Venkatraman wrote:
> Avoid data corruption issues that result in CRC errors during file
> transfers over serial ports at higher baud rates.
> 
> The current msm_serial driver masks the FIFO Rx interrupts in
> msm_start_rx_dma() since Rx FIFO interrupts are not required in DMA
> mode. However, msm_complete_rx_dma() re-enables the Rx FIFO interrupts
> which could cause RXSTALE event to be processed when a TXLEV interrupt
> occurs.
> 
> The following is the sequence of events that could occur resulting in
> data corruption.
> 
> msm_start_rx_dma -> msm_complete_rx_dma -->
> spin_unlock_irqrestore(&port->lock) -->
> msm_uart_irq()(For TXLEV interrupt) -->  msm_handle_rx_dm() (Read from
> FIFO resulting in data corruption)
> 
> The patch fixes the issue by not restoring the RXLEV and RXSTALE
> interrupts in msm_complete_rx_dma(). These interrupts are required only
> in FIFO mode.
> 
> Signed-off-by: Charanya Venkatraman <charanya@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

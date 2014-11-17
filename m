From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Nov 2014 19:24:13 +0100
Subject: [PATCH v10 3/3] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <1416220836-7666-4-git-send-email-yao.yuan@freescale.com>
References: <1416220836-7666-1-git-send-email-yao.yuan@freescale.com>
 <1416220836-7666-4-git-send-email-yao.yuan@freescale.com>
Message-ID: <20141117182413.GC12644@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 06:40:36PM +0800, Yuan Yao wrote:
> Add dma support for i2c. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> DMA is optional, even DMA request unsuccessfully, i2c can also work well.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>

gcc found a bug:

drivers/i2c/busses/i2c-imx.c:703:7: warning: 'orig_jiffies' may be used uninitialized in this function [-Wuninitialized]
drivers/i2c/busses/i2c-imx.c:672:16: note: 'orig_jiffies' was declared here

> +	result = wait_for_completion_interruptible_timeout(
> +				&i2c_imx->dma->cmd_complete,
> +				msecs_to_jiffies(DMA_TIMEOUT));

And are you sure you want to use
wait_for_completion_interruptible_timeout() instead of
wait_for_completion_timeout() here? Unless you confirm you tested it a
lot with signals, I really cannot recommend the *_interruptible_*
version.

Other than that, good. I liked the logfile of what you tested very much!

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/9356d51e/attachment.sig>

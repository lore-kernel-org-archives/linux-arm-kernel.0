From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Fri, 30 Oct 2015 14:03:53 +0200
Subject: [PATCH] i2c: designware: Don't mask TX_EMPTY if write is in
 progress
In-Reply-To: <1446190649-1318-1-git-send-email-jszhang@marvell.com>
References: <1446190649-1318-1-git-send-email-jszhang@marvell.com>
Message-ID: <56335CA9.7080105@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/30/2015 09:37 AM, Jisheng Zhang wrote:
> Currently when i2c_msg index search is completed, TX_EMPTY interrupt
> will be masked. But if the size of i2c_msg data is longer than the size
> of the tx buffer, we still need TX_EMPTY interrupt, otherwise we will
> get "controller timed out" error.
>
> This patch fixes this issue by only masking TX_EMPTY if i2c_msg index
> search is completed and write is not in progress.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 7441cdc..a2eb212 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -542,10 +542,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>   	}
>
>   	/*
> -	 * If i2c_msg index search is completed, we don't need TX_EMPTY
> -	 * interrupt any more.
> +	 * If i2c_msg index search is completed and writing is not in progress,
> +	 * we don't need TX_EMPTY interrupt any more.
>   	 */
> -	if (dev->msg_write_idx == dev->msgs_num)
> +	if (dev->msg_write_idx == dev->msgs_num &&
> +			!(dev->status & STATUS_WRITE_IN_PROGRESS))
>   		intr_mask &= ~DW_IC_INTR_TX_EMPTY;
>
This looks a possible scenario here. What I'm wondering how is the 
transfer ending and what condition in i2c_dw_isr() causes the complete() 
call?

Assuming we break the for loop in i2c_dw_xfer_msg() with buf_len > 0 and 
dev->msg_write_idx == dev->msgs_num how we get back inside the for loop 
for writing the remaining bytes and stop command?

-- 
Jarkko

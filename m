From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 29 May 2018 15:11:09 +0200
Subject: [patch v23 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1527594545-19870-3-git-send-email-oleksandrs@mellanox.com>
References: <1527594545-19870-1-git-send-email-oleksandrs@mellanox.com>
 <1527594545-19870-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20180529131109.GD30119@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 02:49:03PM +0300, Oleksandr Shamray wrote:
> +static int aspeed_jtag_idle(struct jtag *jtag,
> +			    struct jtag_run_test_idle *runtest)
> +{
> +	struct aspeed_jtag *aspeed_jtag = jtag_priv(jtag);
> +
> +	dev_dbg(aspeed_jtag->dev, "runtest, status:%d, mode:%s, state:%s, reset:%d, tck:%d\n",
> +		aspeed_jtag->status,
> +		aspeed_jtag->mode & JTAG_XFER_HW_MODE ? "HW" : "SW",
> +		end_status_str[runtest->endstate], runtest->reset,
> +		runtest->tck);

You have dev_dbg() lines all over the place.  They can all be removed
now, right?  ftrace works well, and if you really want to do this
properly, use tracepoints in the jtag core code so that you can get the
information for all devices as needed.

But don't put them all over the driver, now that it's all working,
there's no need, right?

> +static void aspeed_jtag_xfer_push_data_last(struct aspeed_jtag *aspeed_jtag,
> +					    enum jtag_xfer_type type,
> +					    u32 shift_bits,
> +					    enum jtag_endstate endstate)
> +{
> +	if (endstate == JTAG_STATE_IDLE) {
> +		if (type == JTAG_SIR_XFER) {
> +			dev_dbg(aspeed_jtag->dev, "IR Keep Pause\n");

Like this, doesn't provide much info, does it?

thanks,

greg k-h

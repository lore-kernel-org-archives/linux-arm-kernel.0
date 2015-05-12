From: wsa@the-dreams.de (wsa at the-dreams.de)
Date: Tue, 12 May 2015 15:16:13 +0200
Subject: [PATCH v2] i2c: rk3x: Increase wait timeout to 1 second
In-Reply-To: <1431373468-18302-1-git-send-email-dianders@chromium.org>
References: <1431373468-18302-1-git-send-email-dianders@chromium.org>
Message-ID: <20150512131613.GF4447@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 12:44:28PM -0700, Doug Anderson wrote:
> Although unlikely, it is remotely possible for an i2c command to need
> more than 200ms complete. Unlike smbus, i2c devices can clock stretch
> for an unspecified amount of time. The longest time I've seen
> specified for a device is 144ms (bq27541 battery gas), but one could
> imagine a device taking a bit slower. 1 second "ought to be enough for
> anyone."
> 
> The above is not the only justifcation for going above 200ms for a
> timeout, though.  It turns out that if you've got a large number of
> printks going out to a serial console, interrupts on a CPU can be
> disabled for hundreds of milliseconds. That's not a great situation to
> be in to start with (maybe we should put a cap in vprintk_emit()) but
> it's pretty annoying to start seeing unexplained i2c timeouts.
> 
> Note that to understand why we can timeout when printk has interrupts
> disabled, you need to understand that on current Linux ARM kernels
> interrupts are routed to a single CPU in a multicore system. Thus,
> you can get:
> 
> 1. CPU1 is running rk3x_i2c_xfer()
> 2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.
> 3. I2C interrupt is ready but is set to only run on CPU0, where IRQs
>    are disabled.
> 4. CPU1 timeout expires. I2C interrupt is still ready, but CPU0 is
>    still sitting in the same vprintk_emit()
> 5. CPU1 sees that no interrupt happened in 200ms, so timeout.
> 
> A normal system shouldn't see i2c timeouts anyway, so increasing the
> timeout should help people debugging without hurting other people
> excessively.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Caesar Wang <wxt@rock-chips.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/9f423ad9/attachment.sig>

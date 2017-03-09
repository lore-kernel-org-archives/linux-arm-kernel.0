From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Mar 2017 16:37:48 +0100
Subject: [PATCH] i2c: exynos5: Avoid transaction timeouts due
 TRANSFER_DONE_AUTO not set
In-Reply-To: <20170309140533.24618-1-javier@osg.samsung.com>
References: <20170309140533.24618-1-javier@osg.samsung.com>
Message-ID: <20170309153748.tayxxf44cru7nlo6@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 11:05:33AM -0300, Javier Martinez Canillas wrote:
> After commit 7999eecb7e56 ("i2c: exynos5: fix arbitration lost handling"),
> some I2C transactions are failing because the TRANSFER_DONE_AUTO field is
> not set in the I2C_TRANS_STATUS register so the i2c->status value is left
> to -EINVAL causing the i2c->msg_complete completion to never be signaled.
> 
> For example, when reading the time of an I2C rtc on an Exynos5800 machine:
> 
> $ cat /sys/class/rtc/rtc0/time
> [   25.924594] exynos5-hsi2c 12e10000.i2c: rx timeout
> [   65.028365] max77686-rtc max77802-rtc: Fail to read time reg(-22)
> cat: /sys/class/rtc/rtc0/time: Invalid argument
> 
> The Exynos5422 manual states clearly that most I2C_TRANS_STATUS reg bits
> (including TRANSFER_DONE_AUTO) are cleared after the register is read. So
> reading has side effects and should only be done if HSI2C_INT_I2C was set.
> 
> Fixes: 7999eecb7e56 ("i2c: exynos5: fix arbitration lost handling")
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/cfdc9dd2/attachment.sig>

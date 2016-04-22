From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Apr 2016 15:31:46 +0200
Subject: [PATCH v2 2/2] i2c: exynos5: Fix possible ABBA deadlock by
 keeping I2C clock prepared
In-Reply-To: <1460855693-28225-2-git-send-email-javier@osg.samsung.com>
References: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
 <1460855693-28225-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20160422133146.GC1538@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 09:14:53PM -0400, Javier Martinez Canillas wrote:
> The exynos5 I2C controller driver always prepares and enables a clock
> before using it and then disables unprepares it when the clock is not
> used anymore.
> 
> But this can cause a possible ABBA deadlock in some scenarios since a
> driver that uses regmap to access its I2C registers, will first grab
> the regmap lock and then the I2C xfer function will grab the prepare
> lock when preparing the I2C clock. But since the clock driver also
> uses regmap for I2C accesses, preparing a clock will first grab the
> prepare lock and then the regmap lock when using the regmap API.
> 
> An example of this happens on the Exynos5422 Odroid XU4 board where a
> s2mps11 PMIC is used and both the s2mps11 regulators and clk drivers
> share the same I2C regmap.
> 
> The possible deadlock is reported by the kernel lockdep:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1

Squashed both patches into one for easier backporting, added stable and
applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/99210813/attachment.sig>

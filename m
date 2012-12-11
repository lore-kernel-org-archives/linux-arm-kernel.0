From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Dec 2012 20:55:04 +0800
Subject: [PATCH 1/2] mmc: slot-gpio: use devm_* managed functions to ease
 users
In-Reply-To: <Pine.LNX.4.64.1212110814330.29758@axis700.grange>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1212071438010.24520@axis700.grange>
 <20121207144006.GB30468@S2100-06.ap.freescale.net>
 <87d2yh4afi.fsf@octavius.laptop.org>
 <Pine.LNX.4.64.1212110814330.29758@axis700.grange>
Message-ID: <20121211125501.GA10128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 08:32:14AM +0100, Guennadi Liakhovetski wrote:
> Ok, so, you agree, that the normal case is, when these GPIO functions are 
> requested only once during probing and are released during driver 
> unbinding, and that it's worth optimisine for this case. In principle I 
> agree, and so far all 3 users of this API do that. So, maybe it would be 
> good to extend this patch series with a patch (or 3 patches, if per-driver 
> is preferred), removing mmc_gpio_free_*() calls from those drivers.

Ok, will do (with single patch approach first).

> I 
> think, however, there is one more thing to consider here: the slot-gpio 
> API contains a GPIO CD IRQ handler, which after these changes will only be 
> freed after the calls to mmc_remove_host() and mmc_free_host(). This 
> should be safe, because mmc_remove_host() sets the .rescan_disable flag. 
> After the recent patch the GPIO CD ISR also calls host->ops->card_event(), 
> so, hosts muct make sure, that this function is safe to call even after 
> the driver's .remove() method has completed. With that in mind, I think, 
> we're fine with this patch.
> 
Thanks for the point.  I think we should be fine as client drivers'
.remove() hook will generally call mmc_remove_host() and mmc_free_host()
in there.

Shawn

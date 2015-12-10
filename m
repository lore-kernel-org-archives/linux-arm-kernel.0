From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 14:32:26 +0000
Subject: [PATCH 1/2] ARM: l2x0: make it possible to disable outer sync
 from DT
In-Reply-To: <1449756855-19473-1-git-send-email-linus.walleij@linaro.org>
References: <1449756855-19473-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151210142942.GB495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 03:14:15PM +0100, Linus Walleij wrote:
> Some RealView platforms have broken outer_sync, see:
> http://marc.info/?l=linux-kernel&m=144846940516899&w=2
> 
> We got rid of the custom barriers from the machine by disabling
> outer sync, but that was just for the boardfile case. We have
> to be able to do the same in the device tree case.
> 
> Since __l2c_init() is cloning and copying the L2C vtable,
> we pass an argument to this function to optionally numb
> the outer sync operation if desired, before initializing
> the cache.
> 
> After this we can set up the cache correctly on the RealView
> PB11MPCore, and it boots rock solid with the cache enabled.
> Before this, spurious crashes would occur if we try to set
> up the cache properly.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |  1 +
>  arch/arm/mm/cache-l2x0.c                       | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index d181b7c4c522..aae7387acbdb 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -75,6 +75,7 @@ Optional properties:
>    specified to indicate that such transforms are precluded.
>  - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
>  - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
> +- arm,outer-sync-disable : disable the outer sync operation on the L2 cache.

I'm not sure what this means from a HW perspective. The "outer sync"
operation is Linux terminology and doesn't show up in the TRM for L220.

What is the (integration? HW?) bug that we're trying to avoid the effect
of? It sounds like we should be describing that.

We should at least have a better definition of what this means we must
avoid.

Thanks
Mark.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Aug 2013 16:11:18 -0600
Subject: [PATCH v8 1/7] irqchip: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <1500724.07LRpFtgcx@flatron>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-2-git-send-email-tomasz.figa@gmail.com>
 <1500724.07LRpFtgcx@flatron>
Message-ID: <5217DE06.3070005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 05:22 PM, Tomasz Figa wrote:
> This patch extends vic_of_init to parse valid interrupt sources
> and resume sources masks from device tree.
> 
> If mask values are not specified in device tree, all sources
> are assumed to be valid, as before this patch.

Can you explain further why the VIC needs this information up-front?
Presumably it can accumulate it as devices request interrupts.

> diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt

> +- valid-mask : Bit mask of valid interrupt sources (defaults to all valid)

Until a device requests an interrupt, it can be left disabled. Once
something does request it, it gets enabled. If nothing requests it, it
never gets enabled. Doesn't the result of that logic end up being the
same thing as valid-mask represents? The only difference would be if
some device requests an invalid interrupt source, but then why not just
fix the interrupt client instead of adding this property to reject the
request?

> +- wakeup-mask : Bit mask of interrupt sources that can wake up the system
> +  (defaults to all allowed)

Shouldn't drivers for end-devices request interrupts, and then set wake
enable on those interrupts, which would then trickle up the IRQ chain to
tell the VIC which interrupts to enable wakeup on?

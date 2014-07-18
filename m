From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Jul 2014 08:05:26 -0400
Subject: [PATCH v10 01/11] irq: gic: support hip04 gic
In-Reply-To: <1404957850-13340-2-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140718120526.GC24496@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

On Thu, Jul 10, 2014 at 10:04:00AM +0800, Haojian Zhuang wrote:
> There's a little difference between ARM GIC and HiP04 GIC.
> 
> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> 8 cores at most. So the difination on GIC_DIST_TARGET registers are
> different since CPU interfaces are increased from 8-bit to 16-bit.
> 
> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> support 1020 interrupts at most.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   1 +
>  drivers/irqchip/irq-gic.c                     | 141 +++++++++++++++++++-------
>  2 files changed, 108 insertions(+), 34 deletions(-)

I need to apologize.  This is my first full cycle maintaining irqchip
and I'm still coming up to speed.  The tl;dr is, I'm just not
comfortable with the approach in this patch.

If irq-gic.c was only used by one SoC, it'd be different, but in the
scenario we have, I think it would be best if this were a separate
driver, say irq-gic-hip04.c.  You can link in irq-gic-common.o to get
gic_dist_config(), and you'll be able to remove a lot of the static
functions and conditionals.

I really think it's worth the extra maintenance overhead to do it this
way.

thx,

Jason.

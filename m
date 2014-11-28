From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 28 Nov 2014 10:14:59 +0000
Subject: [PATCH 3.18-rc4 v11 2/6] irqchip: gic: Optimize locking in
 gic_raise_softirq
In-Reply-To: <alpine.DEB.2.11.1411272231450.3961@nanos>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-3-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1411272231450.3961@nanos>
Message-ID: <54784B23.9040604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 21:37, Thomas Gleixner wrote:
> On Thu, 27 Nov 2014, Daniel Thompson wrote:
> 
>> Currently gic_raise_softirq() unconditionally takes and releases a lock
>> whose only purpose is to synchronize with the b.L switcher.
>>
>> Remove this lock if the b.L switcher is not compiled in.
> 
> I think the patches are in the wrong order. We optimize for the sane
> use case first, i.e BL=n. So you want to make the locking of
> irq_controller_lock in gic_raise_softirq() conditional in the first
> place, which should have been done when this was introduced.
>
> Once you have isolated that you can apply your split lock patch for
> the BL=y nonsense.
> 
> Adding more locks first and then optimizing them out does not make any
> sense.

You original described the use of irq_controller_lock for its current
dual purpose to be an abuse of the lock. Does it really make more sense
to optimize before we correct the abuse?

How about just squashing them together? It reduces the combined diffstat
by ~10%...


Daniel.

From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Wed, 15 Oct 2014 04:08:34 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726155659.GA22977@fifteen>
References: <20140726155659.GA22977@fifteen>
Message-ID: <20141015000834.GA3983@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 07:56:59PM +0400, Evgeniy Dushistov wrote:
> The problem is that hardware handled by arm/plat-orion/gpio.c,
> require ack for edge irq, and no ack for level irq.
> 
> The code handle this issue, by two "struct irq_chip_type" per
> one "struct irq_chip_generic". For one "struct irq_chip_generic"
> irq_ack pointer is setted, for another it is NULL.
> 
> But we have only one mask_cache per two "struct irq_chip_type".
> So if we 
> 1)unmask interrupt A for "edge type" trigger,
> 2)unmask interrupt B for "level type" trigger,
> 3)unmask interrupt C for "edge type",
> 
> we, because of usage of generic irq_gc_mask_clr_bit/irq_gc_mask_set_bit,
> have hardware configured to trigger interrupt B on "edge type",
> because of shared mask_cache. But kernel think that B is "level type",
> so when interrupt B occur via "edge" reason, we don't ack it,
> and B triggered again and again.
> 

Any news about mergin this patch?


-- 
/Evgeniy

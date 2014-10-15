From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Oct 2014 11:51:48 -0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726155659.GA22977@fifteen>
References: <20140726155659.GA22977@fifteen>
Message-ID: <20141015155148.GF17447@titan.lakedaemon.net>
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
> Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>
> ---
>  arch/arm/plat-orion/gpio.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)

Applied to mvebu/fixes with a minor subject line tweak.  Thanks for the
ping!

thx,

Jason.

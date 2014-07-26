From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Sat, 26 Jul 2014 22:48:53 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726174506.GB29849@lunn.ch>
References: <20140726155659.GA22977@fifteen> <20140726174506.GB29849@lunn.ch>
Message-ID: <20140726184853.GA6730@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 07:45:06PM +0200, Andrew Lunn wrote:
> 
> Did you look at the way gpio-mvebu.c handles this? It is a little bit
> different from your solution. I'm wondering if gpio-mvebu.c is just
> different, or wrong? It does seem to be using one mask_cache for both
> edge and level trigger.
> 

Looks wrong to me. I don't look at irq handling, just unmask.
Consider the same scenario.
1)unmask interrupt A for "edge type" trigger
call mvebu_gpio_edge_irq_unmask and now CPU trigger interrupt A
if edge changed

2)unmask interupt B for "level type" trigger
call mvebu_gpio_level_irq_unmask,
gc->mask_cache have interrupt A,
so we unmask A and B for "level type" trigger.

So  expected result:
A edge type interrupt
B level type iterrupt

Actual result:
A edge type interrupt
A and B level type interrupt.

This may cause many funny things,
for example drivers may works or not works depending
on loading order.

-- 
/Evgeniy

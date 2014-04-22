From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:53:23 +0200
Subject: [PATCH v2 22/38] ARM: orion: switch to a per-platform
 handle_irq() function
In-Reply-To: <4298778.6g1TfFX2gY@wuerfel>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <4298778.6g1TfFX2gY@wuerfel>
Message-ID: <20140422235323.1119b1eb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 22 Apr 2014 23:45:55 +0200, Arnd Bergmann wrote:
> On Tuesday 22 April 2014 23:26:26 Thomas Petazzoni wrote:
> > However, the common CONFIG_MULTI_IRQ_HANDLER handler for non-DT
> > platforms in plat-orion/irq.c doesn't match the needs of
> > Orion5x. Also, it doesn't make much sense for orion_irq_init() to
> > register the multi-IRQ handler: orion_irq_init() is called once for
> > each IRQ cause/mask tuple, while the multi-IRQ handler only needs to
> > be registered once.
> 
> Since you now have the code for doing MULTI_IRQ_HANDLER on Orion5x,
> why not always enable it for both Orion and Kirkwood, and remove
> the #ifdef?

You mean the #ifdef CONFIG_MULTI_IRQ_HANDLER ? This is because this
piece of code is only needed if you build into the same image the DT
and non-DT code. For pure DT, this is not needed, as the handler is in
drivers/irqchip/irq-orion.c. For pure non-DT, this is not needed,
because we don't use MULTI_IRQ_HANDLER. However, for mixed DT and
non-DT, since the DT stuff selects MULTI_IRQ_HANDLER, the non-DT stuff
must have its own.

Also, this patch step is only *one* step in the (hopefully) right
direction. It's already a 38 patches series, so it would be good to
understand that no all cleanups can be done in this particular patch
series. What you're suggesting is not a problem introduced by this
patch series: the original code already had the #ifdef
CONFIG_MULTI_IRQ_HANDLER, so I would like to take the task of removing
it as a follow-up task, if you agree.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

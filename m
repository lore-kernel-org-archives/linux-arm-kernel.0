From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 16 Jul 2012 14:41:06 +0300
Subject: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM
 driver code
In-Reply-To: <5003FA61.2050003@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
 <1342197459-7920-2-git-send-email-t-kristo@ti.com>
 <5003FA61.2050003@ti.com>
Message-ID: <1342438866.4672.62.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-16 at 16:56 +0530, Rajendra Nayak wrote:
> On Friday 13 July 2012 10:07 PM, Tero Kristo wrote:
> > PM code doesn't really care about the PRCM wakeup + io interrupts on
> > OMAP3, as these are used only for acking PRCM internal events, and the
> > IO chain handler is taken care of by hwmod code. Thus move the interrupt
> > handling logic from pm34xx.c to prm2xxx_3xxx.c file. This patch also
> > includes a minor cleanup for removing the priority handling and replacing
> > it with a mechanism for acking pending events. This gets rid of the need
> > for registering the shared interrupt handlers in specific order.
> 
> It would be easier to review if you were to split this into 2 patches,
> one which moves functions around as-is and another which does the
> cleanup/optimization. Having both in one is kinda hard to review.

The code was like that originally, however it was broken without the
cleanup / optimization. Simply moving the code around caused a problem
with idle: the sequencing of the interrupt handlers for IO event were
reversed and thus IO chain events for UARTs were never detected (they
were acked before parsing the chain.) Having these two things in
separate patches would introduce a bisect breakage for idle.

-Tero

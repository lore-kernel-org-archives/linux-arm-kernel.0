From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 May 2013 12:26:01 +0200
Subject: [PATCH 1/3] ARM: at91: move at91 aic driver to drivers/irqchip
In-Reply-To: <20130523122000.22a9a4d0@skate>
References: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
 <1369299909-10078-2-git-send-email-b.brezillon@overkiz.com>
 <20130523090611.GG9937@game.jcrosoft.org>
 <519DE6A8.6040502@overkiz.com> <20130523120920.1df8e23a@skate>
 <20130523100951.GH9937@game.jcrosoft.org>
 <20130523122000.22a9a4d0@skate>
Message-ID: <20130523102601.GI9937@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:20 Thu 23 May     , Thomas Petazzoni wrote:
> Dear Jean-Christophe PLAGNIOL-VILLARD,
> 
> On Thu, 23 May 2013 12:09:51 +0200, Jean-Christophe PLAGNIOL-VILLARD
> wrote:
> 
> > > You can put it in <linux/irqchip/at91-aic.h>, there are already a few
> > > headers there. But I think it's not the right solution.
> > > 
> > > *However*, ideally, this header should disappear completely. All the
> > > register defines should go directly into the driver C file. The only
> > > usage of the AIC defines outside of the IRQ driver are for debug prints
> > > in the pm.c code, which I think you could get rid of.
> > > 
> > > Ditto for the at91_aic_{read,write} macros.
> > > 
> > > The NR_AIC5_IRQS can also move to the driver itself.
> > > 
> > > The only remaining one would be NR_AIC_IRQS, you can't get rid of it,
> > > because it's used for the IRQ priority arrays. But I believe keeping
> > > this one in <linux/irqchip/at91-aic.h> is reasonable.
> > 
> > do want either as we expose the register acces for pm & co
> 
> Did you read what I write? In arch/arm/mach-at91/pm.c, the only
> accesses made to the AIC registers are for pr_debug() calls, i.e only
> to print some debugging messages. I believe those ones can simply be
> removed to decouple the pm.c code from the irq.c code.

yes I read and yes I do not want to move code before we do cleanup MANDATORY

unclean code in mach-at91 is fine this is legacy, move them arround NACK

we cleanup first
> 
> > until this is cleanup NACK
> 
> Is this really the way we want to welcome contributions in the kernel
> community?
> 
> Boris, what you'd have to do is just do a few preparations patches
> in your patch set. Something like:
> 
>  * PATCH 1: remove usage of AIC registers for debug messages in pm.c
NACK I do want this debug, very usefull to debug pm

Best Regards,
J.
>  * PATCH 2: move all of at91_aic.h in irq.c, except NR_AIC_IRQS
>  * PATCH 3: move irq.c to drivers/irqchip/, and at91_aic.h to
>    include/linux/irqchip/, and adjust what's necessary
>  * and then your other patches.
> 
> Best regards,
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

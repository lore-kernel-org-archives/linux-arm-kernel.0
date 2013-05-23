From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 12:09:20 +0200
Subject: [PATCH 1/3] ARM: at91: move at91 aic driver to drivers/irqchip
In-Reply-To: <519DE6A8.6040502@overkiz.com>
References: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
 <1369299909-10078-2-git-send-email-b.brezillon@overkiz.com>
 <20130523090611.GG9937@game.jcrosoft.org>
 <519DE6A8.6040502@overkiz.com>
Message-ID: <20130523120920.1df8e23a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear boris brezillon,

On Thu, 23 May 2013 11:51:36 +0200, boris brezillon wrote:
> On 23/05/2013 11:06, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 11:05 Thu 23 May     , Boris BREZILLON wrote:
> >> Move arch/arm/mach-at91/irq.c to drivers/irqchip/irq-at91.c.
> >> Move arch/arm/mach-at91/at91_aic.h to
> >> arch/arm/mach-at91/include/mach/at91_aic.h to avoid ugly reference
> >> to header file :
> >> #include "../../arch/arm/mach-at91/at91_aic.h"
> > no we are going to drop arch/arm/mach-at91/include/mach for multi support
> >
> > arch/arm/mach-at91/include/mach is for removal
> What should be done ?
> 
> include ../../arch/arm/mach-at91/at91_aic.h from irq-at91.c
> 
> or
> 
> move at91_aic.h into drivers/irqchips and patch every non dt board to
> include ../../../drivers/irqchip/at91_aic.h

You can put it in <linux/irqchip/at91-aic.h>, there are already a few
headers there. But I think it's not the right solution.

*However*, ideally, this header should disappear completely. All the
register defines should go directly into the driver C file. The only
usage of the AIC defines outside of the IRQ driver are for debug prints
in the pm.c code, which I think you could get rid of.

Ditto for the at91_aic_{read,write} macros.

The NR_AIC5_IRQS can also move to the driver itself.

The only remaining one would be NR_AIC_IRQS, you can't get rid of it,
because it's used for the IRQ priority arrays. But I believe keeping
this one in <linux/irqchip/at91-aic.h> is reasonable.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 14:45:40 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140122173417.GT18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
Message-ID: <20140122174539.GD27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 10:34:17AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 01:49:05PM -0300, Ezequiel Garcia wrote:
> > > Looking at this patch in isolation it looks to me like the clear
> > > bridge lines should be replaced with a request_irq (as that does the
> > > clear) - is the request_irq in the wrong spot?
> > 
> > First of all, it seems to me that the first item "Disable WDT" is not
> > currently true on this driver. orion_wdt_start() seem to reset the
> > counter, but doesn't clear the WDT_EN bit. Do you think we should
> > enforce a "true" disable?
> 
> I think so.
> 
> > Regarding the sequence. Let me see if I got this problem right. The
> > concern here is about the bootloader leaving the registers in a
> > weird-state, right?
> 
> It isn't just bootloaders to worry about, but also things like kexec..
> 
> > In that case, I thought that requesting the IRQ at probe time was enough
> > to ensure the BRIDGE_CAUSE would be cleared by the time the watchdog is
> > started. However, after reading through the irqchip code again, I'm no longer
> > sure this is the case.
> 
> The watchdog should ideally be fully stopped before request_irq so
> there is no possible race.
> 

Agreed. So, let's assume we can guarantee that request_irq() does the
job of clearing the cause register (clearing pending irqs).

So, your suggestion is to put request_irq() in the watchdog start()?

Otherwise, we can ensure a watchdog full stop at probe(), before
requesting the IRQ. Both solutions should work, uh?

I don't have a strong opinion. It's not like the watchdog is going to be
frequently started/stopped (right?) so we can easily do the
request_irq() in the start() without worrying.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

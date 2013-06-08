From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jun 2013 22:19:08 +0100
Subject: [PATCH] ARM: dma: imx: Fix deadlock bug
In-Reply-To: <CAOMZO5CWT+kyf_H-Ms4yZ0isdvEadpcw22FagAUBurc5XzWQRA@mail.gmail.com>
References: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
 <CAOMZO5CWT+kyf_H-Ms4yZ0isdvEadpcw22FagAUBurc5XzWQRA@mail.gmail.com>
Message-ID: <20130608211908.GL18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 06:07:36PM -0300, Fabio Estevam wrote:
> Hi Alexander,
> 
> On Sat, Jun 8, 2013 at 5:56 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > =================================
> > [ INFO: inconsistent lock state ]
> > 3.10.0-rc4-next-20130607-00006-gf5bbfe3-dirty #59 Not tainted
> > ---------------------------------
> > inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > swapper/1 [HC0[0]:SC1[1]:HE1:SE0] takes:
> >  (&(&imxdma->lock)->rlock){?.-...}, at: [<c0230200>] imxdma_tasklet+0x1c/0x138
> > {IN-HARDIRQ-W} state was registered at:
> 
> I think the proper fix is to replace spin_lock/spin_unlock with
> spin_lock_bh/spin_unlock_bh inside imxdma_tasklet.

No, _bh versions are the tasklet-disabling versions.  You're already inside
tasklet context inside the tasklet itself.

What it's complaining about is that the tasklet takes a non-IRQ safe lock,
which _is_ taken in IRQ context.

So, what can happen is this:

- tasklet executes
- tasklet takes the lock
- interrupt occurs
- interrupt handler takes the same lock
 *deadlock*

but as I've just pointed out, there's a number of things wrong with this
driver, including one serious problem with the way the tasklet is written,
and merely changing the lock type doesn't fix it.  It needs a redesign.

From: julia@ni.com (Julia Cartwright)
Date: Wed, 15 Mar 2017 13:17:30 -0500
Subject: [RFC PATCH 0/4] pinctrl: rockchip: PREEMPT_RT_FULL fixes
In-Reply-To: <CACRpkdZXBZr_Syur3r=3GTjjrCPx4bgj0g5iNSN6rdikqkww4w@mail.gmail.com>
References: <20170313183813.3582-1-john@metanate.com>
 <CACRpkdZXBZr_Syur3r=3GTjjrCPx4bgj0g5iNSN6rdikqkww4w@mail.gmail.com>
Message-ID: <20170315181730.GC682@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 02:12:39PM +0100, Linus Walleij wrote:
> On Mon, Mar 13, 2017 at 7:38 PM, John Keeping <john@metanate.com> wrote:
> 
> > As described in Documentation/gpio/driver.txt, we should not be using
> > sleepable APIs in the irqchip implementation.  Since this includes the
> > regmap API, this patch series ends up moving the mux setup for IRQs into
> > an irq_bus_sync_unlock() handler which may result in the IRQ being
> > configured before the port has been muxed as a GPIO.
> >
> > I've marked the series as RFC because I'm not sure if this is the best
> > way to accomplish this or if there is another approach that is cleaner.
> > Also, the first patch may not be correct on RK3399 because I originally
> > wrote the patch for RK3288 on top of v4.4 where all drive updates only
> > affect a single register.  We don't need locking in this case because
> > regmap_update_bits() takes a lock on the regmap internally, but if these
> > two registers need to be updated atomically then another lock will
> > be required here - slock cannot be used if it is converted to a raw
> > spinlock since with full RT preemption the regmap's spinlock may sleep.
> 
> Nice work! It all looks good to me, let's see what Heiko says.
> 
> Please keep Julia Cartwright on the CC for this patch series, she is
> doing some coccinelle-based rewrites to use raw spinlocks as we
> speak, and she knows this stuff.
> 
> She has not targeted the Rockchip driver yet, I guess because of
> its complexity.

I haven't really given much thought to how we might generically solve
raw_spinlock problems for those drivers which make of irq_chip_generic
just yet.  I don't imagine it would be too difficult, just more work.

Thanks for the CC.

   Julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/c3ed4b8f/attachment.sig>

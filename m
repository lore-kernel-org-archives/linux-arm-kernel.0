From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Nov 2014 10:41:46 +0100
Subject: [PATCH 1/6] clk: sunxi: Add support for sun9i a80 usb clocks and
 resets
In-Reply-To: <20141104181219.GJ4042@n2100.arm.linux.org.uk>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-2-git-send-email-wens@csie.org>
 <20141104181219.GJ4042@n2100.arm.linux.org.uk>
Message-ID: <20141105094146.GB27686@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 04, 2014 at 06:12:19PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 04, 2014 at 12:07:14PM +0800, Chen-Yu Tsai wrote:
> > +	spin_lock_irqsave(data->lock, flags);
> > +
> > +	reg = readl(data->reg);
> > +	writel(reg & ~BIT(id), data->reg);
> > +
> > +	spin_unlock_irqrestore(data->lock, flags);
> 
> Don't we have generic support for atomic modification of register
> values?  Hmm, we have it for ARM only - atomic_io_modify() and
> atomic_io_modify_relaxed().
> 
> I guess we should push for those to become cross-arch if we end up
> with generic drivers shared between other architectures.

IIRC, the atomic MMIO accessors are doing exactly that, but with a
global lock for all MMIO accesses, while here we protect a single
register.

I'm not really sure that sharing this spinlock across the whole system
is worth it and scales that well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/85169585/attachment.sig>

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 15:18:58 +0000
Subject: [PATCH 01/11] tty: amba-pl011: add register accessor functions
In-Reply-To: <5638CA7D.8000404@codeaurora.org>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
 <5638CA7D.8000404@codeaurora.org>
Message-ID: <20151103151858.GZ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 08:53:49AM -0600, Timur Tabi wrote:
> Russell King wrote:
> >+static unsigned int pl011_read(void __iomem *base, unsigned int reg)
> >+{
> >+	return readw(base + reg);
> >+}
> >+
> >+static void pl011_write(unsigned int val, void __iomem *base, unsigned int reg)
> >+{
> >+	writew(val, base + reg);
> >+}
> 
> This has the same problem as the original, in that it doesn't support the
> SBSA subtype 13.
> 
> I'll post my version soon that addresses this.  Maybe you can consider it as
> a replacement for your patch 1/11.

(I know you've already replied saying to ignore this, but I'm going to
reply to this anyway.)

This is one step in a series of single transformations to the code,
where this one merely replaces readw()/writew() with a local accessor
function.  Adding other changes into this patch would mean that it's
no longer a single transformation.

This "single transformation" theme applies across every patch in this
series, and IMHO shows how the addition of ZTE should have been done
in the first place: a series of single transformations, each one being
fairly obvious and easy to review.

Yes, it produces a bigger patch set, but it means that if there's a
problem with one of the transformations, the whole work doesn't need
to be reverted.  Eg, you'll notice that the more "dodgy" changes (such
as removing register offset entries) are done towards the end of the
series meaning that if there's a problem removing those, either a
single patch can be reverted, or the series can be reverted back to
that point and the benefit of the previous patches isn't lost.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

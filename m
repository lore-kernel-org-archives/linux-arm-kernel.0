From: kim.phillips@freescale.com (Kim Phillips)
Date: Wed, 11 Jul 2012 20:50:31 -0500
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120711025753.GA14060@S2101-09.ap.freescale.net>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
 <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
 <20120709065116.GB11635@S2101-09.ap.freescale.net>
 <20120709194514.e6a854441fa69a54fadc296d@freescale.com>
 <20120710023226.GA19649@S2101-09.ap.freescale.net>
 <20120710190221.0f26b6f158257b00c40e6a4e@freescale.com>
 <20120711025753.GA14060@S2101-09.ap.freescale.net>
Message-ID: <20120711205031.a6622a96311bdcc273272621@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jul 2012 10:57:55 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Tue, Jul 10, 2012 at 07:02:21PM -0500, Kim Phillips wrote:
> > how, without the "simple-bus" addition to the sec_mon compatibles
> > list in the imx6 device tree (which isn't present in this patch)?
> > 
> This patch does not present anything about sec_mon node.

it makes a change to its definition in the device tree documentation.

>  It's all about sec_mon_rtc_lp node.

the change is that the sec_mon node now includes the sec_mon_rtc_lp
node, and they are related, just as in h/w.

> The driver itself does not know if the
> rtc_lp node is a subnode of sec_mon node at all.

I understand that, but as it stands (and AFAICT), this patch by
itself doesn't enable the driver to be probed on _any_ platform,
including ARM.

> Can you please tell me what exact change you expect me to make on
> drivers/rtc/rtc-snvs.c?  The patch merely adds a lp-rtc driver and
> should not include any platform specific changes (dts, etc.)  The
> driver and dts changes are two orthogonal parts, and should go via
> RTC tree and ARCH tree separately.

That's odd; I would expect all enabling changes to either be
included in the same patch, or at least in the same patchseries, and
one subsystem maintainer ack the other.  If ARM-related patch
processes differ somehow, then so be it.

> > interesting.  When I add
> > 
> > +#define readl in_be32
> > +#define writel(val, addr)             out_be32(addr, val)
> > 
> > to the top of the driver, the soft-lockup moves to
> > rtc_read_lp_counter().  I'm trying to verify if I have the right h/w
> > revision.
> > 
> You can submit an incremental patch later to make the driver work for
> powerpc.

Turns out there was a mistake in the QorIQ series documentation
that exposed SRTC registers even though the SNVS LP SRTC isn't
physically present on any of the Power based parts; I've since
notified the documentation team.

Thanks,

Kim

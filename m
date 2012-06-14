From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 15:55:30 +0800
Subject: [PATCH 16/16] ARM: imx: enable SPARSE_IRQ for imx platform
In-Reply-To: <CAN1soZw5NZq1RP3z6w1P+5PQTjuT-hPucCwbiG3CQk0UpCacbQ@mail.gmail.com>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
 <CAN1soZw5NZq1RP3z6w1P+5PQTjuT-hPucCwbiG3CQk0UpCacbQ@mail.gmail.com>
Message-ID: <20120614075529.GE31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:40:09PM +0800, Haojian Zhuang wrote:
> On Thu, Jun 14, 2012 at 1:59 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > As all irqchips on imx have been changed to allocate their irq_descs,
> > and all unneeded mach/irqs.h inclusions on imx have been cleaned up,
> > now it's time to select SPARSE_IRQ for imx/mxc.
> >
> > The SPARSE_IRQ support forces irqs allocation starting from 16. ?All
> > those static irq number definition for SoCs need to shift 16 to keep
> > non-DT boot works.
> >
> Do we really need to shift 16 to keep non-DT boot works?
> 
Yes, for my case.

> I think that we can allocate "new irq numbers - NR_IRQS_LEGACY" in interrupt
> controller in DT mode.

In DT mode, I need to do nothing about it, because with irqdomain
support, DT core will translate the hardware irq number encoded in
device tree to Linux irq.  That said, platform_get_irq will
automatically return me Linux irq number.

> And we needn't shift NR_IRQS_LEGACY in non-DT mode,
> since irq numbers are already specified in .nr_irqs of machine description.
> 
I took a different (IMO, cleaner) approach than setting .nr_irqs in
mach_desc.  With all irqdescs dynamically allocated, I do not need
to set .nr_irqs to have irq core preallocate all these irqs.  IMO,
that's the point of SPARSE_IRQ.  To me, the .nr_irqs approach is just a
quick and dirty path to SPARSE_IRQ, but we gain nothing from that
except getting rid of platform NR_IRQS definition.

Regards,
Shawn

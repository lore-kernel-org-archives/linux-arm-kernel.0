From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 7 Jul 2015 12:05:39 +0200
Subject: [PATCH 4.2-rc1 v21 3/6] irqchip: gic: Introduce plumbing for IPI
 FIQ
In-Reply-To: <1436188438-9478-4-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
 <1436188438-9478-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CAOpc7mHS8QmpGu7jtzTj6GFU8p+JU9XB9E_vpQfL3e7vEZwT6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Currently it is not possible to exploit FIQ for systems with a GIC, even
> on systems are otherwise capable of it. This patch makes it possible
> for IPIs to be delivered using FIQ.

I wonder if gic_set_group_irq() can easily be married with mxc_set_irq_fiq().

The driver sound/soc/fsl/imx-pcm-fiq.c uses mxc_set_irq_fiq() to
connect an (assembly) FIQ handler with a hardware IRQ. However, the
underlying implementation of mxc_set_irq_fiq() is only supported for
TZIC and AVIC (see arch/arm/mach-imx/irq-common.c).

On my i.MX6, which doesn't have an AVIC/TZIC but a GIC I could use a
method to turn a normal IRQ into a FIQ :-)

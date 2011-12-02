From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 2 Dec 2011 11:45:10 +0800
Subject: [PATCH 2/2] arm/imx: fix irq_base for gpio
In-Reply-To: <4ED7C6DC.2090402@boundarydevices.com>
References: <1322727549-10852-1-git-send-email-shawn.guo@linaro.org>
 <1322727549-10852-2-git-send-email-shawn.guo@linaro.org>
 <4ED7C6DC.2090402@boundarydevices.com>
Message-ID: <20111202034509.GM711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:26:36AM -0700, Troy Kisky wrote:
> On 12/1/2011 1:19 AM, Shawn Guo wrote:
> >When gpio core dynamically allocate gpio number for a port, it starts
> >from the end of the total range, 0 ~ ARCH_NR_GPIOS.  That said, the
> >earlier a port gets probed, the bigger gpio number it gets assigned.
> >To match this, the irq_base for gpio should be assigned from
> >'MXC_GPIO_IRQ_START + ARCH_NR_GPIOS' decreasingly.
> >
> >Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> >---
> >  arch/arm/mach-imx/mach-imx6q.c |    5 ++---
> >  arch/arm/mach-mx5/imx51-dt.c   |    5 ++---
> >  arch/arm/mach-mx5/imx53-dt.c   |    5 ++---
> >  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> I thought the rationale for GPIOLIB to start at the end was to more quickly
> find a free group. If this isn't important, then I'd rather see
> GPIOLIB changed
> to be increasing. Although I do like that gpio_irq_base is always
> set the same
> way with your patch. Would
> 
> static int gpio_irq_base = MXC_GPIO_IRQ_START;
> 
> work as well, if you kept it increasing instead ?
> 
Inspired by gpio-tegra patches from Stephen, I will send similar
patches for gpio-mxc to clean up the use of MXC_GPIO_IRQ_START, which
will in turn remove the whole dependency between gpio number and gpio
irq.  So, yes, it deserves a thorough fix instead of this temporary one.

-- 
Regards,
Shawn

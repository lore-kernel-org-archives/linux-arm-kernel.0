From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 19 Jun 2012 14:16:38 +0800
Subject: [PATCH 16/16] ARM: imx: enable SPARSE_IRQ for imx platform
In-Reply-To: <20120618150422.GG19249@S2101-09.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
 <20120618084850.GG25447@shlinux2.ap.freescale.net>
 <20120618150422.GG19249@S2101-09.ap.freescale.net>
Message-ID: <20120619061637.GB10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 11:04:24PM +0800, Shawn Guo wrote:
> On Mon, Jun 18, 2012 at 04:48:53PM +0800, Dong Aisheng wrote:
> > On Thu, Jun 14, 2012 at 01:59:47PM +0800, Shawn Guo wrote:
> > > As all irqchips on imx have been changed to allocate their irq_descs,
> > > and all unneeded mach/irqs.h inclusions on imx have been cleaned up,
> > > now it's time to select SPARSE_IRQ for imx/mxc.
> > > 
> > > The SPARSE_IRQ support forces irqs allocation starting from 16.  All
> > > those static irq number definition for SoCs need to shift 16 to keep
> > > non-DT boot works.
> > > 
> > It seems shift 16 is to get the correct linux virt irq, right?
> Yes.
> 
> > If yes, i do not like this approach very much since it's an implicit way
> > based on users know how legacy irqdomain works internally.
> > 
> I do not quite follow on this.  Users do not need to know how legacy
> irqdomain works internally.  They are still using those static MX*_INT_*
> macros.  All they need to know is there is a 16 shift between hardware
> irq and Linux irq number when they look at /proc/interrupts.
> 
Hmm, i mean 'users' driver onwers here.
You shift 16 because you know after irqdomain map the virt irq will be shifting 16
according current status.
It may not always correct if something changes.
For example, if more irq ranges were pre-allocated except NR_IRQS_LEGACY by
someone else or if the irq domain type is changed by the driver.
In above case, i wonder the manual shifting may not work anymore.

With irqdomain support, i think we should always using the standard way
to get the virt irq number rather than assuming how virt irq ranges is used and what's the
irqdomain reverse map type is and using the virt irq directly.

> > Ideally i would see we keep the code as before that still using hw irqs
> > for device resource definition, but convert to linux virt irq in a standard
> > irqdomain map way when adding devices by calling imx_add_platform_device.
> > 
> What's the point of hiding this irq number conversion in
> imx_add_platform_device?  
It's standard and safe way.

> The irq number used in resource definition
> should simply just be Linux irq.  Doing what you suggest here will
No, it's should be hw irq.
Like you did for gpio driver:
generic_handle_irq(irq_find_mapping(port->domain, irqoffset));

Using irq_find_mapping to get the correct linux virt irq number.

> only confuse users when they look at /proc/interrupts and those static
> IRQ definitions.
I think we may need more information about irqdomain in /proc/inerrupts
or some where else to make people understand easily when have irq domain
support.

> 
> BTW, not all the platform_devices are added by calling
> imx_add_platform_device on imx.
> 
Then, we may need find way to do same thing for them too.

Regards
Dong Aisheng

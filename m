From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Thu, 10 Mar 2011 14:37:15 +0100
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <20110308124023.5a952d13@archvile>
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	<87oc5puwg3.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
	<87fwqyvrzf.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA1940F8@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110307180700.GQ29521@pengutronix.de>
	<20110308124023.5a952d13@archvile>
Message-ID: <20110310133715.GC29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, Mar 08, 2011 at 12:40:23PM +0100, David Jander wrote:
> 
> Hi Sascha,
> 
> On Mon, 7 Mar 2011 19:07:00 +0100
> "s.hauer at pengutronix.de" <s.hauer@pengutronix.de> wrote:
> >[...]
> > > The current imx for-next tree is not booting on my Babbage board. Is
> > > it okay for you with your HW. I'll have to debug the booting part
> > > first.
> > 
> > Probably because other than kconfig states i.MX51 and i.MX53 cannot be
> > compiled in one kernel. the for-next branch boots fine on my babbage.
> 
> Would you mind explaining (or pointing to an explanation) as to why this is
> not supposed to work? Given the high level of compatibility between MX51 and
> MX53, I'd say there must be a very good reason not to enable a single binary
> kernel for both. Or is this just temporary brokenness?

i.MX51 and i.MX53 have different phys_offsets. Look at
arch/arm/mach-mx5/Makefile.boot:

   zreladdr-$(CONFIG_ARCH_MX50) := 0x70008000
params_phys-$(CONFIG_ARCH_MX50) := 0x70000100
initrd_phys-$(CONFIG_ARCH_MX50) := 0x70800000
   zreladdr-$(CONFIG_ARCH_MX51) := 0x90008000
params_phys-$(CONFIG_ARCH_MX51) := 0x90000100
initrd_phys-$(CONFIG_ARCH_MX51) := 0x90800000
   zreladdr-$(CONFIG_ARCH_MX53) := 0x70008000
params_phys-$(CONFIG_ARCH_MX53) := 0x70000100
initrd_phys-$(CONFIG_ARCH_MX53) := 0x70800000

Compiling a kernel for i.MX50 and i.MX53 will work, but compiling a
kernel for i.MX51 and i.MX53 will and up with a kernel assuming SDRAM
at 0x70000000 which will fail on a i.MX51. We need
phys_to_virt/virt_to_phys runtime patching to get this right. This
will be merged in the next merge window.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

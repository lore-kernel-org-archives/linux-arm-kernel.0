From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Feb 2015 21:15:47 -0600
Subject: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
In-Reply-To: <20150224030141.GR32521@atomide.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
 <20150224030141.GR32521@atomide.com>
Message-ID: <20150224031547.GB15941@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 23, 2015 at 07:01:42PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150223 18:43]:
> > * Felipe Balbi <balbi@ti.com> [150223 18:28]:
> > > Hi,
> > > 
> > > On Mon, Feb 23, 2015 at 05:59:04PM -0800, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [150223 16:09]:
> > > > > Hi Nishanth,
> > > > > 
> > > > > Olof told me about a new L3 error happening on omap5-uevm with
> > > > > v4.0-rc1:
> > > > > 
> > > > > WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> > > > > 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data Access in Supervisor mode during Functional access
> > > > > ...
> > > > > 
> > > > > I tried bisecting this with no luck, but narrowed it down to
> > > > > having CONFIG_CPUFREQ_DT=y causing it, while =m wont' trigger
> > > > > it. This got changed by commit 40d1746d2eee ("ARM:
> > > > > omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> > > > > 
> > > > > Any ideas?
> > > > 
> > > > Hmm so setting CONFIG_CPUFREQ_DT=m in arch/arm/configs/omap2plus_defconfig
> > > > produces the same output with make omap2plus_defconfig as with =y.. So
> > > > CPUFREQ_DT can't be the real cause of the problem.
> > > > 
> > > > It's now looking like the l3-noc warning does not get triggered on
> > > > every boot.
> > > > 
> > > > It also seems the zImage triggering the error does not trigger the
> > > > error on every boot. To trigger the error, it seems the device needs to
> > > > be powered down for at least 10 or so seconds between the boots.
> > > > So far no luck reproducing the error on v3.19.
> > > > 
> > > > The easy way to reproduce is to power down omap5 for at least 10 seconds,
> > > > make omap2lus_defconfig on v4.0-rc1 and boot it.
> > > > 
> > > > And so far it looks like next-20150204 works and next-20150209
> > > > failed at once so far. But of course I would not trust anything
> > > > at this point :)
> > > 
> > > got a log of the failure ? Is it pointing to a device or one of the L4s?
> > 
> > Well mostly the MASTER MPU TARGET L4PER2, the following stack dump is
> > really the stack dump of the l3_interrupt_handler.
> >  
> > > Might be worth to boot with just the bare minimum (UART & timers) and
> > > disable everything else. You might need to build busybox and append that
> > > to the kernel so you don't need to rely on MMC/USB/etc for rootfs.
> > > 
> > > After that, you could start enabling modules one by one (as modules, not
> > > built-in) and loading them one by one to see which one causes the
> > > failure. Big PITA, I know, but I can't think of any other way to go
> > > about this.
> > 
> > It seems the best way to deal with this is to make the l3_handle_target
> > actually show the address where the error happened to limit it down
> > to a single device..
> 
> Looks like the address is 0 for "Custom Error". Anyways, reverting

yeah, that's because the error comes from l4per2, not l3 :-)

> a fix for similar issue found on omap3 so far seems to help, that's
> 3d009c8c61f9 ("gpio: omap: Fix bad device access with setup_irq()").

if we revert that, we regress omap3, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/ddbd7a61/attachment.sig>

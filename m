From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Feb 2015 21:12:34 -0600
Subject: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
In-Reply-To: <20150224023505.GQ32521@atomide.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
Message-ID: <20150224031234.GA15941@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 06:35:06PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150223 18:28]:
> > Hi,
> > 
> > On Mon, Feb 23, 2015 at 05:59:04PM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [150223 16:09]:
> > > > Hi Nishanth,
> > > > 
> > > > Olof told me about a new L3 error happening on omap5-uevm with
> > > > v4.0-rc1:
> > > > 
> > > > WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> > > > 4000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle): Data Access in Supervisor mode during Functional access
> > > > ...
> > > > 
> > > > I tried bisecting this with no luck, but narrowed it down to
> > > > having CONFIG_CPUFREQ_DT=y causing it, while =m wont' trigger
> > > > it. This got changed by commit 40d1746d2eee ("ARM:
> > > > omap2plus_defconfig: use CONFIG_CPUFREQ_DT").
> > > > 
> > > > Any ideas?
> > > 
> > > Hmm so setting CONFIG_CPUFREQ_DT=m in arch/arm/configs/omap2plus_defconfig
> > > produces the same output with make omap2plus_defconfig as with =y.. So
> > > CPUFREQ_DT can't be the real cause of the problem.
> > > 
> > > It's now looking like the l3-noc warning does not get triggered on
> > > every boot.
> > > 
> > > It also seems the zImage triggering the error does not trigger the
> > > error on every boot. To trigger the error, it seems the device needs to
> > > be powered down for at least 10 or so seconds between the boots.
> > > So far no luck reproducing the error on v3.19.
> > > 
> > > The easy way to reproduce is to power down omap5 for at least 10 seconds,
> > > make omap2lus_defconfig on v4.0-rc1 and boot it.
> > > 
> > > And so far it looks like next-20150204 works and next-20150209
> > > failed at once so far. But of course I would not trust anything
> > > at this point :)
> > 
> > got a log of the failure ? Is it pointing to a device or one of the L4s?
> 
> Well mostly the MASTER MPU TARGET L4PER2, the following stack dump is
> really the stack dump of the l3_interrupt_handler.
>  
> > Might be worth to boot with just the bare minimum (UART & timers) and
> > disable everything else. You might need to build busybox and append that
> > to the kernel so you don't need to rely on MMC/USB/etc for rootfs.
> > 
> > After that, you could start enabling modules one by one (as modules, not
> > built-in) and loading them one by one to see which one causes the
> > failure. Big PITA, I know, but I can't think of any other way to go
> > about this.
> 
> It seems the best way to deal with this is to make the l3_handle_target
> actually show the address where the error happened to limit it down
> to a single device..

you can't really do that from within l3. It doesn't have enough
information to figure that out. Since it pointed you to l4per2, then you
need to decode l4per2's debug registers. That has never been
implemented, though. What happened here is that l4per2 detected the
bogus access from one of the devices attached to it and passed the error
up to l3. Since we only have l3 decoding, that's what you see and it
ends up being really cryptic.

If you decode l4per2's registers, I'm sure it'll point you to a real
device. I guess just to prove the concept, you just hack it inside l3
irq handler, though ideally we would have a real drivers/bus/omap-l4.c,
or something like that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/39e82c45/attachment-0001.sig>

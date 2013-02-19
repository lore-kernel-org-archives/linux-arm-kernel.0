From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 20:34:20 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130219174336.GG5724@atomide.com>
References: <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com>
 <20130219165753.GD5736@arwen.pp.htv.fi>
 <20130219174336.GG5724@atomide.com>
Message-ID: <20130219183420.GA6851@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 19, 2013 at 09:43:36AM -0800, Tony Lindgren wrote:
> > On Tue, Feb 19, 2013 at 08:38:20AM -0800, Tony Lindgren wrote:
> > > > > * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > > > > > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > > > > > 
> > > > > > > I don't think so as hwmod should only touch the sysconfig space
> > > > > > > when no driver has claimed it.
> > > > > > 
> > > > > > hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> > > > > > and resume operations, and during device enable and disable operations.  
> > > > > > Here's the relevant code:
> > > > > > 
> > > > > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> > > > > > 
> > > > > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> > > > > 
> > > > > But that's triggered by runtime PM from the device driver, right?
> > > > 
> > > > Yes - for devices with drivers, it will hopefully be called by the 
> > > > driver.
> > > > 
> > > > > I think it's fine for hwmod to do that as requested by the device
> > > > > driver via runtime PM since hwmod is the bus glue making the drivers arch
> > > > > independent.
> > > > > 
> > > > > I think the only piece we're missing for that is for driver to run
> > > > > something like pm_runtime_init() that initializes the address space
> > > > > to hwmod. 
> > > > 
> > > > In the current design, we might be able to do this during the driver's 
> > > > first call to pm_runtime_get*().  I think that's the first point that we 
> > > > can hook into the PM runtime code.
> > > 
> > > Sounds doable and generic for now.
> > 
> > this isn't really a nice way IMHO. You will end up with drivers assuming
> > that certain details will be initialized whenever it calls
> > pm_runtime_get() for the first time. Then, for devices such as UART
> > which, when used as console, will not get pm_domain->runtime_resume()
> > called because pm_runtime_set_active() has been called right before.
> > 
> > IOW, this will not work for all cases and very soon we will have bug
> > reports.
> 
> Some generic way to init this from drivers is needed, I'm out of ideas
> here though.

that's fair, but exposing driver-specific details via a static inline in
a header which might or might not be called from hwmod isn't the best
choice IMHO.

the problems this could cause are numerous, specially when you consider
drivers which are shared among multiple architectures (think musb, dwc3,
ehci, ohci, xhci, ahci_platform, etc).

> > > > Once the hwmod code is moved out to be a bus, I'm hoping we can do this 
> > > > through the driver making a dev->bus->enable_device() call - similar to 
> > > > the way PCI drivers call pci_enable_device(), but not bus-specific.  That 
> > > > should remove our current dependency on CONFIG_PM_RUNTIME for OMAP devices 
> > > > to work correctly :-(
> > > > 
> > > > > Just to recap what we've discussed earlier, the reasons why we want
> > > > > reset and idle functions should be in the driver specific header are:
> > > > > 
> > > > > 1. There's often driver specific logic needed in addition to the
> > > > >    syconfig tinkering in the reset/idle functions.
> > > > 
> > > > It's been a while since I last tabulated this.  But my recollection was 
> > > > that some kind of IP block-specific reset code is needed for about 7% to 
> > > > 10% of the OMAP IP blocks.
> > > 
> > > Yes it's not too many, but the issue there is the driver specific code
> > > that's duplicated in both places. And sounds like the solution to that
> > > is to make driver specific reset code a static inline function in the
> > > driver header as discussed earlier so bus code can call it when there's
> > > no driver loaded.
> > 
> > this wouldn't work. How would you write a reset for i2c which can be
> > called for all instances even when there is no driver loaded ? What
> > would be the arguments to such a call ?
> > 
> > If you have something like:
> > 
> > static inline void omap_i2c_reset(int bus_nr);
> > 
> > you would need to keep track of the bus numbers even when there is no
> > driver around and if there is a driver, you would have to ask i2c-omap.c
> > to track all available instances and convert that number to the proper
> > struct omap_i2c pointer. None of those sound like a good plan IMO.
> > 
> > From a driver perspective, we want all our calls to have our private
> > structure or a *dev as argument. Those are only avaiable when driver is
> > around and anything which doesn't take those as argument will force
> > driver to add extra unnecessary churn.
> 
> If we cannot find a clean way to reset unclaimed devices without duplicating
> driver specific code at the bus level, then let's just assume the drivers 
> need to probe to reset them even if the device is not used on a particular
> board.

that wouldn't work either. Whenever you have a product which wants to
optimize memory footprint, will start by disabling unused modules, then
all of your problems are back and we will start to receive bug reports
because of an artificial requirement created by OMAP ;-)

hwmod already has access to all device addresses, so why not reset early
when you build the omap device ?

How about this completely untested patch ? I guess it won't work because
I'm not making sure clocks are enabled for the particular hwmod to be
accessible, but it shows the idea:

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e065daa..58de594 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -354,6 +354,13 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			goto odbfd_exit1;
 		}
 		hwmods[i] = oh;
+
+		/*
+		 * reset all hwmods early on, but even if it fails to reset
+		 * let it go through, driver might still be able to recover.
+		 */
+		ret = omap_hwmod_reset(oh);
+		WARN(ret < 0, "%s failed to reset\n", oh->name);
 	}
 
 	od = omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);

> > > > One thing that's unclear to me for the DT case is how we'll bind the 
> > > > driver-specific parts of the reset code to the device, particularly in the 
> > > > case where there's no driver present.  It should be possible to place an 
> > > > initcall in the driver-specific header, but that seems like a hack.  Any 
> > > > thoughts on this?
> > > 
> > > I think we can just initialize the driver-specific reset functions
> > > in hwmod code and those can just call the driver specific inline functions
> > > as needed in the driver specific header files.
> > 
> > please don't. This will not work as you expect, we will just add more
> > special cases to drivers which will be even more complex to maintain.
> > 
> > What you want is a generic reset callback somewhere. For cases where
> > there is no driver around, then I'm not sure what to do, but doing early
> > reset sounds like a better plan than late reset, so resetting on
> > omap_device_build_from_dt() sounds better IMHO, although it concerns me
> > cases of -EPROBE_DEFER and what that would mean in the long run...
> 
> Well this problem too will disappear if we require the drivers to probe
> to reset things properly.

see above, you can't guarantee that, not to mention that this is a too
vague requirement. If a platform doesn't use a driver, why would they
enable it ? And how do you make sure that platform A needs the full
driver but platform B only needs it for a quick reset ? Why would we
allocate memory, IRQ, i/o memory space (ioremap), enable clocks and so
many more resources just for that ? Besides, that would already cause
problems since every DT node with status = "disabled" will not probe.

Changing DT data today to status = enabled by default won't cut since we
already lost control over DT data. I mean, we don't know which
bootloaders are supporting which DT version and relying on appended DTB
only will not work in the long run since the image will get too large
when you want to support multiplatform.

> Then the hwmod late_init would just be a printk warning about unclaimed
> devices.

is that even necessary ? No other architecture (not even other ARM SoCs)
make such distinction, why would we be different ?

> In any case, we should not reset things early unless requested from driver
> probe. Too many things can go wrong before we have a proper console
> available.

OTOH, initializing from a known state would be much, much better and
would force us to remove *all* bootloader dependencies.

We just need to figure out how to handle console until omap uart is
reset, but I guess 8250 is already taking care of that for us, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/9d7f61fa/attachment-0001.sig>

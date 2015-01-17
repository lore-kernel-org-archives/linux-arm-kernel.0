From: greg@kroah.com (Greg KH)
Date: Sat, 17 Jan 2015 05:56:30 -0800
Subject: [systemd-devel] Making udev emit a signal when it is done
 loading modules
In-Reply-To: <54BA20D0.7060402@redhat.com>
References: <54BA20D0.7060402@redhat.com>
Message-ID: <20150117135630.GA25585@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
> Dear udev developers,
> 
> We (me and some kernel devs mostly) would like to add support to
> the kernel for userspace telling the kernel that it is done with
> the *initial* loading of modules, with the purpose of cleaning up
> (disabling) unused harware resources like e.g. regulators and
> clocks.

But you don't "know" when that happens.  Especially with discoverable
busses (PCI, USB, etc.), you know this :)

> Currently the kernel does this cleanup just before it starts init
> (which may very well be init from a ramdisk). In some cases this
> is too early really, because later on a module may get loaded
> which needs this resources, these resources will then get turned
> on again by the loaded driver, and most of the time this is not
> an issue, but sometimes it is.
> 
> I realize very well that there is no magic moment where udev is
> really ever done loading modules, but the case which we want to
> support only involves devices which are *already enumerated*, but
> may not yet have a driver loaded, when udev starts. We would like
> udev to emit a signal (ABI to be discussed) when it is done
> trying to load modules for everything which was already enumerated
> when it starts, iow when there are no new device events pending
> anymore when udev does its initial hotplug replay.

The kernel doesn't even "know" when this type of thing is, how can udev
know this?

> So the question to you is would you be willing to include such
> functionality in udev ?  Note this signal would need to be emitted
> when udev from the real rootfs is done with the initial module
> loading, as the real rootfs may very well have more modules
> available then the initrd.
> 
> ###
> 
> With the generic story above told let me also give the concrete
> example / problem which has let to me asking this (note this has
> been brought up before on various kernel lists, it is a
> re-occuring theme, this is just an example really) :
> 
> The problem at hand is a sata connector which also has a sata-power
> connector on an embedded (ish) board where the sata-power is
> controlled through a gpio. The sata-power connector is modeled
> in devicetree as a power-supply and this supply gets controlled
> by the ahci_platform driver.
> 
> The disk power may very well have already been turned on by the
> bootloader, so we add a regulator-boot-on property to the regulator
> node in devicetree to make sure that it is left untouched when the
> regulator driver loads. If the ahci_platform driver is build into
> the kernel, it will then take control of the regulator and
> everything works well.
> 
> If however the ahci_platform driver is a module, then as soon as
> the kernel is ready to start init, unused regulators are turned off
> and the disk looses its power while spinning and ends up doing an
> emergency heads park.

What turns off the power in this situation?  The kernel?  Or userspace?
Don't you have control of this?

Have you tried to even create a patch that could do this type of thing
to udev to see if it is even possible?

thanks,

greg k-h

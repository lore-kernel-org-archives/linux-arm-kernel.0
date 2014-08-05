From: greg@kroah.com (Greg KH)
Date: Tue, 5 Aug 2014 11:52:16 -0700
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <20140805092107.GM30282@n2100.arm.linux.org.uk>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
 <9930f46074e04c90a58fa6b01e055ff2@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140805061658.GG2167@dragon>
 <20140805092107.GM30282@n2100.arm.linux.org.uk>
Message-ID: <20140805185216.GA11563@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 10:21:07AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 05, 2014 at 02:16:59PM +0800, Shawn Guo wrote:
> > On Tue, Aug 05, 2014 at 02:06:18PM +0800, Duan Fugang-B38611 wrote:
> > > I use linux net tree cannot reproduce the issue like your log, but show another issue as below log:
> > > (imx6dl sabresd board, Nfs mount rootfs)
> > > 
> > > root at freescale ~$ uname -r
> > > 3.16.0-rc5-01146-gda388973d	
> > 
> > Fabio already bisect the issue down to commit a71e3c37960c (net: phy:
> > Set the driver when registering an MDIO bus device).  This commit
> > landed on mainline after v3.16-rc7, and that may be the reason you
> > do not see it on net tree (3.16.0-rc5-01146-gda388973d).
> 
> Oh my... that commit looks totally bogus.
> 
> It has the effect (as can be seen from the oops) of attaching the MDIO bus
> device (itself is a bus-less device) to the platform driver, which means
> that if the platform driver supports power management, it will be called
> to power manage the MDIO bus device.
> 
> Moreover, drivers do not expect to be called for power management
> operations for devices which they haven't probed, and certainly not for
> devices which aren't part of the same bus that the driver is registered
> against.
> 
> The commit text says:
> 
>     net: phy: Set the driver when registering an MDIO bus device
> 
>     mdiobus_register() registers a device which is already bound to a driver.
>     Hence, the driver pointer should be set properly in order to track down
>     the driver associated to the MDIO bus.
> 
>     This will be used to allow ethernet driver to pin down a MDIO bus driver,
>     preventing it from being unloaded while the PHY device is running.
> 
> which misses the implications of adding an unknown parent driver to that
> class device - and the argument that it's just to track down the parent
> driver is totally bogus.  That can already be done - it's the parent
> device's driver pointer.  Let's take the example of FEC.
> 
> /sys/devices/soc0/soc/2100000.aips-bus/2188000.ethernet/mdio_bus/2188000.ethernet/
> 
> lrwxrwxrwx 1 root root    0 Aug  5 10:07 device -> ../../../2188000.ethernet
> drwxr-xr-x 2 root root    0 Aug  5 10:07 power
> lrwxrwxrwx 1 root root    0 Aug  5 10:07 subsystem -> ../../../../../../../class/mdio_bus
> -rw-r--r-- 1 root root 4096 Aug  5 10:07 uevent
> 
> (note that the "%s-%x" format for this device in fec_main.c has been
> truncated - that's another bug!)
> 
> Remembering that this is a class device, these devices have a "device"
> symlink which point at the parent device.  Normal devices which are bound
> to a driver have a "driver" symlink.
> 
> So, the driver can be reached by following the "device" pointer, and then
> following the "driver" symlink:
> 
> /sys/devices/soc0/soc/2100000.aips-bus/2188000.ethernet/mdio_bus/2188000.ethernet/device/
> ...
> lrwxrwxrwx 1 root root    0 Aug  5 10:08 driver -> ../../../../../bus/platform/drivers/fec
> ..
> 
> So, given that there are already perfectly good ways to discover the
> information stated in the commit message, and that this commit causes
> regression, I think this commit should be reverted.  Greg, do you
> concur?

Yes, I agree.

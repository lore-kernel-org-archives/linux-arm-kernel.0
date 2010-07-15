From: gregkh@suse.de (Greg KH)
Date: Thu, 15 Jul 2010 10:22:18 -0700
Subject: tq 2440
In-Reply-To: <20100715171029.GK29322@n2100.arm.linux.org.uk>
References: <AANLkTimyBHliUa62qmfja_ke6YTTysiVAtJcZfi8l2gG@mail.gmail.com>
	<AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
	<20100715163526.GJ29322@n2100.arm.linux.org.uk>
	<20100715165141.GA21272@suse.de>
	<20100715171029.GK29322@n2100.arm.linux.org.uk>
Message-ID: <20100715172218.GA22197@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 06:10:29PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 15, 2010 at 09:51:41AM -0700, Greg KH wrote:
> > On Thu, Jul 15, 2010 at 05:35:26PM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Jul 15, 2010 at 11:16:30PM +0800, Conke Hu wrote:
> > > > ever notice to the following kernel log?
> > > > "Device 's3c2440-nand' does not have a release() function, it is
> > > > broken and must."
> > > > release() function should be implemented  in the platform_device.
> > > 
> > > That's not telling you to provide a release function.  The warning is
> > > telling you that a device is being unregistered which doesn't have a
> > > release function.
> > > 
> > > Consider this point - maybe it doesn't have a release function because
> > > it's not supposed to be unregistered?
> > 
> > Heh, well, it is being unregistered, and at that point in time, the
> > kernel complains.
> 
> The unregistration occurs because platform_register_devices() (which is
> used by arch code to register a block of platform devices) undoes its
> work if one of the devices fails to register.
> 
> I've long since thought, since I created that function, that this probably
> isn't desirable behaviour, and it should continue to register as many
> devices as it possibly can.
> 
> > All kobjects need a release function that actually frees it.  If not,
> > that is a logic bug.  Please see the Documentation/kobject.txt file for
> > details.
> 
> How do you free a statically declared platform device?

You never unregister it :)

Otherwise, you will have problems with the reference counting logic, and
you should make it a dynamic device.  I really want to move to forcing
all devices to be created dynamically, but the platform devices are the
biggest static device users, so I've not been pushing it very hard, due
to other more pressing issues...

thanks,

greg k-h

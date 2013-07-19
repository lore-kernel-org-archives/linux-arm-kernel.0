From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jul 2013 11:42:11 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <20130717161758.GA9822@kroah.com>
References: <51C8B84C.3020200@schinagl.nl> <20130624214615.GA17604@kroah.com>
 <51CAA709.4060801@schinagl.nl> <20130626175144.GC2222@kroah.com>
 <51D674BF.9030207@schinagl.nl> <20130706193646.GB9778@kroah.com>
 <51E466A3.4010503@schinagl.nl> <20130716064107.GA10868@kroah.com>
 <20130717114650.GN3125@lukather> <20130717161758.GA9822@kroah.com>
Message-ID: <20130719094211.GD5106@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 09:17:58AM -0700, Greg KH wrote:
> On Wed, Jul 17, 2013 at 01:46:50PM +0200, Maxime Ripard wrote:
> > On Mon, Jul 15, 2013 at 11:41:07PM -0700, Greg KH wrote:
> > > On Mon, Jul 15, 2013 at 11:16:19PM +0200, Oliver Schinagl wrote:
> > > > So using these new patches for binary attributes, how can I pass data 
> > > > between my driver and the sysfs files using a platform_driver? Or are 
> > > > other 'hacks' needed and using the .groups attribute from 
> > > > platform_driver->device_driver->groups is really the wrong approach.
> > > > 
> > > > I did ask around and still haven't figured it out so far, so I do 
> > > > apologize if you feel I'm wasting your precious time.
> > > 
> > > How is the platform device not the same thing that was passed to your
> > > probe function?
> > 
> > One thing I don't get here is why it should be set in the
> > platform_driver structure. From my understanding of the device model,
> > and since what Oliver is trying to do is exposing a few bytes of memory
> > to sysfs, shouldn't the sysfs file be attached to the device instead?
> 
> It will be created by the driver core for any device attached to the
> driver automatically.
> 
> > I mean, here, the sysfs file will be created under something like
> > .../drivers/sunxi-sid/eeprom. What happens when you have several
> > instances of that driver loaded? I'd expect it to have several sysfs
> > files created, one for each instance. So to me, it should be in the
> > device structure, not the driver one.
> 
> You can't have multiple drivers with the same name loaded (or the same
> module loaded multiple times.)  You can have multiple devices for a
> single driver, which is what we do all the time.

Yes, I know that, and it's actually my point.
With the current oliver's code he pasted earlier in this thread:

# find /sys/ -name eeprom
/sys/bus/platform/drivers/sunxi-sid/eeprom

While I'd expect the eeprom file to be located in
/sys/bus/platform/devices/X.eeprom/eeprom like it used to be in the v4,
since it's an instance-specific content.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/02c9c251/attachment-0001.sig>

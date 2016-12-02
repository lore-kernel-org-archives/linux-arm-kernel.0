From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 2 Dec 2016 12:16:56 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <58415625.3020703@free.fr>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr> <20161202104208.GA8736@kroah.com>
 <58415625.3020703@free.fr>
Message-ID: <20161202111656.GA11509@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 12:08:21PM +0100, Mason wrote:
> On 02/12/2016 11:42, Greg KH wrote:
> 
> > On Fri, Dec 02, 2016 at 11:24:05AM +0100, Mason wrote:
> > 
> >> # lsusb -v
> >> Bus 001 Device 001: ID 1d6b:0002
> >> Bus 002 Device 001: ID 1d6b:0003
> >>
> >> Isn't lsusb verbose supposed to print much more than that?
> > 
> > Yes, if you are using the usbutils version of 'lsusb', odds are this is
> > busybox, right?
> 
> Right. (You win a digital cookie.)

Yeah!

{munch munch}

> cd buildroot && make menuconfig
> Drop BR2_PACKAGE_USBMOUNT (maybe it causes unexpected issues)
>  Add BR2_PACKAGE_USBUTILS (I want the real deal)
> 
> > And these are just the root hubs, that the USB controller driver creates
> > as "virtual" USB devices, they are not "real" USB devices on your bus.
> 
> # lsusb --version
> lsusb (usbutils) 007
> I see there's a 008 version.

Wow, 008 was released in 2014, what type of old repo are you using that
has 007 as the "latest"?

And I really should go do a new update, lots of bug fixes have happened
since 2014...

> Am I missing out on important diagnostics?

Not really, if you are not doing a lot of USB 3-only device specific
work, which is where the majority of the changes have happened in the
past 2 years in the tool.

> 
> # lsusb -v
> 
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

<snip>

> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

<snip>

> Does everything look normal?

Yes, two internal "virtual" hubs.

> Or are there any investigation-worthy nuggets?

You need to figure out why the driver isn't getting interrupts, that's
the main problem for your hardware at the moment, lsusb isn't going to
help you out at all with that...

good luck!

greg k-h

From: greg@kroah.com (Greg KH)
Date: Mon, 11 Apr 2011 14:56:19 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <BANLkTingqXAWTeOhcL6ER0UJfEdQF5Bo2A@mail.gmail.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
	<20110411210631.GA28559@kroah.com>
	<BANLkTim155YxMUVJ=pmVs-rNhkovGPG6OQ@mail.gmail.com>
	<20110411212513.GA17809@kroah.com>
	<BANLkTingqXAWTeOhcL6ER0UJfEdQF5Bo2A@mail.gmail.com>
Message-ID: <20110411215619.GA27943@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 11:36:39PM +0200, Rafa? Mi?ecki wrote:
> 2011/4/11 Greg KH <greg@kroah.com>:
> > On Mon, Apr 11, 2011 at 11:19:13PM +0200, Rafa? Mi?ecki wrote:
> >> 2011/4/11 Greg KH <greg@kroah.com>:
> >> > On Mon, Apr 11, 2011 at 11:25:14PM +0200, Rafa? Mi?ecki wrote:
> >> >> +static void axi_release_core_dev(struct device *dev)
> >> >> +{
> >> >> + ? ? /* Silent lack-of-release warning */
> >> >> +}
> >> >
> >> > Ok, WTF!!!!
> >>
> >> Thank you for your kindly words. It's much more enjoyable to work on
> >> kernel that way. I definitely made that on purpose.
> >
> > I can't tell if you are kidding or not.
> 
> That was 100% irony. I swear I don't enjoy publishing bad code and
> getting such a comment.

Ok, you forgot the ':)' then...

> > Please read the documentation for how to do this properly. ?I find it
> > really hard to believe that you wrote that comment instead of putting in
> > the 2 lines of code required for this function.
> >
> > Especially as-it-is, your code does not work properly and leaks memory
> > badly. ?Why would you do that on purpose?
> 
> I tried to read some documentation about this.
> 
> 1) driver-mode/device.txt says only that:
> > Callback to free the device after all references have
> > gone away. This should be set by the allocator of the
> > device (i.e. the bus driver that discovered the device).
> I *really* do not know how my driver should "free" core on AXI bus.

The structure that you have created, added to the bus, is now ready to
have its memory freed.  So free it.

This usually means something like:
	struct my_obj = to_my_obj(dev);
	kfree(my_obj);
in the release function.

> 2) LDD3 says:
> > The method is called when the last reference to the device is removed; it is called
> > from the embedded kobject?s release method. All device structures registered with
> > the core must have a release method, or the kernel prints out scary complaints.
> Well, I do not register any structs for AXI core.

Yes you did, otherwise you would have never seen that callback warning
you that you needed a release function.

> 3) Example code from LDD3:
> static void ldd_bus_release(struct device *dev)
> {
> printk(KERN_DEBUG "lddbus release\n");
> }
> Yeah, that's what I did...

Wow that's old, sorry.  See the kobject documentation for much more
detail about what you need here.

> 4) SSB in it's ssb_release_dev just calls kfree on struct that was
> allocated when registering drivers. *I do not* allocate such a struct,
> so I believe I do exactly the same memory leak as SSB does.

Well someone allocated it, right?  Who did it?  If it wasn't you, where
did that structure come from and why are you registering it on your bus?

> Can you spend 2 more minues in addition to commenting my ideas and
> help me with writing that 2 lines I missed? Where do I leak memory in
> my driver? Which struct should I kfree?

The structure that you wrap around 'struct device' for your bus.

hope this helps,

greg k-h

From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 16 Oct 2012 14:25:33 -0700
Subject: [PATCH RFC 02/11 v4] gpio: Add sysfs support to block GPIO API
In-Reply-To: <CACRpkdb+hu1Q=P8wBWts1RsMFQYuDMuszS74Z5mmkfwcXdpEpw@mail.gmail.com>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-3-git-send-email-stigge@antcom.de>
 <20121015235720.GA3132@kroah.com> <507D58D9.2040607@antcom.de>
 <20121016164326.GA4858@kroah.com>
 <CACRpkdYaaSt9uLN2_=KXYDK2b5D5paopsYxgYKqezKCx8cy=vQ@mail.gmail.com>
 <20121016174038.GA17982@kroah.com>
 <CACRpkdb+hu1Q=P8wBWts1RsMFQYuDMuszS74Z5mmkfwcXdpEpw@mail.gmail.com>
Message-ID: <20121016212533.GC21041@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 11:08:51PM +0200, Linus Walleij wrote:
> On Tue, Oct 16, 2012 at 7:40 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Oct 16, 2012 at 07:27:15PM +0200, Linus Walleij wrote:
> >> The thing is, as I've tried to explain but maybe didn't get across,
> >> that these devices don't *have* a parent, and are not part of any
> >> tree.
> >
> > You are passing in a parent device to the device_create() call, where
> > did that pointer come from?
> 
> You mean this:
> 
> dev = device_create(&gpio_class, desc->chip->dev, MKDEV(0, 0),
>                         desc, ioname ? ioname : "gpio%u", gpio);

Yes.

> desc->chip->dev is an *optional* pointer to a parent device of
> the GPIO chip (not the GPIO chip itself). It is usually NULL.

Ah, I didn't realize that.

Well, then they turn into "virtual" devices, which are still fine, they
show up in the device tree properly, so all is ok.

> >> They are parentless mock devices, created on-the-fly just to get
> >> sysfs entries.
> >
> > That's fine, well, not the "parentless" part, but that should be trivial
> > to fix, just pass in the correct pointer and you should be fine.
> 
> Hm, yeah well, they are orphans mostly.
> 
> >> What is needed it to get the device model right in the first
> >> place.
> >
> > I thought it was in the device model already?
> 
> GPIO chips are not devices. :-(

Point to the device that the GPIO pins are located on.  Be it the cpu,
or platform, or something else.  If not, making them "virtual" is fine,
that's what it is there for.

greg k-h

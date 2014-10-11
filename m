From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 11 Oct 2014 13:55:27 -0700
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141011165650.GA1263@katana>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
 <20141010182604.GC6075@katana> <2769473.KEN6DZKnT7@wuerfel>
 <20141011165650.GA1263@katana>
Message-ID: <20141011205527.GA30877@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 11, 2014 at 06:56:51PM +0200, Wolfram Sang wrote:
> 
> > > You got me wondering, though, that it could not be correct to call
> > > platform_driver_register() from the platform core instead of module
> > > init. I will check tomorrow. Still, this would be a bug independent of
> > > my series. Although I'd need to respin it if platform_driver_probe()
> > > needed a fix.
> > 
> > Right, this seems to be a preexisting bug. platform_create_bundle 
> > and platform_driver_probe will both overwrite the .owner field with
> > NULL since they live in builtin code. They need to be replaced with
> > __platform_driver_probe and __platform_driver_register that both
> > take an extra owner argument passed down from the caller in the driver
> > module.
> 
> Yeah, that would be one solution. However, my personal favourite would
> meanwhile be to revert the commit that Russell mentioned. I think it is
> cleaner to have the owner explicitly set in the module rather than
> hidden away by a function call. However, grepping through include/linux,
> there are a few subsystems hiding it this way. So, it is a pattern
> somewhow. Oh well...

The pattern is to not have to manually set MODULE_OWNER, and have the
pre-processor do it for you, otherwise you will forget or get it wrong.

That is why I accepted this patch to the platform driver interface, as
it is in line with many other bus driver apis (pci, usb, etc.).

I missed the one code path you pointed out, and that should be fixed,
but that doesn't mean that the original patch should be reverted, as it
is the way we want things to be, let's just fix up the bug and move on.

And again, may I just say how much I hate the platform driver code, one
of these days I'm going to lock myself in a room for a week and figure
out a way to just delete that stuff...

greg k-h

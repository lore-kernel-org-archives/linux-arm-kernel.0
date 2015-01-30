From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 14:08:54 +0000
Subject: [PATCH v10 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <54CB72F7.8060706@hurleysoftware.com>
References: <sc9836-serial-v10>
 <1422443324-25082-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422443324-25082-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <54CA5128.8050500@gmail.com> <54CA568E.6080306@hurleysoftware.com>
 <20150129160553.GC26493@n2100.arm.linux.org.uk>
 <20150130101838.GC16744@ulmo> <54CB72F7.8060706@hurleysoftware.com>
Message-ID: <20150130140854.GJ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 07:03:03AM -0500, Peter Hurley wrote:
> On 01/30/2015 05:18 AM, Thierry Reding wrote:
> > -ENODEV is certainly not the correct return value if a resource is not
> > available. It translates to "no such device", but the device must
> > clearly be there, otherwise the ->probe() shouldn't have been called.
> 
> -ENODEV is the appropriate return from the probe(); there is no device.

No it is not.  "no such device" means "the device is not present".  If
the device is not present, we wouldn't have a struct device associated
with it.

The missing resource is an error condition: what it's saying is that the
device is there, but something has failed in providing the IO regions
necessary to access it.  That's really something very different from
"there is no device present".

> > Or if it really isn't there, then you'd at least need a memory region
> > to probe, otherwise you can't determine whether it's there or not. So
> > from the perspective of a device driver I think a missing, or NULL,
> > resource, is indeed an "invalid argument".
> 
> Trying to argue that a missing host bus window is an "invalid argument"
> to probe() is just trying to make the shoe fit.

As is arguing that -ENODEV is an appropriate return value for the missing
resource.

Moreover, returning -ENODEV is actually *bad* in this case - the kernel's
generic probe handling does not report the failure of the driver to bind
given this, so a missing resource potentially becomes a silent failure of
a driver - leading users to wonder why their devices aren't found.

If we /really/ have a problem with the error code, then why not invent
a new error code to cater for this condition - maybe, EBADRES (bad resource).

> > I understand that people might see some ambiguity there, and -EINVAL is
> > certainly not a very accurate description, but such is the nature of
> > error codes. You pick what fits best. -ENXIO and -EADDRNOTAVAIL had been
> > under discussion as well if I remember correctly, but they both equally
> > ambiguous. -ENODATA might have been a better fit, but that too has a
> > different meaning in other contexts.
> > 
> > Besides, there's an error message that goes along with the error code
> > return, that should remove any ambiguity for people looking at dmesg.
> > 
> > All of that said, the original assertion that the check is not required
> > is still valid. We can argue at length about the specific error code but
> > if we decide that it needs to change, then we should modify
> > devm_ioremap_resource() rather than requiring all callers to perform the
> > extra check again.
> 
> None of the devm_ioremap_resource() changes have been submitted for
> serial drivers.

$ grep devm_ioremap_resource drivers/tty/serial/ -r | wc -l
10

It seems that statement is false.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2016 17:24:33 +0000
Subject: [PATCH v5 2/2] ACPI: amba bus probing support
In-Reply-To: <CAHp75VfND6Gq5XW91mbgN+ZQnxh_SCm9LKNz_zNFvaVd1dgvWg@mail.gmail.com>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
 <1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75Vew8HMMrc2vdKbSVuB2reOCrwZZg3-a4nBUyfiQ=c0Y4A@mail.gmail.com>
 <20160111152732.GU19062@n2100.arm.linux.org.uk>
 <CAHp75VfND6Gq5XW91mbgN+ZQnxh_SCm9LKNz_zNFvaVd1dgvWg@mail.gmail.com>
Message-ID: <20160111172433.GV19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 06:26:00PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 11, 2016 at 5:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 11, 2016 at 05:13:20PM +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 11, 2016 at 3:26 PM, Aleksey Makarov
> >> <aleksey.makarov@linaro.org> wrote:
> >> dev->res is 0 before this one, right? Could you use this fact instead
> >> of address_found flag?
> >
> > amba_device_alloc() zero-initialises everything.  However, dev->res is
> > a struct resource, and I'd prefer _this_ method that the OT is using
> > to testing some random part of struct resource.
> 
> So, you mean resource->start = 0 is not enough reliable?

I'd rather not make assumptions about what in a resource is valid
or not valid.

> >> > +               default:
> >> > +                       dev_warn(&adev->dev, "Invalid resource\n");
> >>
> >> Why? Isn't possible to have other resources for the devices?
> >
> > AMBA primecell devices have one memory region, and a number of
> > interrupts.  Other resource types don't make sense.
> 
> But isn't warning on the other side too noisy?

Why would it be "too noisy" ?  Isn't it saying that the ACPI is in
error to include more resource types that aren't part of specifying
the AMBA primecell device?  Maybe it should be dev_err(), because
it's technically an error...

Are you expecting people to create ACPI tables with a lot of rubbish
resources attached to these devices?

> Yes, and in this case ret > 0 should be converted to an appropriate
> error code, otherwise ACPI core will consider this as a normal
> execution, right?

You are assuming that it does return a positive non-zero value in the
first place.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

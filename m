From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 12:29:15 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0D2F90.8020801@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote at Tuesday, January 10, 2012 11:43 PM:
> On 1/10/2012 2:28 PM, Timur Tabi wrote:
> > Mitch Bradley wrote:
...
> >> That GPIO pin thing is annoying, but not sufficiently complex or common
> >> that it warrants having a separate EDID driver.  You could define a
> >> platform-specific property to tell your framebuffer driver that it needs
> >> to do that GPIO thing.  It's a hack, but the GPIO thing is inherently a
> >> hack, so there will be some ugliness somewhere as a result.
> >
> > I have two platform-specific functions, "enabled_edid" and "disable_edid", that I call before/after
> > calling fb_ddc_read().  This seems to work well, and I already have a mechanism for calling platform-
> > specific functions from the framebuffer driver.
> >
> > However, Stephen Warren said I should be using the I2C mux feature instead.
> 
> I2C mux is a plausible solution, as is your enable/disable thing.  At
> some level they are equivalent.  I2C mux is a formalization of your
> solution, in which the mux device's select method must be written to
> perform the function of your enable/disable edid functions.
> 
> Either way, you need platform-dependent functions to do the switching,
> and you need to select the appropriate channel.  Personally, I don't see
> the advantage of using the mux device in this case.

The main advantage I see is that you explicitly don't need any platform-
specific functions to do the switching; you end up with platform-agnostic
code (the I2C GPIO mux driver) and platform-specific configuration for
that driver (the GPIO ID to use). The display driver just talks to the
I2C API for the DDC I2C bus, and doesn't do anything to switch between
the busses; the I2C GPIO mux driver does all that internally. Thus, the
display driver will work fine on boards that don't need this muxing with
zero changes; the board simply wouldn't register the mux driver.

> It's just adding
> complexity with no payback.  If there were several channels that needed
> to be accessed in an interspersed fashion, the mux device would  be much
> cleaner.  But in this case, there is a single "back channel" that only
> needs to be accessed once and can subsequently be ignored.

Well, the EDID needs to be read on every hotplug event, so it's certainly
not a one-time thing.

> The video
> driver can grab a lock, call enable_edid(), read out the EDID data into
> an array, call disable_edid(), release the lock, and that is it.  The
> other users of that I2C bus can ignore the hidden EDID.

Other I2C users/devices also shouldn't be impacted by the mux; they
would continue to use the existing I2C APIs for the bus their devices
are attached to, and not know about the mux. The overhead should be
almost zero; the I2C GPIO mux driver could remember the previous bus
selection and only modify it (gpio_set_value) when switching between
busses. I guess there might be a small overhead to taking a lock to
protect the bus selection; I'm not sure whether the I2C core serializes
access already or you'd need to add this; check the existing I2C I2C
bus mux implementation I guess.

-- 
nvpublic

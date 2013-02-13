From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 13 Feb 2013 21:04:59 +0000
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
In-Reply-To: <20130209224138.GI17833@n2100.arm.linux.org.uk>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk>
 <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
 <20130206163811.GI17833@n2100.arm.linux.org.uk>
 <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com>
 <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com>
 <20130209224138.GI17833@n2100.arm.linux.org.uk>
Message-ID: <20130213210459.D8F693E3557@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Feb 2013 22:41:38 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sat, Feb 09, 2013 at 10:31:05PM +0000, Grant Likely wrote:
> > If it is a probe function, then yes the __init annotations need to be
> > removed or the driver needs to use platform_driver_probe(). This has
> > been the model as long as I can remember. As long as a driver has a
> > .probe hook, the driver core can call it at any time. Deferred probe
> > has only exposed the issue.
> > 
> > If you want to discard the .probe() hook, then the probe() pointer
> > needs to be cleared from the driver structure before discarding the
> > sections. Otherwise the driver core can still call it which is what
> > happens in deferred probe and can happen if a device gets unbound from
> > a driver and then re-attached.
> 
> You're talking about something completely different on the assumption
> that what is being talked about is the probe hook.  It isn't.  It's
> a path for the console initialization which has _always_ been __init
> marked since the dawn of time, because modules are not supposed to
> be calling that path.

Sorry, you're right. Hitting reply too quickly I guess.

However, the point still stands that anything that can be called from
a .probe() path cannot be in an __init section with the current driver
model. A driver can even be unbound from a device and reattached at
runtime. That would also cause problems.

> What has been exposed is that console drivers which have resources
> which are not immediately available no longer have the same guarantees
> that they used to have (that is, they will be called before the __init
> section is given away.)

Okay, I'll reply to Haojian's proposed solution patch on this point.

g.

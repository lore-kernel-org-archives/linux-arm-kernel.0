From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 8 Sep 2016 14:14:57 +0300
Subject: [RFC PATCH] gpio/gpiolib: Forbid irqchip default trigger if
 probed over DT
In-Reply-To: <CACRpkdaLf5H6qhF0kS5W-p3YmKh5DxZxyinoV5u9HBKts9CQLg@mail.gmail.com>
References: <1473170343-16853-1-git-send-email-marc.zyngier@arm.com>
 <CACRpkdaLf5H6qhF0kS5W-p3YmKh5DxZxyinoV5u9HBKts9CQLg@mail.gmail.com>
Message-ID: <20160908111457.GD15313@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:13:27AM +0200, Linus Walleij wrote:
> On Tue, Sep 6, 2016 at 3:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > Using a default trigger is a bad idea if using DT to configure
> > interrupts, as the device's interrupt specifier will always contain
> > the trigger configuration.
> >
> > Let's warn about that particular situation, and revert to not
> > having a default. Hopefully, the couple of drivers still using
> > this feature will quickly be fixed.
> >
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Patch applied. This is a good way to get rid of this madness.
> 
> > +       /*
> > +        * Specifying a default trigger is a terrible idea if DT is
> > +        * used to configure the interrupts, as you may end-up with
> > +        * conflicting triggers. Tell the user, and reset to NONE.
> > +        */
> > +       if (WARN_ON(of_node && type != IRQ_TYPE_NONE,
> > +                   "%s: Ignoring %d default trigger\n", of_node->full_name))
> > +               type = IRQ_TYPE_NONE;
> 
> I *strongly* suspect this is bad also when using ACPI.

I agree.

> Would the GPIO ACPI people devise a patch on top of this
> to emit the same warning for the ACPI usecase?

Yup, I'll make a patch for ACPI next week.

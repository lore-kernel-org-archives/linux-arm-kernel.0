From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 09:27:50 -0700
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <5014834.k6eecMddPC@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel>
Message-ID: <20140728162750.GB32359@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 11:07:50AM +0200, Arnd Bergmann wrote:
> On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
> > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > > +Relationship with Device Tree
> > > +-----------------------------
> > > +
> > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > > +exclusive with DT support at compile time.
> > > +
> > > +At boot time the kernel will only use one description method depending on
> > > +parameters passed from the bootloader.
> > 
> > Possibly overriden by kernel bootargs. And as debated for quite a
> > while earlier this year, acpi should still default to off -- if a DT
> > and ACPI are both passed in, DT should at this time be given priority.
> 
> I think this would be harder to do with the way that ACPI is passed in
> to the kernel. IIRC, you always have a minimal DT information based on
> the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> to the ACPI tables, which are then used for populating the Linux platform
> devices (unless acpi=disabled is set), while the other contents of the
> DTB may be present but we skip the of_platform_populate state.

How can it be harder to do? If you support acpi=off, then you should support
acpi=on.

Another alternative would be to have an early fixup that stubs out
the acpi properties from the DTB unless there's an 'acpi' or 'acpi=on'
argument on the cmdline. Not quite as tidy a solution, though.

> If this is correct, then replacing the firmware-generated dtb with a
> user-provided on would implicitly remove the ACPI tables from visibility,
> which is exactly what we want.

I was of the impression that firmware patches in the ACPI entries into either
device-tree before launching the kernel. Is that not the case? And what if
some bootloader chooses to do it that way in the future? It's better to not
assume that they get it right.

> It's possible that I'm misremembering it though, and it should be
> documented better.

Yes, definitely needs to be documented to not leave room for random
interpretation later on.


-Olof

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 18:08:32 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115175241.GB27174@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
Message-ID: <20131115180832.GR16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 09:52:41AM -0800, Olof Johansson wrote:
> If we knew exactly what we wanted, it'd be a different story. _We
> don't_. We're into year FOUR of the device tree conversion and we're just
> now reaching a point where we think we know what a good solution looks
> like. The first two years were easy -- they were the trivial devices we're
> now talking about on ACPI. After that it got harder. Going through all
> of that again with ACPI? No. No way. Microsoft gets to do it and while
> they're busy sorting it out, we'll boot with device tree.

However, there's a very big danger here.  I disagree with the stance
you're taking.

It seems that under ACPI and DT, we refer to properties by string names.
That's good, but do we really want to have different string names for the
same property.

Or worse still, the same hardware property described in two completely
different ways between ACPI and DT?

If you think Microsoft will come along, look at what we've done for DT,
and implement something in ACPI which is somehow compatible with that,
I'd have to ask where you've been for the last 30 years.  That's not
how Microsoft operates.

Microsoft will instead design something different (whether it's
intentionally different or not depends on your point of view) but it
will be designed how they want and not how we'd like it to be.  From
their point of view, if it's completely different and very difficult
to convert to device tree, that's a win for them because it means
they're pushing back on Linux being used in markets they wish to be
successful.

We have a possibility here to define how we'd like ACPI to look: we
have the chance to have ACPI properties using the same naming that we
already have for DT.  What this means is that _if_ we wanted one day
to have first class support for ACPI (which we may wish to for the
AML) then we wouldn't have to rewrite all the drivers we've already
converted.  Yes, we'd have a some churn, but most of that would be
along the lines of converting the of_* calls to being firmware_*
calls, taking a generic firmware handle.

Who knows, we may decide in the future that we want to move everything
over to ACPI rather than using DT, and having things as I mention above
would make it much easier to convert from DT to ACPI.

I believe that we're only going to regret shutting the door on this
in the future.  It's not like the kernel doesn't already have native
support for ACPI.

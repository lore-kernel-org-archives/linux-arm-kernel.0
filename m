From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Nov 2013 16:05:37 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115232109.GT16735@n2100.arm.linux.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <201311152056.47846.arnd@arndb.de>
 <20131115232109.GT16735@n2100.arm.linux.org.uk>
Message-ID: <201311181605.37300.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 November 2013, Russell King - ARM Linux wrote:
> On Fri, Nov 15, 2013 at 08:56:47PM +0100, Arnd Bergmann wrote:
> > 
> > For all I know, doing this in ACPI is something that is only now being
> > discussed as Intel wants to be able to reuse the existing features from
> > DT enabled drivers in the kernel and share the implementation between
> > embedded x86 SoCs and embedded ARM/PowerPC/MIPS/... SoCs. That part actually
> > isn't as crazy.
> > 
> > The existing ACPI usage however is basically all binary and cannot be
> > shared with DT, in particular it won't help for the orthogonal problem of
> > using ACPI to get "enterprise server" features on ARM64.
> 
> That's strange, because the patches I've seen from people who want to
> add ACPI support to AMBA are all based around very similar strings to
> those in DT to lookup the same data in ACPI.

Can you point to specific patches? I can't say I'm an expert on this, but
everything I've seen with ACPI is tables of binary data with four-letter
identifiers that are defined by the ACPI group, but not using strings
in a similar manner to DT. Apple has an extension to do DT-style properties
in their phones, and we had a discussion at the kernel summit to do
a more generic variation of the same idea that Darren Hart presented,
but that is still in prototype stage.

> What's been done there is the function which reads from DT has been
> duplicated, and instead of reading the information from DT, it reads it
> from ACPI instead using string names without the vendor prefix.

The recently posted x-gene ahci driver does this, but from what I can
tell, the implementation is inappropriate on both DT (because of the
use of unreadable four-character upper-case identifiers) and on ACPI
(because of the use of non-standard identifiers).

> That tells me that what I've stated in my previous email to which you
> replied is _definitely_ possible to do.  That means it's certainly
> possible to do this without reinventing the wheel, and without having
> to rewrite lots of parsing code, precisely along the lines I set out
> in my original email.

To clarify my complaint: while we can do simple (boolean, integer, text,
or arrays of those three) properties with Darren's approach as long as they
are private to one device, that won't suffice for anything that requires
links between devices. We have phandles on DT that can be freely mixed with
integers for things like GPIO or clock references. ACPI has similar
references, but uses a different syntax for doing the same things, and these
have to be standardized per subsystem (i.e. per type of connection) to make
sense.
As a result, every subsystem that has a producer-consumer type connection
requires different code for DT and for ACPI. If the subsystem-to-driver
interface is done well, we can have a common device driver, but in a 
lot of cases there will be a leaky abstraction. As Olof pointed out,
even migrating from a DT-only interface to a generic interface would
require changing each driver, even if the result is no more ugly than
the current state.

	Arnd

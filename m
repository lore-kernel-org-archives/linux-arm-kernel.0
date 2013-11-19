From: david.goodenough@btconnect.com (David Goodenough)
Date: Tue, 19 Nov 2013 13:34:46 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <201311191348.44660.arnd@arndb.de>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <201311182247.03540.david.goodenough@btconnect.com>
 <201311191348.44660.arnd@arndb.de>
Message-ID: <201311191334.46788.david.goodenough@btconnect.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 Nov 2013, Arnd Bergmann wrote:
> On Monday 18 November 2013, David Goodenough wrote:
> > Would it not be possible to have ACPI read the hardware configuration
> > from the DT, and provide whatever services it wants, while also allowing
> > the kernel to retain the DT for its hardware config?  I suppose the only
> > thing that would be needed would be some way to mark paricular bits of
> > hardware (I am largely thinking of the things lmsensors deals with) as
> > being used by ACPI and being off limits to the kernel.
> 
> While that may be possible, I don't see what problem that solves. Nobody
> has so far explained what problem they want to solve by using ACPI. The
> only reason we are discussing this is Jon's statement that "everybody
> will use it". For any specific thing you might want to do in ACPI while
> leaving the rest in DT, I suspect there is an easier solution in using
> just DT.
It strikes me that ACPI is really two things, a provider of configuration
information and a provider of power management services.  The first of
these is - on ARM - more or less duplicated by DT, and so rather than having 
to go through the excercise of modifying the kernel to support both sources
of configuration information, I am suggesting making not just the kernel
and uboot (or whatever boot loader) use DT, but also ACPI.  So the ACPI
module for an ARM box would not have separate config information coded
into it, but rather would either read the DT from the same place as
the bootloader/kernel, or act as the source of the DT for the bootloader
/kernel.  This way the kernel does not have to be modified again, and
can simply use DT whether ACPI is present or not.
> 
> Since you seem to have something specific in mind, can you elaborate on
> why you think lmsensors (or any other device you can think of) would
> benefit from ACPI?
Its the other way around.  lmsensors often fights with ACPI in the x86
world for control of sensors and fans, and on x86 motherboards they do
silly tricks like hiding I2C busses from the kernel so that ACPI can
have sole control.  Thus lmsensors (which on x86 boxes could use a source
of information like DT as busses like I2C provide no chip ID services) needs 
to know which sensor chips are being used or controlled by ACPI so that it 
does not interfere.

David
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

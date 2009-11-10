From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 9 Nov 2009 17:35:29 -0700
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091108154103.GA27579@n2100.arm.linux.org.uk>
References: <20091107135615.GE18639@mail.wantstofly.org>
	<20091107150305.GQ10555@parisc-linux.org>
	<20091108090451.GA20529@n2100.arm.linux.org.uk>
	<20091108152310.GA16033@parisc-linux.org>
	<20091108154103.GA27579@n2100.arm.linux.org.uk>
Message-ID: <e9c3a7c20911091635q708f5699kcebafe9a26fd4c58@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 8, 2009 at 8:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Nov 08, 2009 at 08:23:10AM -0700, Matthew Wilcox wrote:
>> On Sun, Nov 08, 2009 at 09:04:51AM +0000, Russell King - ARM Linux wrote:
>> > On Sat, Nov 07, 2009 at 08:03:05AM -0700, Matthew Wilcox wrote:
>> > > I'm OK with this ... it might provoke bugs in some _other_ piece of hardware,
>> > > but that seems pretty unlikely.
>> >
>> > Please remember that some ARM hardware only has the capability to read
>> > and write full 32-bit quantities of configuration space, which means
>> > writing the control register can result in the status register being
>> > written as well.
>> >
>> > That shouldn't be a problem, but is merely something else to consider
>> > which isn't obvious.
>>
>> Wow, that's horrid. ?You must have to special case each config register
>> that's accessed in a 16-bit way, since some bits are 'preserve' and others
>> are 'write 1 to clear'. ?What a nightmare.
>
> Yes, it's horrid, and it can be found on all IOP ARM stuff, eg:
>
> ? ? ? ? ? ? ? ?val = iop3xx_read(addr);
> ? ? ? ? ? ? ? ?if (iop3xx_pci_status())
> ? ? ? ? ? ? ? ? ? ? ? ?return PCIBIOS_SUCCESSFUL;
>
> ? ? ? ? ? ? ? ?where = (where & 3) * 8;
>
> ? ? ? ? ? ? ? ?if (size == 1)
> ? ? ? ? ? ? ? ? ? ? ? ?val &= ~(0xff << where);
> ? ? ? ? ? ? ? ?else
> ? ? ? ? ? ? ? ? ? ? ? ?val &= ~(0xffff << where);
>
> ? ? ? ? ? ? ? ?*IOP3XX_OCCDR = val | value << where;
>
> This covers IOP32x, IOP33x, and there's similar code for IOP13xx.
>
> This does mean that if we make this change, we may do more accidental
> writes to the status register on such hardware. ?Whether that matters
> in reality isn't something I can answer - I suspect we can get away
> with this without causing problems.
>
> CC'ing Dan for his info: the proposed change at the start of this thread
> is to make the write to the command register in pcibios_enable_device()
> unconditional. ?This will guarantee that IOP platforms to copy-back the
> status register on to itself on pci_enable_device(), thereby causing
> "write 1 to clear" status bits to be cleared.
>

Thanks for the CC.  I am hoping that this is just an initial
misreading of the IOP specification that was blindly forward ported
from the iop32x days.  In my interpretation it says that accesses may
not *cross* a dword boundary, it says nothing about sub-dword.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.4.1257813337.2170.linux-arm-kernel@lists.infradead.org>

"Configuration cycles are non-burst and restricted to a single 32-bit
word cycle"
...
"The user should designate the memory region containing the OCCDR as
non-cacheable and non-bufferable from the Intel XScale=AE core.  This
guarantees that all load/stores to the OCCDR is only of DWORD
quantities. In event the user inadvertently issues a read to the OCCDR
that crosses a DWORD address boundary, the ATU target aborts the
transaction. All writes is terminated with a Single-Phase-Disconnect
and only bytes 3:0 is relevant."

I believe sub-dword access were once verified to work, but I no longer
have access to those test results.  However, the following at least
boots on my iop13xx, so I'll look into this a bit more.

Thanks,
Dan

diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 4873f26..1b6a65a 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -190,7 +190,7 @@ static u32 iop13xx_atux_cfg_address(struct pci_bus
*bus, int devfn, int where)
        else
                addr =3D bus->number << 16 | PCI_SLOT(devfn) << 11 | 1;

-       addr |=3D PCI_FUNC(devfn) << 8 | ((where & 0xff) & ~3);
+       addr |=3D PCI_FUNC(devfn) << 8 | (where & 0xff);
        addr |=3D ((where & 0xf00) >> 8) << 24; /* upper register number */

        return addr;
@@ -264,7 +264,7 @@ static u32 iop13xx_atux_read(unsigned long addr)
 {
        u32 val;

-       __asm__ __volatile__(
+       asm volatile(
                "str    %1, [%2]\n\t"
                "ldr    %0, [%3]\n\t"
                "mov    %0, %0\n\t"
@@ -281,7 +281,7 @@ static int
 iop13xx_atux_read_config(struct pci_bus *bus, unsigned int devfn, int wher=
e,
                int size, u32 *value)
 {
-       unsigned long addr =3D iop13xx_atux_cfg_address(bus, devfn, where);
+       unsigned long addr =3D iop13xx_atux_cfg_address(bus, devfn, where &=
 ~3);
        u32 val =3D iop13xx_atux_read(addr) >> ((where & 3) * 8);

        if (iop13xx_atux_pci_status(1) || is_atux_occdr_error()) {
@@ -300,25 +300,14 @@ iop13xx_atux_write_config(struct pci_bus *bus,
unsigned int devfn, int where,
                int size, u32 value)
 {
        unsigned long addr =3D iop13xx_atux_cfg_address(bus, devfn, where);
-       u32 val;
-
-       if (size !=3D 4) {
-               val =3D iop13xx_atux_read(addr);
-               if (!iop13xx_atux_pci_status(1) =3D=3D 0)
-                       return PCIBIOS_SUCCESSFUL;
-
-               where =3D (where & 3) * 8;

-               if (size =3D=3D 1)
-                       val &=3D ~(0xff << where);
-               else
-                       val &=3D ~(0xffff << where);
-
-               __raw_writel(val | value << where, IOP13XX_ATUX_OCCDR);
-       } else {
-               __raw_writel(addr, IOP13XX_ATUX_OCCAR);
+       __raw_writel(addr, IOP13XX_ATUX_OCCAR);
+       if (size =3D=3D 1)
+               __raw_writeb(value, IOP13XX_ATUX_OCCDR);
+       else if (size =3D=3D 2)
+               __raw_writew(value, IOP13XX_ATUX_OCCDR);
+       else
                __raw_writel(value, IOP13XX_ATUX_OCCDR);
-       }

        return PCIBIOS_SUCCESSFUL;
 }

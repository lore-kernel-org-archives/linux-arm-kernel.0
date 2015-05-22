From: msalter@redhat.com (Mark Salter)
Date: Fri, 22 May 2015 09:13:24 -0400
Subject: [PATCH] arm64: support ACPI tables outside of kernel RAM
In-Reply-To: <20150522125346.GX29424@e104818-lin.cambridge.arm.com>
References: <1431613373-10928-1-git-send-email-msalter@redhat.com>
 <20150518111143.GC21251@e104818-lin.cambridge.arm.com>
 <1431957525.9933.4.camel@deneb.redhat.com>
 <20150518164108.GH21251@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8wXrCnnDEw2gpJ9e1qixkVvBCsUf0wLorsdLJwknZELA@mail.gmail.com>
 <20150522103417.GT29424@e104818-lin.cambridge.arm.com>
 <1432298762.9933.58.camel@deneb.redhat.com>
 <20150522125346.GX29424@e104818-lin.cambridge.arm.com>
Message-ID: <1432300404.9933.69.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-05-22 at 13:53 +0100, Catalin Marinas wrote:
> On Fri, May 22, 2015 at 08:46:02AM -0400, Mark Salter wrote:
> > On Fri, 2015-05-22 at 11:34 +0100, Catalin Marinas wrote:
> > > OK, so my preferred options, in this order:
> > > 
> > > 1. Change the core ACPI kernel code to distinguish between mapping I/O
> > >    or RAM (could be as simple as acpi_map not using acpi_os_ioremap but
> > >    another API). I guess the code knows when it plans to map tables or
> > >    I/O registers
> > > 
> > > 2. If the above is not possible, add the extra checks as per Mark's
> > >    patch but I would rather call this resource "UEFI RAM" than "ACPI",
> > >    it's not really ACPI specific.
> > 
> > Actually, it is ACPI specific. The patch only registers resources for
> > EfiACPIReclaimMemory and EfiACPIMemoryNVS regions which are also
> > marked as cacheable. On x86 these show up in /proc/iomem as
> > "ACPI Tables" and "ACPI Non-volatile Storage". I used "ACPI RAM" to
> > avoid having to search for two strings.
> 
> My point is more about UEFI describing the entire RAM while the kernel
> command line restricts it via "mem=". In this case, the "System RAM"
> resources is reduced as well but it does not necessarily mean that the
> rest of the RAM is only used by ACPI.
> 

Ah okay. But I'm not sure we want the kernel to access other areas
cut off by mem=. The case I'm dealing with which led to this patch
was a kdump dump-collection kernel. For that kernel, we really don't
want it accessing any general purpose memory outside of its system
ram. For the dump collection, it already uses ioremap_cache to get
to crash-kernel memory. The reason for the iomem resources added
for the UEFI ACPI regions was so the dump-collection kernel could
boot using ACPI.

That being said, I could rework the patch to add all "UEFI RAM" and
that would let us just check that one string for acpi_os_ioremap()
purposes rather than checking "System RAM" and "ACPI RAM".

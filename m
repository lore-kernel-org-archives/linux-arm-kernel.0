From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Jul 2016 16:47:27 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <1565504.8BCDUlPeYg@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715132610.GD23514@redhat.com>
 <20160715133346.GD19840@leverpostej> <1565504.8BCDUlPeYg@hactar>
Message-ID: <20160715154726.GE19840@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:29:09PM -0300, Thiago Jung Bauermann wrote:
> Am Freitag, 15 Juli 2016, 14:33:47 schrieb Mark Rutland:
> > On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> > > I don't know anything about DTB. So here comes a very basic question.
> > > Does DTB allow passing an executable blob to kernel or pass the
> > > location of some unsigned executable code at kernel level. I think from
> > > secureboot point of view that would be a concern. Being able to trick
> > > kernel to execute an unsigned code at privileged level.
> > 
> > The DTB itself won't contain executable code.
> > 
> > However, arbitrary bindings could point kernel at such code. For
> > instance, /chosen/linux,uefi-system-table could point the kernel at a
> > faked EFI system table, with pointers to malicious code. So
> > arbitrary modification of /chosen is not safe.
> 
> PowerPC doesn't have UEFI so this option is not a concern in that 
> architecture. I'm having a look at what a PowerPC kernel gets from /chosen 
> and haven't found anything of concern so far, but I'm still looking.
> 
> On the other hand, the kernel command line has the option acpi_rsdp, which 
> is used to pass the address of the RSDP. I don't really know much about EFI 
> so I'm not sure if it can be used to point to code that the kernel can 
> execute, but it does point to tables that contain AML code.

Please let's not conflate EFI and ACPI, the two are distinct.

I believe that there aren't any ACPI tables which contain native code,
or which contain pointers to native code, but I could be mistaken. It
doesn't seem unlikely that malicious AML is possible, but I'm not
familiar enough with AML to know how we sandbox that.

>From a scan of Documentation/kernel-parameters.txt, it doesn't look like
there are options to override the EFI system table (or related tables),
so it doesn't look like there's a trivial mechanism to trigger arbitrary
code execution. It looks like efi_fake_mem could be used to trick the
kernel to poke things it shouldn't, though that likely brings the system
down entirely.

> > Bindings describe arbitrary system features (devices, firmware
> > interfaces, etc), so in general they might provide mechanisms to execute
> > code.
> 
> Even bindings in /chosen?

Yes, even bindings in /chosen. As above, the linux,uefi-system-table
property lives under /chosen, and provides pointers to native code.
Control over this property could yield arbitrary code execution.

Additionally, there are drivers that just go looking for a compatible
string, and will probe regardless of where the node is in the hierarchy.
e.g. clock controller drivers, memory nodes. So /chosen isn't sandboxed
as such. 

I fear that there are many things that one could place under /chosen
that could make the kernel do the wrong thing. Given the example of
drivers, I'm not sure it's going to be possible to audit all the
relevant code.

Thanks,
Mark.

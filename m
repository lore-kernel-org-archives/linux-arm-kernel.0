From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 15 Jul 2016 12:29:09 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160715133346.GD19840@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715132610.GD23514@redhat.com> <20160715133346.GD19840@leverpostej>
Message-ID: <1565504.8BCDUlPeYg@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15 Juli 2016, 14:33:47 schrieb Mark Rutland:
> On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> > On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> > > On Thursday, July 14, 2016 10:44:14 PM CEST Thiago Jung Bauermann 
wrote:
> > > > Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> > > > > Right, but the question remains whether this helps while you allow
> > > > > the
> > > > > boot loader to modify the dtb. If an attacker gets in and cannot
> > > > > modify
> > > > > the kernel or initid but can modify the DT, a successful attack
> > > > > would
> > > > > be a bit harder than having a modified kernel, but you may still
> > > > > need
> > > > > to treat the system as compromised.
> > > > 
> > > > Yes, and the same question also remains regarding the kernel command
> > > > line.
> > > > 
> > > > We can have the kernel perform sanity checks on the device tree,
> > > > just as the kernel needs to sanity check the command line.
> > > > 
> > > > There's the point that was raised about not wanting to increase the
> > > > attack surface, and that's a valid point. But at least in the way
> > > > Petitboot works today, it needs to modify the device tree and pass
> > > > it to the kernel.
> > > > 
> > > > One thing that is unavoidable to come from userspace is
> > > > /chosen/linux,stdout-path, because it's Petitboot that knows from
> > > > which
> > > > console the user is interacting with. The other modification to set
> > > > properties in vga at 0 can be done in the kernel.
> > > > 
> > > > Given that on DTB-based systems /chosen is an important and
> > > > established way to pass information to the operating system being
> > > > booted, I'd like to suggest the following, then:
> > > > 
> > > > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > > > instead of accepting a complete DTB from userspace, the syscall
> > > > would accept a DTB containing only a /chosen node. If the DTB
> > > > contains any other node, the syscall fails with EINVAL. The kernel
> > > > can then add the properties in /chosen to the device tree that it
> > > > will pass to the next kernel.
> > > > 
> > > > What do you think?
> > > 
> > > I think that helps, as it makes the problem space correspond to that
> > > of modifying the command line, but I can still come up with countless
> > > attacks based on modifications of the /chosen node and/or the command
> > > line, in fact it's probably easier than any other node.
> > 
> > I don't know anything about DTB. So here comes a very basic question.
> > Does DTB allow passing an executable blob to kernel or pass the
> > location of some unsigned executable code at kernel level. I think from
> > secureboot point of view that would be a concern. Being able to trick
> > kernel to execute an unsigned code at privileged level.
> 
> The DTB itself won't contain executable code.
> 
> However, arbitrary bindings could point kernel at such code. For
> instance, /chosen/linux,uefi-system-table could point the kernel at a
> faked EFI system table, with pointers to malicious code. So
> arbitrary modification of /chosen is not safe.

PowerPC doesn't have UEFI so this option is not a concern in that 
architecture. I'm having a look at what a PowerPC kernel gets from /chosen 
and haven't found anything of concern so far, but I'm still looking.

On the other hand, the kernel command line has the option acpi_rsdp, which 
is used to pass the address of the RSDP. I don't really know much about EFI 
so I'm not sure if it can be used to point to code that the kernel can 
execute, but it does point to tables that contain AML code.

> Bindings describe arbitrary system features (devices, firmware
> interfaces, etc), so in general they might provide mechanisms to execute
> code.

Even bindings in /chosen?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center

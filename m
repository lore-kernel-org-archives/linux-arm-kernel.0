From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu, 14 Jul 2016 22:44:14 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <4321972.HZgDox36RC@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <1678419.ODVtyXKVYJ@hactar> <4321972.HZgDox36RC@wuerfel>
Message-ID: <3520758.yAgMzqF1PF@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14 Juli 2016, 10:29:11 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 11:18:04 PM CEST Thiago Jung Bauermann wrote:
> > Am Mittwoch, 13 Juli 2016, 21:59:18 schrieb Arnd Bergmann:
> > > On Wednesday, July 13, 2016 3:45:41 PM CEST Thiago Jung Bauermann 
wrote:
> > > > Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> > > > 
> > > > For secure boot, Petitboot needs to use kexec_file_load, because of
> > > > the
> > > > following two features which the system call enables:
> > > > 
> > > > 1. only allow loading of signed kernels.
> > > > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > > > 
> > > >    command line and other boot inputs for the Integrity Measurement
> > > >    Architecture subsystem.
> > > > 
> > > > Those can't be done with kexec_load.
> > > 
> > > Can't petitboot do both of these in user space?
> > 
> > To be honest I'm not sure if it *can't* be done from userspace but if
> > you do it from the kernel you can guarantee that any kernel image that
> > is loaded gets verified and measured.
> > 
> > Whereas if you verify and measure the kernel in userspace then if
> > there's a vulnerability in the system which allows an attacker to
> > upload their own binary, then they can use kexec_load directly and
> > bypass the verification and measurement.
> > 
> > So it's a more resilient design.
> 
> Right, but the question remains whether this helps while you allow the
> boot loader to modify the dtb. If an attacker gets in and cannot modify
> the kernel or initid but can modify the DT, a successful attack would
> be a bit harder than having a modified kernel, but you may still need
> to treat the system as compromised.

Yes, and the same question also remains regarding the kernel command line.

We can have the kernel perform sanity checks on the device tree, just as the 
kernel needs to sanity check the command line.

There's the point that was raised about not wanting to increase the attack 
surface, and that's a valid point. But at least in the way Petitboot works 
today, it needs to modify the device tree and pass it to the kernel.

One thing that is unavoidable to come from userspace is 
/chosen/linux,stdout-path, because it's Petitboot that knows from which 
console the user is interacting with. The other modification to set 
properties in vga at 0 can be done in the kernel.

Given that on DTB-based systems /chosen is an important and established way 
to pass information to the operating system being booted, I'd like to 
suggest the following, then:

Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
accepting a complete DTB from userspace, the syscall would accept a DTB 
containing only a /chosen node. If the DTB contains any other node, the 
syscall fails with EINVAL. The kernel can then add the properties in /chosen 
to the device tree that it will pass to the next kernel.

What do you think?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center

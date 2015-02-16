From: dalias@libc.org (Rich Felker)
Date: Mon, 16 Feb 2015 12:51:35 -0500
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <95765022.dfzNYZrNVS@wuerfel>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <1383502854.512344.1423688575473.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150211213758.GN23507@brightrain.aerifal.cx>
 <95765022.dfzNYZrNVS@wuerfel>
Message-ID: <20150216175135.GB23507@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 06:20:18PM +0100, Arnd Bergmann wrote:
> > Would it really be that hard to do:
> > 
> > 	if (ILP32_on_64_process) tv_nsec = (int)tv_nsec;
> > 
> > or similar? That's all that's needed.
> > 
> > > In some cases, there may also be a measurable performance penalty
> > > in interpreting a user space data structure manually over copying
> > > it (including the timespec values) in one chunk.
> > 
> > I don't think the above would be measurable.
> 
> It depends: Copying the structure first and then doing the conversion
> in kernel space on the specific members as you do in the example
> should indeed have a trivial performance impact. However, it is also
> the hardest for driver writers to get right, and it's better not to
> trust them with corner cases like this.
> 
> To make it more readable, we would probably introduce a helper function
> that copies the timespec from user space memory to kernel space and
> then does all the checks and conversions as required. However, doing
> separate copies can (depending on the architecture) have a noticeable
> impact. An example for this would be architectures that require setting
> up a page table entry for the user space page in order to access the
> data and then destroy it again afterwards, with the correct TLB flushes.
> 
> We can do something like this for the old-style compat handlers that
> use 32-bit time_t, but I'd prefer not to have it in the fast path for
> the native 64-bit time_t on 64-bit architectures.

I know this isn't the place to discuss large architectural kernel
changes, but it would be really nice if the kernel had proper abstract
knowledge, at syscall entry time, what regions of memory from
userspace the syscall is going to need and a way of marshalling them
all together as prep for enterring the code that implements the
syscalls, and if conversion between different ABIs could take place
mostly automatically at this layer. Perhaps this kind of thing is an
idea that could be kept open for the future. I suspect the
combinatorics of different legacy interfaces are going to continue
getting worse, and it would be much nicer to have the support factored
out of the actual syscall implementations.

> > Generally I would think the kernel knows the model the process is
> > using, but if not, all you need is separate ioctl numbers for
> > userspace to use depending on which definition it's using.
> 
> I've checked now, and indeed the kernel knows for ilp32 x86 and arm, since
> it uses a different ELF interpreter. I thought it might be running the
> ilp32 binaries as ELF64, but it does not.

This would result in lots of problems like argv[], auxv[], envp[],
etc. being in the wrong format.

> I would like to avoid separate ioctl command numbers, but we have to
> do it for 64-bit time_t on the original 32-bit architectures in the
> cases where the size is not already encoded in the command number.

Indeed, I don't see any way around that.

Rich

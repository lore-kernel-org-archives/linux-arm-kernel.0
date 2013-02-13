From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 17:03:22 +0100
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <20130213155220.GC12685@arm.com>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <511B768B.7000302@codethink.co.uk> <20130213155220.GC12685@arm.com>
Message-ID: <4862574.qhIZki9ZKx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013 15:52:20 Catalin Marinas wrote:
> 
> I had an (insane) idea once but no time to pursue. You can enable the
> 'compat' layer for a 32-bit ARM kernel and define all the compat_* types
> to be the same as the native ones. The compat layer has several handlers
> for syscalls which pretty much do the conversion between compat and
> native structures. The compat structures are read/written from/to user
> using get_user/put_user on each member. You then need change the ARM
> get_user/put_user code to test a new TIF_BE flag and do a 'rev' on the
> data. At this point the native kernel structures would have the correct
> little endianness.
> 
> I reckon the above would cover 70-80% of the syscalls. You need to chase
> other syscalls and update the binfmt_elf.c to cope with BE ELF files.
> Probably there are other issues as well.

ioctl will be the biggest one by far. You would have to add compat
handlers for every device driver and a lot of other things like
network protocols.

Doable in theory, but also much more work than the 32 bit emulation
on 64 bit kernels, and that was something that took a lot of work
to get right.

However, qemu-user already has a mostly syscall emulation layer
including ioctl that covers most of the common stuff, certainly
enough to run most applications. The missing piece there is switching
to native other-endian execution instead of interpreting the
instructions. You might need to run the task in a separate process
though and use ptrace to trap all system calls.

The part you cannot solve this way is IPC: any data that is shared
between processes needs to match, and the only sane solution for that
is probably to run a separate container for all the big-endian
processes, and not let that talk to any of the little-endian tasks
using things like AF_UNIX sockets or shared mmap.

	Arnd

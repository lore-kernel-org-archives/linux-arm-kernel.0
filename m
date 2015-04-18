From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Apr 2015 21:24:19 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <0394DFCE-2D52-4028-A9F5-BE4285AFC5D9@theobroma-systems.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150417144656.GQ819@e104818-lin.cambridge.arm.com>
 <0394DFCE-2D52-4028-A9F5-BE4285AFC5D9@theobroma-systems.com>
Message-ID: <6299275.Ntfb3Dzi12@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 17:15:46 Dr. Philipp Tomsich wrote:
> More comments below.
> 
> > On 17 Apr 2015, at 16:46, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > Even in this case, we could enable AArch32 compat knowing that ioctls
> > wouldn't work. If this is important, we can add an option to enable
> > ioctl support for ILP32 and re-target the asm/compat.h definitions.
> > 
> >>  g) create a new ABI that does things in exactly the way that we
> >>     would use as the native syscall interface if we had an ilp32
> >>     kernel running on aarch64 with the asm-generic/unistd.h.
> >>     This would mean a 32-bit __kernel_long_t and time_t, but extending
> >>     time_t in the long run, together with aarch32 and i386.
> >>     This one is particularly interesting for people that are interested
> >>     in maximum posix compliance and in having a "nice" ABI, in particular
> >>     if there is a slight chance that within the next decade we have
> >>     reason to support building an arch/arm64 kernel itself in
> >>     aarch64-ilp32 mode.
> 
> I don?t believe that an ILP32 kernel wouldn?t use an uint64_t for time_t, as it
> has full support for 64bit arithmetic anyway.  I also believe that other kernel 
> internals (e.g. filesystems and inode-numbering) would use native 64bit types.
> 
> The differences on the kernel side would mainly rest in that only a 32bit address
> space could reasonably be managed. So a native ILP32 ABI would differ from
> the LP64 ABI mainly in how sizeof(long) is represented in the user-space.
> 
> In other works: a native ILP32 ABI on an ILP32 kernel would have a 64bit time_t.

We normally like to all newly architectures to have an identical ABI though,
which I think would be more important here. 64-bit time_t of course is what
we want all architectures to have in principle, but we didn't do it for nios2
because of the added complexity. I think it's more likely to have no
__kernel_time_t to defined at some point and only provide __kernel_time64_t
in the future for new architectures, but we have not even introduced that.

> >>>> However, it would be nice to get agreement on the normal 32-bit ABI
> >>>> for time_t and timespec first, and then use the same thing everywhere.
> >>> 
> >>> Do you mean for native 32-bit architectures? I think OpenBSD uses a
> >>> 64-bit time_t already on 32-bit arches, it's doable in Linux as well.
> >> 
> >> Yes, and I'm working on that for Linux. The first step involves fixing
> >> the kernel, one file at a time, changing all users of time_t to use
> >> some other type (ktime_t or time64_t in most cases) instead, and introducing
> >> additional system calls to handle the boundary to user space without
> >> breaking stuff. See my presentation at http://elinux.org/ELC_2015_Presentations
> >> for more detail.
> > 
> > The approach here is primarily to fix the problem for existing 32-bit
> > architectures by adding a new syscall and that's fine. But what if we
> > enforce 64-bit time_t for all _new_ architectures?
> 
> This boils down to whether we can define all the new syscalls _right now_ and
> get the new (extended) compat-layer set up. In this case we could have a userspace 
> implementation that already conforms to this for ILP32.
> 
> Otherwise, we can just put a (MIPS64) N32-alike (AArch64) ILP32 in and migrate
> with everyone else.
> 
> Although it feels wrong to add another ABI that has a known limitation, this may
> in fact be the easiest way, as any fix to ILP32 would be done together with the
> fixes to all other 32bit ABIs.
> 
> So, while I would like to have a 64bit time_t for ILP32 based on principle, I do see
> the 32bit time_t path as the most pragmatic way forward? especially, as this unlinks
> getting ?some form of? ILP32 merged from resolving the 64bit time_t issue across
> all architectures.

Given Catalin's comments from yesterday, I think we can just fix the
definitions of 'struct stat64' for asm-generic to make it have the same
layout as the 64-bit version of 'struct stat', and use that for aarch64-ilp32.

Similarly for the four sysvipc headers, we can have a modified version of
the asm-generic ones in arch/arm64/uapi/asm, which will use the same layout
for ilp32 and lp64 without having to set __kernel_ulong_t to 64-bit.

	Arnd

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 13:47:47 +0000
Subject: IPC SHM alignment on ARMv7
In-Reply-To: <510A7262.4060307@parallels.com>
References: <510A7262.4060307@parallels.com>
Message-ID: <20130131134747.GY23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 05:32:18PM +0400, Alexander Kartashov wrote:
> Dear colleagues,
>
> It tuned out that IPC SHM works in a bit strange way on ARMv7:
> the syscall sys_shmat() requires the argument shmaddr to be SHMLBA-aligned:
>
> [ipc/shm.c]
> [...]
>  979     else if ((addr = (ulong)shmaddr)) {
>  980         if (addr & (shmlba - 1)) {
>  981             if (shmflg & SHM_RND)
>  982                 addr &= ~(shmlba - 1);     /* round down */
>  983             else
>  984 #ifndef __ARCH_FORCE_SHMLBA
>  985                 if (addr & ~PAGE_MASK)
>  986 #endif
>  987                     goto out;
>  988         }
>  989         flags = MAP_SHARED | MAP_FIXED;
> [...]
>
> since macro __ARCH_FORCE_SHMLBA is unconditionally defined for the ARM
> architecture. However it uses the function arch_get_unmapped_area()
> introduced in the commit 4197692eef113eeb8e3e413cc70993a5e667e5b8
> in the mainstream kernel to allocate memory for a SHM segment.

Err, no.  Try again - this is the mainline kernel:

$ git log 4197692eef113eeb8e3e413cc70993a5e667e5b8
fatal: bad object 4197692eef113eeb8e3e413cc70993a5e667e5b8

Would this be in linux-next?  Maybe it's a patch which someone else has
applied which isn't in Linus' kernel?

With just the commit ID and no description (we're *constantly* harping
on about that on this list, especially in commit comments: ALWAYS provide
the description as well) it's much harder to do anything with your report.

Please try again.

Thanks.

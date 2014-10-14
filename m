From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 19:54:45 +0200
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <CAA3XUr2Ny7=+UAPHODjNgHJphY=nMM7AVzNkq_8maVx8tQUceA@mail.gmail.com>
References: <1413266105-32491-1-git-send-email-victor.kamensky@linaro.org>
 <20141014102814.GE26987@e104818-lin.cambridge.arm.com>
 <CAA3XUr2Ny7=+UAPHODjNgHJphY=nMM7AVzNkq_8maVx8tQUceA@mail.gmail.com>
Message-ID: <1920899.8WO1gO7mSe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 October 2014 09:38:15 Victor Kamensky wrote:
> On 14 October 2014 03:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Oct 14, 2014 at 11:08:19AM +0100, Arnd Bergmann wrote:
> >> On Tuesday 14 October 2014 10:53:53 Catalin Marinas wrote:
> >> > > > The problem is that elf_prpsinfo uses __kernel_uid_t which arm32 defines
> >> > > > as (unsigned short) while compat_elf_prspinfo uses __compat_uid_t which
> >> > > > is 32-bit. In reality compat_uid_t is different from the arm32
> >> > > > kernel_uid_t (other 32-bit architectures may use a 32-bit kernel_uid_t).
> >> > >
> >> > > compat_uid_t should match the __kernel_uid_t for all 32-bit architectures
> >> > > that are emulated on a 64-bit architecture, that is the definition.
> >> >
> >> > I guess you meant __compat_uid_t here. The compat_uid_t type is u32
> >> > already.
> >>
> >> Ah, that's weird: compat_uid_t is not used anywhere in the kernel,
> >> and the definition is odd. Apparently it was intentional back in 2005
> >> when Stephen Rothwell introduced it as part of 202e5979af4d9
> >> ("compat: be more consistent about [ug]id_t"), but I have trouble
> >> understanding the intention.
> >
> > It may be worth removing to avoid confusion.
> 
> Do I need to do that? Or it can be done latter? I think, if anyone will do
> that, it should be separate commit anyway.

Yes, a separate commit is best, most importantly because it makes no sense
to backport that to stable.

> >> > So that patch is fine, I'll take it for 3.17 (and cc stable all the way
> >> > back to 3.7).
> 
> Catalin, Arnd, do I have permission to use your Acked-by with next
> post of the patch (where I would "cc stable")?

Please add mine.

> >> Ok. It might be worth checking if there are any uses of __compat_uid_t
> >> in arm64 that should have been __compat_uid32_t. Currently they are
> >> the same, but after Victor's patch, they would be different, which could
> >> cause regressions.
> >
> > A quick grep shows __compat_uid_t being used for:
> >
> > struct compat_ncp_mount_data
> > struct compat_elf_prpsinfo
> > struct compat_ipc_perm
> >
> > In all these cases, the native structures on arm32 would use
> > __kernel_uid_t. The arch/arm64 code doesn't make any use of
> > __compat_uid_t, apart from defining it.
> 
> When I run into the issue, I've tried to look for similar mismatch issues
> in other places. I wrote quick awk script that would parse
> 'readelf --debug-dump vmlinux'
> output and dump names and sizes of all arm64 structs that starts
> with compat_ and then compared them with corresponding structures
> sizes in TC2 image. I saw that compat_ncp_mount_data,
> compat_elf_prpsinfo, compat_ipc_perm and three other that use
> compat_ipc_perm sizes changed. But after the fix applied they
> match arch/arm sizes, and they were not matching before.

Oh, cool. I didn't even know about readelf --debug-dump. I'll
definitely need that soon, thanks for mentioning it!

> Besides those in all other cases arm64 compat and corresponding
> arch/arm struct sizes match each other (modulo missing features in
> TC2 image that were not checked; like cdrom, floppy, video related,
> and few others).

Ok.

	Arnd

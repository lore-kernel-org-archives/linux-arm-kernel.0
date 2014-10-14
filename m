From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 11:29:14 +0200
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <20141014085122.GA26987@e104818-lin.cambridge.arm.com>
References: <1413266105-32491-1-git-send-email-victor.kamensky@linaro.org>
 <1413266105-32491-2-git-send-email-victor.kamensky@linaro.org>
 <20141014085122.GA26987@e104818-lin.cambridge.arm.com>
Message-ID: <1876499.pQrfMV3dKY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 October 2014 09:51:25 Catalin Marinas wrote:
> On Tue, Oct 14, 2014 at 06:55:05AM +0100, Victor Kamensky wrote:
> > The compat_elf_prpsinfo structure does not match the arch/arm struct
> > elf_pspsinfo definition. As result NT_PRPSINFO note in core file
> > created by arm64 kernel for aarch32 (compat) process has wrong size.
> > So gdb cannot display command that caused process crash.
> > 
> > Fix is to change size of __compat_uid_t, __compat_gid_t so it would
> > match size of similar fields in arch/arm case.
> > 
> > Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> > ---
> >  arch/arm64/include/asm/compat.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> > index 253e33b..56de5aa 100644
> > --- a/arch/arm64/include/asm/compat.h
> > +++ b/arch/arm64/include/asm/compat.h
> > @@ -37,8 +37,8 @@ typedef s32         compat_ssize_t;
> >  typedef s32          compat_time_t;
> >  typedef s32          compat_clock_t;
> >  typedef s32          compat_pid_t;
> > -typedef u32          __compat_uid_t;
> > -typedef u32          __compat_gid_t;
> > +typedef u16          __compat_uid_t;
> > +typedef u16          __compat_gid_t;
> >  typedef u16          __compat_uid16_t;
> >  typedef u16          __compat_gid16_t;
> >  typedef u32          __compat_uid32_t;
> 
> __compat_uid_t is defined to match the arm32 uid_t and that would be
> __kernel_uid32_t (or __compat_uid32_t). So this is not the correct fix.

No, I think Victor is right: __compat_uid_t should match the arm32
__kernel_uid_t, not the arm32 uid_t, which is just a kernel-internal
definition, while the __kernel_uid_t is the one used in all user
visible interfaces.

The definition in your asm/compat.h file seems to be a mistake.

> The problem is that elf_prpsinfo uses __kernel_uid_t which arm32 defines
> as (unsigned short) while compat_elf_prspinfo uses __compat_uid_t which
> is 32-bit. In reality compat_uid_t is different from the arm32
> kernel_uid_t (other 32-bit architectures may use a 32-bit kernel_uid_t).

compat_uid_t should match the __kernel_uid_t for all 32-bit architectures
that are emulated on a 64-bit architecture, that is the definition.

	Arnd

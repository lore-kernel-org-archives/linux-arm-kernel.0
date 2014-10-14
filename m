From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Oct 2014 09:53:17 +0100
Subject: [PATCH] arm64: compat: fix compat types affecting struct
 compat_elf_prpsinfo
In-Reply-To: <20141014085122.GA26987@e104818-lin.cambridge.arm.com>
References: <1413266105-32491-1-git-send-email-victor.kamensky@linaro.org>
 <1413266105-32491-2-git-send-email-victor.kamensky@linaro.org>
 <20141014085122.GA26987@e104818-lin.cambridge.arm.com>
Message-ID: <20141014085317.GB26987@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 09:51:25AM +0100, Catalin Marinas wrote:
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
> > @@ -37,8 +37,8 @@ typedef s32		compat_ssize_t;
> >  typedef s32		compat_time_t;
> >  typedef s32		compat_clock_t;
> >  typedef s32		compat_pid_t;
> > -typedef u32		__compat_uid_t;
> > -typedef u32		__compat_gid_t;
> > +typedef u16		__compat_uid_t;
> > +typedef u16		__compat_gid_t;
> >  typedef u16		__compat_uid16_t;
> >  typedef u16		__compat_gid16_t;
> >  typedef u32		__compat_uid32_t;
> 
> __compat_uid_t is defined to match the arm32 uid_t and that would be
> __kernel_uid32_t (or __compat_uid32_t). So this is the correct fix.

I forgot a "not" in here. The above reads as "this is _not_ the correct
fix".

-- 
Catalin

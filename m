From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 5 Dec 2015 11:00:27 +0000
Subject: [PATCH v6 07/19] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <20151204170523.GA2791@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-8-git-send-email-ynorov@caviumnetworks.com>
 <20151203121303.GK10747@e104818-lin.cambridge.arm.com>
 <20151204170523.GA2791@yury-N73SV>
Message-ID: <20151205110025.GA1978@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 08:05:23PM +0300, Yury Norov wrote:
> On Thu, Dec 03, 2015 at 12:13:03PM +0000, Catalin Marinas wrote:
> > On Wed, Nov 18, 2015 at 12:16:47AM +0300, Yury Norov wrote:
> > > diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> > > index 7fbed69..9700e5e 100644
> > > --- a/arch/arm64/include/asm/compat.h
> > > +++ b/arch/arm64/include/asm/compat.h
> > > @@ -299,19 +299,44 @@ struct compat_shmid64_ds {
> > >  	compat_ulong_t __unused5;
> > >  };
> > >  
> > > -static inline int is_compat_task(void)
> > > +#ifdef CONFIG_AARCH32_EL0
> > > +
> > > +static inline int is_a32_compat_task(void)
> > >  {
> > >  	return test_thread_flag(TIF_32BIT);
> > >  }
> > >  
> > > -static inline int is_compat_thread(struct thread_info *thread)
> > > +static inline int is_a32_compat_thread(struct thread_info *thread)
> > >  {
> > >  	return test_ti_thread_flag(thread, TIF_32BIT);
> > >  }
> > >  
> > > +#else
> > > +
> > > +static inline int is_a32_compat_task(void)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline int is_a32_compat_thread(struct thread_info *thread)
> > > +{
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > > +static inline int is_compat_task(void)
> > > +{
> > > +	return is_a32_compat_task();
> > > +}
> > > +
> > >  #else /* !CONFIG_COMPAT */
> > >  
> > > -static inline int is_compat_thread(struct thread_info *thread)
> > > +static inline int is_a32_compat_thread(struct thread_info *thread)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline int is_a32_compat_task(void)
> > >  {
> > >  	return 0;
> > >  }
> > 
> > My main worry with this patch is a potential #include mess. I can see
> > that you already had to include asm/compat.h explicitly in
> > hw_breakpoint.c even though linux/compat.h was already included. In
> > subsequent files (asm/elf.h, asm/memory.h) you check is_compat_task()
> > without explicitly including asm/compat.h and hope that it won't break.
> > 
> > A solution would be to add these functions in a separate header file
> > that gets included where needed (also by asm/compat.h).
> 
> Thank you for pointing that. I don't see big advantage in moving that
> to new file, only if you insist. What about just fixing that mess?

As I said above, you use is_compat_task() in asm/elf.h for example
without including asm/compat.h. At some point, you may get a build error
in some unrelated C file. You could wait until it happens and then sort
it out (by either including asm/compat.h in asm/elf.h or creating a new
header file). My preference is to prevent such build errors early.

-- 
Catalin

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:09:46 +0100
Subject: [PATCH v6 15/20] arm64: signal: move ilp32 and lp64 common code
 to separated file
In-Reply-To: <20151218134855.GA31200@yury-N73SV>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <6089723.moZBJ98Dq4@wuerfel> <20151218134855.GA31200@yury-N73SV>
Message-ID: <2916702.unU22JtYur@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 16:48:55 Yury Norov wrote:
> On Wed, Dec 16, 2015 at 05:08:35PM +0100, Arnd Bergmann wrote:
> > On Wednesday 16 December 2015 00:42:41 Yury Norov wrote:
> > > +               sigtramp = ka->sa.sa_restorer;
> > > +#ifdef CONFIG_ARM64_ILP32
> > > +       else if (is_ilp32_compat_task())
> > > +               sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp_ilp32);
> > > +#endif
> > > +       else
> > > +               sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> > > 
> > 
> > This is another case where I think it's more readable to remove the #ifdef,
> > with no change in behavior.
> > 
> >       Arnd
> 
> No actually. symbol sigtramp_ilp32 is declared in
> arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
> 
> And so it does not exist if CONFIG_ARM64_ILP32 is not set.

You only need the declaration of that symbol, the compiler's dead code
elimination will ensure that no symbol reference is generated when 
the condition is always false at compile time.

	Arnd

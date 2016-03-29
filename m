From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 29 Mar 2016 11:26:05 +0100
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <3792990.eCI4tPEEyD@wuerfel>
References: <1459138743-10477-1-git-send-email-chengang.beijing@gmail.com>
 <3792990.eCI4tPEEyD@wuerfel>
Message-ID: <20160329102605.GC3701@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:19:49PM +0200, Arnd Bergmann wrote:
> On Monday 28 March 2016 12:19:03 Chen Gang wrote:
> > __xl(R0 in little endian system, or R1 in big endian system) is corrupted
> > after calling __do_div64 and compiler is not informed about this in
> > macro __do_div_asm. If n is used again afterwards, __xl won't be
> > reloaded and n will contain incorrect value.
> > 
> > Signed-off-by: Chen Gang <gangchen@rdamicro.com>
> > Signed-off-by: Chen Gang <chengang.beijing@gmail.com>
> > ---
> 
> How did you find this? Did you run into this problem on a live system
> or see it through inspection?
> 
> >  arch/arm/include/asm/div64.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > index e1f0776..1a6e91a 100644
> > --- a/arch/arm/include/asm/div64.h
> > +++ b/arch/arm/include/asm/div64.h
> > @@ -35,12 +35,14 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> >         register unsigned long long __n   asm("r0") = *n;
> >         register unsigned long long __res asm("r2");
> >         register unsigned int __rem       asm(__xh);
> > +       register unsigned int __clobber   asm(__xl);
> >         asm(    __asmeq("%0", __xh)
> >                 __asmeq("%1", "r2")
> > +               __asmeq("%3", "r0")
> > +               __asmeq("%4", "r4")
> >                 __asmeq("%2", "r0")
> > -               __asmeq("%3", "r4")
> >                 "bl     __do_div64"
> > -               : "=r" (__rem), "=r" (__res)
> > +               : "=r" (__rem), "=r" (__res), "=r" (__clobber)
> >                 : "r" (__n), "r" (__base)
> >                 : "ip", "lr", "cc");
> >         *n = __res;
> 
> Doesn't the clobber normally go in the third line along with
> "ip" and "lr"?

Since __xl is not used for any real argument to the asm, I think
we can just add __xl to the clobber list directly, without needing
to introduce an extra register variable ... no?

Cheers
---Dave

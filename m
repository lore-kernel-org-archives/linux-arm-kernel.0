From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 22 Dec 2015 15:45:19 +0000
Subject: [PATCH RESEND v4] arm: remove !CPU_V6 and !GENERIC_ATOMIC64
 build dependencies for XEN
In-Reply-To: <20151222144605.GJ8644@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1512221404060.3096@kaball.uk.xensource.com>
 <20151222144605.GJ8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1512221535470.3096@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015, Russell King - ARM Linux wrote:
> On Tue, Dec 22, 2015 at 02:17:17PM +0000, Stefano Stabellini wrote:
> > Hello Russell,
> > 
> > Would you please consider this patch for the next merge window? It
> > is a very old patch (March 2014) which has been left over.
> 
> This patch has some obvious problems...
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 34e1569..e09ed94 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1807,8 +1807,7 @@ config XEN_DOM0
> >  config XEN
> >  	bool "Xen guest support on ARM"
> >  	depends on ARM && AEABI && OF
> > -	depends on CPU_V7 && !CPU_V6
> > -	depends on !GENERIC_ATOMIC64
> > +	depends on CPU_V7
> 
> How sure are we that this won't cause regressions?  How much testing
> has been done with these changed dependencies?

I did build-test a range of combinations of those options, sorry for not
spotting the error below.


> > diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
> > index 9732b8e..4103319 100644
> > --- a/arch/arm/include/asm/sync_bitops.h
> > +++ b/arch/arm/include/asm/sync_bitops.h
> > @@ -20,7 +20,29 @@
> >  #define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
> >  #define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
> >  #define sync_test_bit(nr, addr)		test_bit(nr, addr)
> > -#define sync_cmpxchg			cmpxchg
> >  
> > +static inline unsigned long sync_cmpxchg(volatile void *ptr,
> > +										 unsigned long old,
> > +										 unsigned long new)
> > +{
> > +	unsigned long oldval;
> > +	int size = sizeof(*(ptr));
> 
> This is buggy.  You're doing sizeof(void) here, which on GCC will always
> be 1:
> 
>    A consequence of this is that `sizeof' is also allowed on `void' and
>   on function types, and returns 1.

You are right, thank you very much for looking at the patch and finding
this bug. I think the issue can be solved with something like:

+#define sync_cmpxchg(ptr, o, n) ({					\
+	(__typeof(*ptr))__sync_cmpxchg((ptr),				\
+				        (unsigned long)(o),		\
+				        (unsigned long)(n),		\
+				        sizeof(*(ptr)));		\
+})
 
+static inline unsigned long __sync_cmpxchg(volatile void *ptr,
+										 unsigned long old,
+										 unsigned long new,
+										 int size)
+{


> > +
> > +	smp_mb();
> > +	switch (size) {
> > +	case 1:
> > +		oldval = __cmpxchg8(ptr, old, new);
> > +		break;
> > +	case 2:
> > +		oldval = __cmpxchg16(ptr, old, new);
> > +		break;
> 
> The ldrexb/ldrexh instructions are not available on ARMv6 CPUs.  __xchg()
> and friends avoided these for ARMv6 CPUs, but this does not.
> 
> I'd expect anything that uses sync_cmpxchg() will fail to build when a
> kernel including ARMv6 is attempted.

The code builds, but of course it could not actually run on CPU_V6. But
the use case for me is building drivers/xen/grant-table.c, which can
only run on CPU_V7 anyway, so it is not a problem.

Is that acceptable for you? If not, do you have any other suggestions?


> So... I don't think this patch is ready.

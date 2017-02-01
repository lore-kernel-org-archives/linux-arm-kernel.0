From: joe@perches.com (Joe Perches)
Date: Wed, 01 Feb 2017 11:49:47 -0800
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CAKv+Gu-Vc-+BDGAWOLJ79KqjL7ZW5vxUk=VW8MqEJyjO2fM6NQ@mail.gmail.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
 <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
 <20161019162222.GT9193@arm.com>
 <c578d5ac-ab8a-974a-bdd9-597b8c545583@redhat.com>
 <CAKv+Gu9G+r7eH0mhniH1+ucrHNiGBMFQdKfMOi=OmekapoBtUg@mail.gmail.com>
 <CAKv+Gu_kifdUOwKgGv1xqboPMjyYRhHwFXDye1HpBo9hQY+_Uw@mail.gmail.com>
 <1485975894.2560.13.camel@perches.com>
 <CAKv+Gu-Vc-+BDGAWOLJ79KqjL7ZW5vxUk=VW8MqEJyjO2fM6NQ@mail.gmail.com>
Message-ID: <1485978587.2560.15.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-01 at 19:31 +0000, Ard Biesheuvel wrote:
> On 1 February 2017 at 19:04, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2017-02-01 at 18:19 +0000, Ard Biesheuvel wrote:
> > > On 1 February 2017 at 17:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > I still think order_base_2() is broken, since it may invoke
> > > > roundup_pow_of_two() with an input value that is documented as
> > > > producing undefined output. I would argue that the below is the
> > > > correct fix.
> > > > 
> > > > diff --git a/include/linux/log2.h b/include/linux/log2.h
> > > > index fd7ff3d91e6a..46523731bec0 100644
> > > > --- a/include/linux/log2.h
> > > > +++ b/include/linux/log2.h
> > > > @@ -203,6 +203,18 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
> > > >   *  ... and so on.
> > > >   */
> > > > 
> > > > -#define order_base_2(n) ilog2(roundup_pow_of_two(n))
> > > > +static inline __attribute__((__const__))
> > > > +unsigned long __order_base_2(unsigned long n)
> > > > +{
> > > > +       return n ? 1UL << fls_long(n - 1) : 1;
> > > > +}
> > > > +
> > > > +#define order_base_2(n)                                \
> > > > +(                                              \
> > > > +       __builtin_constant_p(n) ? (             \
> > > > +               ((n) < 2) ? (n) :               \
> > > > +               ilog2((n) - 1) + 1) :           \
> > > > +       ilog2(__order_base_2(n))                \
> > > > + )
> > > > 
> > > >  #endif /* _LINUX_LOG2_H */
> > > 
> > > Actually, there is a still a redundant shift/fls() in there, this is
> > > even simpler:
> > > 
> > > diff --git a/include/linux/log2.h b/include/linux/log2.h
> > > index fd7ff3d91e6a..4741534bd7af 100644
> > > --- a/include/linux/log2.h
> > > +++ b/include/linux/log2.h
> > > @@ -203,6 +203,18 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
> > >   *  ... and so on.
> > >   */
> > > 
> > > -#define order_base_2(n) ilog2(roundup_pow_of_two(n))
> > > +static inline __attribute__((__const__))
> > 
> > commonly __attribute_const__
> > 
> 
> ... except in <linux/ilog2.h>, which probably predates that.
> 
> > > +unsigned long __order_base_2(unsigned long n)
> > > +{
> > > +       return n > 1 ? ilog2(n - 1) + 1 : 0;
> > > +}
> > > +
> > > +#define order_base_2(n)                                \
> > > +(                                              \
> > > +       __builtin_constant_p(n) ? (             \
> > > +               ((n) < 2) ? (n) :               \
> > > +               ilog2((n) - 1) + 1) :           \
> > > +       __order_base_2(n)                       \
> > > + )
> > 
> > Does this work properly when n is a signed negative value?
> > 
> 
> No, but order_base_2() is explicitly only defined for inputs [0, ->),

where?

> so its behavior for negative inputs is best left undefined.

Or maybe add a BUILD_BUG_ON something like:

#define order_base_2(n)							\
({									\
	typeof(n) _n = n;						\
	BUILD_BUG_ON(__builtin_constant_p(_n) && _n < 0);		\
	__builtin_constant_p(_n) ? (_n < 2 ? _n :?ilog2((_n) - 1) + 1))	\
				 :?__order_base_2(_n);			\
})

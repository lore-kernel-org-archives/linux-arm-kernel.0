From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 10:36:22 +0100
Subject: updates for be8 patch series
In-Reply-To: <CAA3XUr31LAJ3+iWq5gXb+JZO-1G96waOFy-RBVZQEW-djj3dYA@mail.gmail.com>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
 <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
 <CAA3XUr1BJD-ypfJiEsp079qHDERjGp-xFxc_ke_Ep9z3N=UPaA@mail.gmail.com>
 <51EECBBD.20000@codethink.co.uk>
 <CAA3XUr31LAJ3+iWq5gXb+JZO-1G96waOFy-RBVZQEW-djj3dYA@mail.gmail.com>
Message-ID: <20130724093622.GC9629@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 02:06:05AM +0100, Victor Kamensky wrote:
> Hi Ben,
> 
> Let me split off atomic64 from other issues, so we have focused topic here.
> 
> Please see atomic64 issue test case below. Please try it in your setup. I've
> run on Pandaboard ES with my set of patches, but I believe it should be the
> same in your case.

[...]


> <snip>
> 
> >> Index: linux-linaro-tracking/arch/arm/include/asm/atomic.h
> >> ===================================================================
> >> --- linux-linaro-tracking.orig/arch/arm/include/asm/atomic.h
> >> +++ linux-linaro-tracking/arch/arm/include/asm/atomic.h
> >> @@ -301,8 +301,13 @@ static inline void atomic64_add(u64 i, a
> >>
> >>       __asm__ __volatile__("@ atomic64_add\n"
> >>   "1:    ldrexd    %0, %H0, [%3]\n"
> >> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
> >>   "    adds    %0, %0, %4\n"
> >>   "    adc    %H0, %H0, %H4\n"
> >> +#else
> >> +"    adds    %H0, %H0, %H4\n"
> >> +"    adc    %0, %0, %4\n"
> >> +#endif

I thought you could just use the %Q and %R output modifiers to get the
appropriate halves of the 64-bit operand, then you can avoid the #ifdef.

Will

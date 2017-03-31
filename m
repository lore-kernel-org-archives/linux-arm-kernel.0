From: slash.tmp@free.fr (Mason)
Date: Fri, 31 Mar 2017 19:58:07 +0200
Subject: Prototype of find_first_zero_bit in bitops.h
In-Reply-To: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
References: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
Message-ID: <c47d16a2-44dc-fb1d-af84-620278355ed0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Top-posting to address relevance.

Is the proposed patch acceptable, or would it break
something I didn't foresee? Would "make allyesconfig"
or "make allmodconfig" flag potential issues?

Should I submit to the patch mill?

Regards.


On 29/03/2017 13:54, Mason wrote:

> Hello Russell,
> 
> Just wanted to run something by you.
> 
> In some driver code, I was passing the address of a u32 to
> find_first_zero_bit() and the maintainer smacked me, pointing
> out that find_first_zero_bit only accepted (unsigned long *)
> 
> Would it make sense to change the prototype of
> _find_first_zero_bit_le()
> so that my mistake would be caught by the compiler like this:
> 
>   CC      drivers/pci/host/pcie-tango.o
> In file included from ./include/linux/bitops.h:36:0,
>                  from ./include/linux/kernel.h:10,
>                  from ./include/linux/list.h:8,
>                  from ./include/linux/smp.h:11,
>                  from ./include/linux/irq.h:12,
>                  from ./include/linux/irqchip/chained_irq.h:21,
>                  from drivers/pci/host/pcie-tango.c:1:
> drivers/pci/host/pcie-tango.c: In function 'tango_irq_domain_alloc':
> drivers/pci/host/pcie-tango.c:122:28: error:
> passing argument 1 of '_find_first_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   pos = find_first_zero_bit(&mask, 32);
>                             ^
> ./arch/arm/include/asm/bitops.h:199:59: note: in definition of macro 'find_first_zero_bit'
>  #define find_first_zero_bit(p,sz) _find_first_zero_bit_le(p,sz)
>                                                            ^
> ./arch/arm/include/asm/bitops.h:162:12: note: expected 'const long unsigned int *' but argument is of type 'u32 * {aka unsigned int *}'
>  extern int _find_first_zero_bit_le(const unsigned long * p, unsigned size);
>             ^
> 
> 
> Proposed trivial patch:
> 
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -159,8 +159,8 @@ static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned lon
>  /*
>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
>   */
> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
> -extern int _find_next_zero_bit_le(const void * p, int size, int offset);
> +extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
> +extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
>  extern int _find_first_bit_le(const unsigned long *p, unsigned size);
>  extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
>  

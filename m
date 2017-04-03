From: slash.tmp@free.fr (Mason)
Date: Mon, 3 Apr 2017 14:37:25 +0200
Subject: Prototype of find_first_zero_bit in bitops.h
In-Reply-To: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
References: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
Message-ID: <41797b5e-1eac-badf-9f44-08eb7adbba65@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/2017 13:54, Mason wrote:

> Hello Russell,
> 
> Just wanted to run something by you.
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

On IRC, Arnd wrote:
> make find_first_zero_bit() an inline function taking a unsigned long pointer
> instead of a macro, but leave find_first_zero_bit_le taking a void pointer


Can someone point out why the current code handles finding "zero"
(unset) bits differently than finding "one" (set) bits?

_find_first_bit_le() requires a const unsigned long *p argument.
_find_first_zero_bit_le() only requires a const void *p argument.


FWIW, using v4.9 with the proposed patch applied, I ran
make allyesconfig
make -j24 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage

I did not see a single warning during compilation, although the build
fails at link-time with:

  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `alpine_msix_middle_domain_alloc':
zynq-fpga.c:(.text+0xb8): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/built-in.o
zynq-fpga.c:(.text+0xf0): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_unlock' defined in .spinlock.text section in kernel/built-in.o
zynq-fpga.c:(.text+0x114): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_unlock' defined in .spinlock.text section in kernel/built-in.o
zynq-fpga.c:(.text+0x23c): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/built-in.o
zynq-fpga.c:(.text+0x254): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_unlock' defined in .spinlock.text section in kernel/built-in.o
drivers/built-in.o: In function `alpine_msix_init_domains':
zynq-fpga.c:(.text+0x2cc): relocation truncated to fit: R_ARM_CALL against symbol `of_irq_find_parent' defined in .text section in drivers/built-in.o
drivers/built-in.o: In function `alpine_msix_init':
zynq-fpga.c:(.text+0x408): relocation truncated to fit: R_ARM_CALL against symbol `of_address_to_resource' defined in .text section in drivers/built-in.o
zynq-fpga.c:(.text+0x448): relocation truncated to fit: R_ARM_CALL against symbol `of_property_read_variable_u32_array' defined in .text section in drivers/built-in.o
zynq-fpga.c:(.text+0x4c0): relocation truncated to fit: R_ARM_CALL against symbol `of_property_read_variable_u32_array' defined in .text section in drivers/built-in.o
drivers/built-in.o: In function `alpine_msix_middle_domain_free':
zynq-fpga.c:(.text+0x59c): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/built-in.o
zynq-fpga.c:(.text+0x5b4): additional relocation overflows omitted from the output
make: *** [vmlinux] Error 1

Which I don't think is related to the bitops prototypes.

Regards.

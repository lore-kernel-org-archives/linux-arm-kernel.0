From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Mar 2016 12:44:23 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <3093807.B56fh7Radq@wuerfel>
References: <56D8BA3F.7050508@pengutronix.de>
 <20160304110210.GA19428@n2100.arm.linux.org.uk>
 <CAKv+Gu8b05BsNMPD2QNf9pLyRwSNGhc-5TVskwfudYuVqeCoAw@mail.gmail.com>
 <3093807.B56fh7Radq@wuerfel>
Message-ID: <CAKv+Gu_HttHOutHAw-k_uwmTUGjUsTWCotVHroqRK0NQDOGkNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 12:38, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 March 2016 12:14:24 Ard Biesheuvel wrote:
>> On 4 March 2016 at 12:02, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Mar 04, 2016 at 11:48:10AM +0100, Ard Biesheuvel wrote:
>> >> I don't think it is the job of the filesystem driver to reason about
>> >> whether get_unaligned_le64() does the right thing under any particular
>> >> configuration. If ARM's implementation of get_unaligned_le64() issues
>> >> load instructions that result in a trap, it is misbehaving and should
>> >> be fixed.
>> >
>> > It's not ARMs implementation, we don't have our own implementation, but
>> > we seem to (today) use asm-generic stuff, which is sub-optimal.
>> >
>>
>> Indeed. I was not suggesting that ARM carries broken code, simply that
>> btrfs should not have to worry that it gets built on a platform that
>> requires extra care when invoking get_unaligned_le64()
>>
>> > Looking at the state of that, I guess we need to implement our own
>> > asm/unaligned.h - and as the asm-generic stuff assumes that all
>> > access sizes fall into the same categories, I'm guessing we'll need
>> > to implement _all_ accessors ourselves.
>> >
>> > That really sounds very sub-optimal, but I don't see any other solution
>> > which wouldn't make the asm-generic stuff even more painful to follow
>> > through multiple include files than it already is today.
>> >
>>
>> I wonder if we should simply apply something like the patch below
>> (untested): it depends on how many 32-bit architectures implement
>> double word load instructions, but for ones that don't, the patch
>> shouldn't change anything, nor should it change anything for 64-bit
>> architectures.
>
> I think it's wrong to change the common code, it's unlikely that
> any other architectures have this specific requirement.
>

In general, yes. In practice, it depends on whether any 32-bit
architectures have double word loads that can perform arbitrary
unaligned accesses.

> Here is a patch I've come up with independently. I have verified
> that it removes all ldrd/strd from the btrfs unaligned data
> handling.
>
> The open question about it is whether we'd rather play safe and
> let the compiler handle unaligned accesses itself, removing the
> theoretical risk of the compiler optimizing
>
>         void *p;
>         u64 v = get_unaligned((u32)p) + (get_unaligned((u32)(p + 4)) << 32);
>
> into an ldrd. I think the linux/unaligned/access_ok.h implementation
> would allow that.
>

I would assume that the compiler engineers are aware of the alignment
requirement of ldrd/strd, and don't promote adjacent accesses like
that if the pointer may not be 64-bit aligned.

> commit abf1d8ecc9d88c16dbb72ec902eee79fe5edd2dc
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Mar 4 12:28:09 2016 +0100
>
>     ARM: avoid ldrd/strd for get/put_unaligned
>
>     The include/linux/unaligned/access_ok.h header tells the compiler
>     that it can pretend all pointers to be aligned. This is not true
>     on ARM, as 64-bit variables are typically accessed using ldrd/strd,
>     which require 32-bit alignment.
>
>     This introduces an architecture specific asm/unaligned.h header
>     that uses the normal "everything is fine" implementation for 16-bit
>     and 32-bit accesses, but uses the struct based implementation for
>     64-bit accesses, which the compiler is smart enough to handle using
>     multiple 32-bit acceses.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 55e0e3ea9cb6..bd12b98e2589 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -37,4 +37,3 @@ generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += timex.h
>  generic-y += trace_clock.h
> -generic-y += unaligned.h
> diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
> new file mode 100644
> index 000000000000..4cb7b641778a
> --- /dev/null
> +++ b/arch/arm/include/asm/unaligned.h
> @@ -0,0 +1,108 @@
> +#ifndef _ARM_ASM_UNALIGNED_H
> +#define _ARM_ASM_UNALIGNED_H
> +
> +/*
> + * This is the most generic implementation of unaligned accesses
> + * and should work almost anywhere.
> + */
> +#include <asm/byteorder.h>
> +#include <linux/kernel.h>
> +#include <asm/byteorder.h>

Any particular reason to include this twice?

> +
> +/* Set by the arch if it can handle unaligned accesses in hardware. */
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#include <linux/unaligned/packed_struct.h>
> +
> +/*
> + * These are copied from include/linux/unaligned/access_ok.h:
> + * we pretend everything is fully aligned and let the compiler
> + * always issue normal loads/stores. This isn't entirely correct
> + * as we effectively cast a pointer from smaller alignment
> + * to larger alignment, but it works fine until gcc gets smart
> + * enough to merge multiple consecutive get_unaligned() calls
> + * into a single ldm/stm or ldrd/strd instruction.
> + */
> +static __always_inline u16 get_unaligned_le16(const void *p)
> +{
> +       return le16_to_cpup((__le16 *)p);
> +}
> +
> +static __always_inline u32 get_unaligned_le32(const void *p)
> +{
> +       return le32_to_cpup((__le32 *)p);
> +}
> +
> +static __always_inline u16 get_unaligned_be16(const void *p)
> +{
> +       return be16_to_cpup((__be16 *)p);
> +}
> +
> +static __always_inline u32 get_unaligned_be32(const void *p)
> +{
> +       return be32_to_cpup((__be32 *)p);
> +}
> +
> +static __always_inline void put_unaligned_le16(u16 val, void *p)
> +{
> +       *((__le16 *)p) = cpu_to_le16(val);
> +}
> +
> +static __always_inline void put_unaligned_le32(u32 val, void *p)
> +{
> +       *((__le32 *)p) = cpu_to_le32(val);
> +}
> +
> +static __always_inline void put_unaligned_be16(u16 val, void *p)
> +{
> +       *((__be16 *)p) = cpu_to_be16(val);
> +}
> +
> +static __always_inline void put_unaligned_be32(u32 val, void *p)
> +{
> +       *((__be32 *)p) = cpu_to_be32(val);
> +}
> +
> +/*
> + * These use the packet_struct implementation to split up a
> + * potentially unaligned ldrd/strd into two 32-bit accesses
> + */
> +static __always_inline u64 get_unaligned_le64(const void *p)
> +{
> +       return le64_to_cpu((__le64 __force)__get_unaligned_cpu64(p));
> +}
> +
> +static __always_inline u64 get_unaligned_be64(const void *p)
> +{
> +       return be64_to_cpu((__be64 __force)__get_unaligned_cpu64(p));
> +}
> +
> +static __always_inline void put_unaligned_le64(u64 val, void *p)
> +{
> +       __put_unaligned_cpu64((u64 __force)cpu_to_le64(val), p);
> +}
> +
> +static __always_inline void put_unaligned_be64(u64 val, void *p)
> +{
> +       __put_unaligned_cpu64((u64 __force)cpu_to_be64(val), p);
> +}
> +#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> +
> +#if defined(__LITTLE_ENDIAN)
> +# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#  include <linux/unaligned/le_struct.h>
> +#  include <linux/unaligned/be_byteshift.h>
> +# endif
> +# include <linux/unaligned/generic.h>
> +# define get_unaligned __get_unaligned_le
> +# define put_unaligned __put_unaligned_le
> +#elif defined(__BIG_ENDIAN)
> +# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#  include <linux/unaligned/be_struct.h>
> +#  include <linux/unaligned/le_byteshift.h>
> +# endif
> +# include <linux/unaligned/generic.h>
> +# define get_unaligned __get_unaligned_be
> +# define put_unaligned __put_unaligned_be
> +#endif
> +
> +#endif /* _ARM_ASM_UNALIGNED_H */
>

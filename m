From: stefan@agner.ch (Stefan Agner)
Date: Mon, 01 Oct 2018 21:48:10 +0200
Subject: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
In-Reply-To: <20181001165342.GR30658@n2100.armlinux.org.uk>
References: <20180930222230.24167-1-stefan@agner.ch>
 <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
 <20181001165342.GR30658@n2100.armlinux.org.uk>
Message-ID: <ec3341f756c642908996348c9daceb19@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.10.2018 18:53, Russell King - ARM Linux wrote:
> On Sun, Sep 30, 2018 at 04:48:20PM -0700, Joe Perches wrote:
>> On Mon, 2018-10-01 at 00:22 +0200, Stefan Agner wrote:
>> > The kernel passes the ArmV6K architecture to the compiler when
>> > using the multi platform selection and enabling ARMv6. Clang
>> > older than version 8.0 emit assembly with an non-existing CPU,
>> > which then makes the assembler fail. Prevent the user from
>> > selecting ARMv6 when using Clang before 8.0.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/55
>> > ---
>> >  arch/arm/Kconfig | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index e8cd55a5b04c..8da160757381 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
>> >
>> >  config ARCH_MULTI_V6
>> >  	bool "ARMv6 based platforms (ARM11)"
>> > +	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
>> >  	select ARCH_MULTI_V6_V7
>> >  	select CPU_V6K
>> >
>>
>> Perhaps it'd be better to avoid this in selection
>> criteria in Kconfig and instead add this to
>> include/linux/compiler_clang.h
>> ---
>>  include/linux/compiler-clang.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
>> index b1ce500fe8b3..90fd16c85359 100644
>> --- a/include/linux/compiler-clang.h
>> +++ b/include/linux/compiler-clang.h
>> @@ -3,6 +3,10 @@
>>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>>  #endif
>>
>> +#if defined(CONFIG_ARCH_MULTI_V6) && CLANG_VERSION < 80000
>> +# error Sorry, your compiler is too old - please upgrade it.
>> +#endif
> 
> (a) does it makes sense to have arch CONFIG_* in linux/*.h?  It could
>     instead go in arch/arm/kernel/asm-offsets.c, where we have the other
>     tests similar to this for GCC.
> 
> (b) do we get far enough that the #error will be generated before the
>     reported assembler error happens?  IOW, would the assembler error
>     mask this #error?
> 
> I think it needs confirmation that a #error for this problem results
> in the desired behaviour.

Adding the above #error errors out before the assembler error happen in
both cases.

However, adding it to include/linux/compiler-clang.h leads to a bunch of
warnings too:

...
  CC      kernel/bounds.s
In file included from <built-in>:2:
In file included from ././include/linux/compiler_types.h:59:
./include/linux/compiler-clang.h:7:2: error: "Sorry, your compiler is
too old - please upgrade it."
#error "Sorry, your compiler is too old - please upgrade it."
 ^
In file included from kernel/bounds.c:10:
In file included from ./include/linux/page-flags.h:10:
In file included from ./include/linux/bug.h:5:
In file included from ./arch/arm/include/asm/bug.h:60:
In file included from ./include/asm-generic/bug.h:18:
In file included from ./include/linux/kernel.h:11:
./include/linux/bitops.h:53:41: warning: shift count >= width of type
[-Wshift-count-overflow]
        return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
                                               ^~~~~~~~~~~~
./include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from
macro 'hweight64'
#define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) :
__arch_hweight64(w))
                                                ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from
macro '__const_hweight64'
#define __const_hweight64(w) (__const_hweight32(w) +
__const_hweight32((w) >> 32))
                                                                        
  ^  ~~
./include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from
macro '__const_hweight32'
#define __const_hweight32(w) (__const_hweight16(w) +
__const_hweight16((w) >> 16))
                                                ^
./include/asm-generic/bitops/const_hweight.h:19:48: note: expanded from
macro '__const_hweight16'
#define __const_hweight16(w) (__const_hweight8(w)  +
__const_hweight8((w)  >> 8 ))
                                               ^
./include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from
macro '__const_hweight8'
         ((!!((w) & (1ULL << 0))) +     \
               ^


Including it to arch/arm/kernel/asm-offsets.c does not lead to those
warnings:

...
  CC      kernel/bounds.s                                               
                                                                   
  UPD     include/generated/bounds.h                                    
                                                                   
  CC      arch/arm/kernel/asm-offsets.s                                 
                                                                   
arch/arm/kernel/asm-offsets.c:51:2: error: "Sorry, your compiler is too
old - please upgrade it."                                           
#error "Sorry, your compiler is too old - please upgrade it."           
                                                                   
 ^                                                                      
                                                                   
1 error generated.                                                      
                                                                   
make[1]: *** [Kbuild:56: arch/arm/kernel/asm-offsets.s] Error 1         
                                                                   
make: *** [Makefile:1100: prepare0] Error 2

--
Stefan

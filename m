From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jul 2013 13:32:50 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <51E92DE5.6090404@codethink.co.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
 <51E92DE5.6090404@codethink.co.uk>
Message-ID: <20130719123249.GE24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 01:15:33PM +0100, Ben Dooks wrote:
> On 19/07/13 12:09, Russell King - ARM Linux wrote:
>> On Fri, Jul 19, 2013 at 11:58:45AM +0100, Ben Dooks wrote:
>>> I ran in to an issue with the alignment handler when running BE8 where
>>> it loads instructions and fails to swap.
>>>
>>> Is there a better way of swapping instructions for ARM when loading
>>> from arbitrary places? Have I missed any other places this could happen?
>>
>> Maybe we need a macro which deals with this automatically?
>>
>> 	arm_instr_to_cpu(x)
>> 	thumb_instr_to_cpu(x)
>>
>> These should probably make use of the swab*() macros when an endian swap
>> is needed.
>>
>>> The following patch is my first attempt at solving the problem for the
>>> alignment handler:
>>
>> I'd suggest checking this with sparse too - you have some type errors here.
>
> How about:
>
> diff --git a/arch/arm/include/uapi/asm/byteorder.h  
> b/arch/arm/include/uapi/asm/b
> index 7737974..9e63a00 100644
> --- a/arch/arm/include/uapi/asm/byteorder.h
> +++ b/arch/arm/include/uapi/asm/byteorder.h
> @@ -21,5 +21,13 @@
>  #include <linux/byteorder/little_endian.h>
>  #endif
>
>
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define cpu_to_arm_instr(__instr)      swab32(__instr)
> +#define cpu_to_thum_instr(__instr)     swab16(__instr)
> +#else
> +#define cpu_to_arm_instr(__instr)      (__instr)
> +#define cpu_to_thum_instr(__instr)     (__instr)
> +#endif

ARGH.

First point: does userspace have any knowledge how the kernel is
configured?  Do they include the kernel configuration header file?  No.
Therefore the use of CONFIG_* in UAPI header files is wrong.

Second point: does userspace need these macros and should the kernel
provide them to userspace?  No on both counts.  Therefore, this must
not be placed in UAPI.

UAPI was created explicitly to separate the kernel private definitions
from the parts of the kernel interface which the user API depends on.

If you value your soul, NEVER EVER EVER place stuff which is not part
of the user API in a header file in a UAPI subdirectory.  And never
modify a header file in a UAPI subdirectory without first having a
good long think about how that modification may impact _userspace_.

Third point: the name is totally and utterly wrong.  I think you've
misunderstood the naming conventions of the cpu_to_xxx() and xxx_to_cpu()
macros.  "cpu" is the CPUs native data endianness - the endianness that
you can do standard arithmetic on and you get the right answer.  "xxx"
is the "foreign" endianness.  In this case, it's the instructions which
are not the CPUs native data endianness, so they are the foreign state -
they are the "xxx".

So, I've no idea why you decided to reverse the name of the macro I gave
you...  I am astounded at this.

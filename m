From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 2 Oct 2014 18:04:06 -0500
Subject: [PATCH] arm: socfpga: fix fetching cpu1start_addr for system with
 > 2GB of ram
In-Reply-To: <542DD4F5.1050602@opensource.altera.com>
References: <1412161334-12359-1-git-send-email-dinguyen@opensource.altera.com>
 <20141001132057.GO5182@n2100.arm.linux.org.uk>
 <542DD4F5.1050602@opensource.altera.com>
Message-ID: <CADhT+wdURETyJbWnwHCi1pAOb4ZbWJb53EmN8b0B_rA=pd10zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 2, 2014 at 5:43 PM, Dinh Nguyen
<dinguyen@opensource.altera.com> wrote:
> On 10/01/2014 08:20 AM, Russell King - ARM Linux wrote:
>> On Wed, Oct 01, 2014 at 06:02:14AM -0500, dinguyen at opensource.altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>>
>>> When CPU1 is brought out of reset, it's MMU is not turned yet, so it will only
>>> be able to use physical addresses. For systems with 1GB or less, clearing
>>> 0x40000000 will work just fine. However for systems with 2GB or more, we
>>> need to clear at least 0x80000000.
>>>
>>> Essentially, the bic instruction is converting the cpu1start_addr from a
>>> virtual to a physical address. We should be using bic 0xf0000000 for all
>>> systems.
>>
>> Err.  Why not do the job properly rather than create this type of hack?
>> This is not a fast path, so it's really not required to code it for an
>> absolute minimum number of cycles.  So...
>>
>>       adr     r0, 1f          @ physical address of '1'
>>       ldmia   r0, {r1, r2}    @ load virtual address of '1' and 'cpu1start_addr'
>>       sub     r0, r0, r1      @ offset between virtual and physical
>>       ldr     r2, [r2, r0]    @ load *cpu1start_addr
>>       bx      r2
>> ...
>>       .align
>> 1:    .long   .
>>       .long   cpu1start_addr
>>
>> will fix it properly.
>>
>
> Thanks for the suggestion and the code, but it didn't seem to work for
> me. But I think I found a way to just load in the value of
> cpu1start_addr directly with this patch. Please let me know what you
> think of this solution:
>
>
> diff --git a/arch/arm/mach-socfpga/headsmp.S
> b/arch/arm/mach-socfpga/headsmp.S
> index 95c115d..3ca9ed1 100644
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -13,17 +13,14 @@
>         .arch   armv7-a
>
>  ENTRY(secondary_trampoline)
> -       movw    r2, #:lower16:cpu1start_addr
> -       movt  r2, #:upper16:cpu1start_addr
> -
> -       /* The socfpga VT cannot handle a 0xC0000000 page offset when
> loading
> -               the cpu1start_addr, we bit clear it. Tested on HW and VT. */
> -       bic     r2, r2, #0x40000000
> -
> -       ldr     r0, [r2]
> +       ldr     r0, 1f
>         ldr     r1, [r0]
>         bx      r1
>
> +       .globl  cpu1start_addr
>

I guess I should also rename cpu1start_addr to socfpga_cpu1start_addr
to avoid name collisions?

Dinh

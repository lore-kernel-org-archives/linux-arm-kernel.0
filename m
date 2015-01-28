From: elder@linaro.org (Alex Elder)
Date: Wed, 28 Jan 2015 11:08:33 -0600
Subject: [PATCH] bcm: address clang inline asm incompatibility
In-Reply-To: <CAKv+Gu8CrMqwqBOF8rYa3RP1=gfCthwP=1k9kQ73v6+Sxwah4A@mail.gmail.com>
References: <1422422306-27473-1-git-send-email-behanw@converseincode.com>	<CAKv+Gu_NCgMmX_LQqi7vtjtP4ofrW+kx8FPgRd4-LWwK=73-xg@mail.gmail.com>	<54C8EE04.6060809@linaro.org>
 <CAKv+Gu8CrMqwqBOF8rYa3RP1=gfCthwP=1k9kQ73v6+Sxwah4A@mail.gmail.com>
Message-ID: <54C91791.9030508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 10:17 AM, Ard Biesheuvel wrote:
> On 28 January 2015 at 14:11, Alex Elder <elder@linaro.org> wrote:
>> On 01/28/2015 05:15 AM, Ard Biesheuvel wrote:
>>> On 28 January 2015 at 05:18, Behan Webster <behanw@converseincode.com> wrote:
>>>> From: Alex Elder <elder@linaro.org>
>>>>
>>>> My GCC-based build environment likes to call register r12 by the
>>>> name "ip" in inline asm.  Behan Webster informed me that his Clang-
>>>> based build environment likes "r12" instead.
>>>>
>>>> Try to make them both happy.
>>>>
>>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>>>> ---
>>>>  arch/arm/mach-bcm/bcm_kona_smc.c | 9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
>>>> index a55a7ec..3937bd5 100644
>>>> --- a/arch/arm/mach-bcm/bcm_kona_smc.c
>>>> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
>>>> @@ -106,9 +106,14 @@ int __init bcm_kona_smc_init(void)
>>>>   * request result appropriately.  This result value is found in r0
>>>>   * when the "smc" request completes.
>>>>   */
>>>> +#ifdef __clang__
>>>> +#define R12    "r12"
>>>> +#else  /* !__clang__ */
>>>> +#define R12    "ip"    /* gcc calls r12 "ip" */
>>>> +#endif /* !__clang__ */
>>>
>>> Why not just use r12 for both?
>>
>> Yes, that would have been an obvious fix.  But the
>> assembler (in the GCC environment) doesn't accept that.
>>
> 
> Mine has no problems with it at all
> 
> $ echo 'mov r12, #0' | arm-linux-gnueabihf-gcc -c -x assembler-with-cpp -
> 
> and grepping for r12 under arch/arm suggests the same

The use of "r12" is fine.  But it's not just the assembler,
I believe it also involves gcc.

The problem is with the use of the __asmeq(x, y) macro.

If I assign the "ip" variable with "r12":
        register u32 ip asm("r12");     /* Also called ip */

Then that's fine.  However, this line then causes an error:
                __asmeq("%0", "r12")

Apparently gcc uses register "ip" when it sees asm("r12").  So
attempting to verify the desired register got used with __asmeq()
causes a string mismatch--"ip" is not equal to "r12".

So I could use:

        register u32 ip asm("r12");     /* Also called ip */
		...
                __asmeq("%0", "ip")

And that will build.  But it's a little non-intuitive, and
I suspect that clang might (rightfully) have a failure in
this __asmeq() call.

					-Alex

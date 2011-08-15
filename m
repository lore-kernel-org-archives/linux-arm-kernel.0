From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 15 Aug 2011 14:25:22 +0100
Subject: [PATCH] ARM: mm/alignment.c: Fix build breakage when
	CONFIG_PROC_FS is not selected
In-Reply-To: <CAFULf_ynEP=XBQYumKVoDLiMCiSBzx0-8RAzLHsYAqX7=XJWHw@mail.gmail.com>
References: <CAFULf_zzAZKk5CsPz+9x1i0gORbapwBBwzRH1BM7s_ZuEs_8DQ@mail.gmail.com>
	<20110815104900.GA2075@arm.com>
	<CAFULf_ynEP=XBQYumKVoDLiMCiSBzx0-8RAzLHsYAqX7=XJWHw@mail.gmail.com>
Message-ID: <CA+wbFdeCnsgREb7e5Ziz7uJ3ARSU4+p3_4st-YhuNYhG26Jitg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 1:45 PM, Bjarne Steinsbo <bsteinsbo@gmail.com> wrote:
> Dave,
>
> If it's up to me, I would say leave it as it is. ?I'm all for changing
> the code to logically group similar functions, but I feel that should
> be a different patch. ?One for you, maybe?

I'm happy either way, so let's go with your smaller patch.

I won't post an extra patch to move the functions unless I do some
future work on that file.  I think that a cosmetic thing like this
doesn't really merit an extra patch for now.

Thanks again
---Dave

>
> BR,
>
> Bjarne Steinsbo
>
> a) That would produce a bigger patch, and
> b) Moving code around to logically group similar functions is a different patch
>
> On Mon, Aug 15, 2011 at 12:49 PM, Dave Martin <dave.martin@linaro.org> wrote:
>> On Sun, Aug 14, 2011 at 02:51:48PM +0200, Bjarne Steinsbo wrote:
>>> Compiling mm/alignment.c without CONFIG_PROC_FS selected fails with
>>> undefined cpu_is_v6_unaligned() and safe_usermode().
>>>
>>> Move #ifdef CONFIG_PROC_FS, including definition of usermode_action[],
>>> further down to avoid this problem.
>>
>> Those two functions were never supposed to be inside the #ifdef --
>> my bad. ?Thanks for spotting it.
>>
>> Acked-by: Dave Martin <dave.martin@linaro.org>
>>
>> Alternatively, it may be tidier to move cpu_is_v6_unaligned() and
>> safe_usermode() alongside the other static functions, just before
>> do_alignment_finish_ldst().
>>
>> I leave it up to you to decide whether you prefer that; either fix
>> is valid.
>>
>> Cheers
>> ---Dave
>>
>>>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
>>> ---
>>> ?arch/arm/mm/alignment.c | ? 20 ++++++++++----------
>>> ?1 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
>>> index cfbcf8b..c335c76 100644
>>> --- a/arch/arm/mm/alignment.c
>>> +++ b/arch/arm/mm/alignment.c
>>> @@ -86,16 +86,6 @@ core_param(alignment, ai_usermode, int, 0600);
>>> ?#define UM_FIXUP ? ? (1 << 1)
>>> ?#define UM_SIGNAL ? ?(1 << 2)
>>>
>>> -#ifdef CONFIG_PROC_FS
>>> -static const char *usermode_action[] = {
>>> - ? ? "ignored",
>>> - ? ? "warn",
>>> - ? ? "fixup",
>>> - ? ? "fixup+warn",
>>> - ? ? "signal",
>>> - ? ? "signal+warn"
>>> -};
>>> -
>>> ?/* Return true if and only if the ARMv6 unaligned access model is in use. */
>>> ?static bool cpu_is_v6_unaligned(void)
>>> ?{
>>> @@ -123,6 +113,16 @@ static int safe_usermode(int new_usermode, bool warn)
>>> ? ? ? return new_usermode;
>>> ?}
>>>
>>> +#ifdef CONFIG_PROC_FS
>>> +static const char *usermode_action[] = {
>>> + ? ? "ignored",
>>> + ? ? "warn",
>>> + ? ? "fixup",
>>> + ? ? "fixup+warn",
>>> + ? ? "signal",
>>> + ? ? "signal+warn"
>>> +};
>>> +
>>> ?static int alignment_proc_show(struct seq_file *m, void *v)
>>> ?{
>>> ? ? ? seq_printf(m, "User:\t\t%lu\n", ai_user);
>>> --
>>> 1.7.1
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>



-- 
Dave Martin <dave.martin@linaro.org>
Linaro Kernel Working Group

--
http://www.linaro.org/ -- Open source software for ARM SoCs

http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg
http://www.linaro.org/linaro-blog/

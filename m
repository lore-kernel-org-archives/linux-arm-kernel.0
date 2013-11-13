From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Nov 2013 12:31:15 -0800
Subject: [PATCH] ARM: omap: fix warning with LPAE build
In-Reply-To: <20131113200527.GA10317@atomide.com>
References: <1384325630-26998-1-git-send-email-olof@lixom.net>
 <20131113200527.GA10317@atomide.com>
Message-ID: <CAOesGMhcg732xXtXUmpzvc9WzR_rGM2pjkNmzf3_40zkTFJRKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 12:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Olof Johansson <olof@lixom.net> [131112 22:53]:
>> Some omap3 code is throwing a warning:
>> arch/arm/mach-omap2/pm34xx.c: In function 'omap3_save_secure_ram_context':
>> arch/arm/mach-omap2/pm34xx.c:123:32: warning: cast to pointer from
>>   integer of different size [-Wint-to-pointer-cast]
>>
>> In reality this code will never actually execute with LPAE=y, since
>> Cortex-A8 doesn't support it. So downcasting the __pa() is safe in
>> this case.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> Tony, queue up if you have a fixes branch please, otherwise I can apply
>> directly.
>>
>>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 93b80e5..1f3770a 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -120,7 +120,7 @@ static void omap3_save_secure_ram_context(void)
>>                * will hang the system.
>>                */
>>               pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>> -             ret = _omap_save_secure_sram((u32 *)
>> +             ret = _omap_save_secure_sram((u32 *)(unsigned long)
>>                               __pa(omap3_secure_ram_storage));
>>               pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
>>               /* Following is for error tracking, it should not happen */
>
> Hmm maybe the function prototype should be changed instead if
> it takes the physical address.
>
> How do you you reproduce this warning? I did not get it after
> enabling LPAE in multi_v7_defconfig with current mainline.

Of course. No more late night patching for me. :)

I saw it in last night's -next.


-Olof

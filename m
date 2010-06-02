From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 2 Jun 2010 15:06:58 +0800
Subject: [PATCH] NUC900/rtc: change the waiting for device ready implement
In-Reply-To: <20100601154324.f1273812.akpm@linux-foundation.org>
References: <4BFE1853.5070105@gmail.com>
	<20100601154324.f1273812.akpm@linux-foundation.org>
Message-ID: <AANLkTikkNZ9DkUUxm6eWTv-UY-Cfl7yT0XZHurMr5vb7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew ,

The patch makes two changes:
(1) it adds an mdelay(1) to the polling loop

Here I change the 'for' loop to 'while' loop and and add an mdelay(1),
which can make less access to the hardware register.

(2) it changes the return value from ENODEV to EPERM if the loop timed out.

I think the 'Operation not permitted' description is more suitable for
the meaning
of 'check_rtc_access_enable()' function, it just be used to judge rtc
access operation is permitted or not.



2010/6/2 Andrew Morton <akpm@linux-foundation.org>:
> On Thu, 27 May 2010 14:59:31 +0800
> Wan ZongShun <mcuos.com@gmail.com> wrote:
>
>> Dear Andrew,
>>
>> This patch is only to change the waiting for device ready implement
>> for winbond nuc900 platform.
>>
>
> It's not very helpful to only say "I changed it". ?_why_ did you change
> it? ?What change did you make? ?What was wrong with the old code and
> what's better about the new code?
>
>> --- a/drivers/rtc/rtc-nuc900.c
>> +++ b/drivers/rtc/rtc-nuc900.c
>> @@ -85,22 +85,21 @@ static irqreturn_t nuc900_rtc_interrupt(int irq, void *_rtc)
>>
>> ?static int *check_rtc_access_enable(struct nuc900_rtc *nuc900_rtc)
>> ?{
>> - ? ? unsigned int i;
>> + ? ? unsigned int i, timeout = 0x1000;
>> ? ? ? __raw_writel(INIRRESET, nuc900_rtc->rtc_reg + REG_RTC_INIR);
>>
>> ? ? ? mdelay(10);
>>
>> ? ? ? __raw_writel(AERPOWERON, nuc900_rtc->rtc_reg + REG_RTC_AER);
>>
>> - ? ? for (i = 0; i < 1000; i++) {
>> - ? ? ? ? ? ? if (__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB)
>> - ? ? ? ? ? ? ? ? ? ? return 0;
>> - ? ? }
>> + ? ? while (!(__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? && timeout--)
>> + ? ? ? ? ? ? mdelay(1);
>>
>> - ? ? if ((__raw_readl(nuc900_rtc->rtc_reg + REG_RTC_AER) & AERRWENB) == 0x0)
>> - ? ? ? ? ? ? return ERR_PTR(-ENODEV);
>> + ? ? if (!timeout)
>> + ? ? ? ? ? ? return ERR_PTR(-EPERM);
>>
>> - ? ? return ERR_PTR(-EPERM);
>> + ? ? return 0;
>> }
>
> I can see that the patch makes two changes: it adds an mdelay(1) to the
> polling loop and it changes the return value from ENODEV to EPERM if
> the loop timed out.
>
> But I don't have the faintest idea _why_ the changes were made!
>
>
> So. ?I merged the patch without a changelog. ?Please send a changelog
> for this patch which permits others to understand the change.
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com

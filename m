From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 8 Jun 2016 20:17:49 -0400
Subject: [PATCH] drm/exynos: don't use HW trigger for Exynos5420/5422/5800
In-Reply-To: <5758A58D.7050106@samsung.com>
References: <CGME20160602142058epcas1p4f26bc6ab2acd0012962f90bb2c6c4141@epcas1p4.samsung.com>
 <1464877210-27207-1-git-send-email-javier@osg.samsung.com>
 <5758A58D.7050106@samsung.com>
Message-ID: <6e24059d-16f3-210a-8dd2-f8dcb89213a1@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Inki,

Thanks for your feedback.

On 06/08/2016 07:09 PM, Inki Dae wrote:
> Hi Javier,
> 
> 2016? 06? 02? 23:20? Javier Martinez Canillas ?(?) ? ?:
>> Commit a6f75aa161c5 ("drm/exynos: fimd: add HW trigger support") added
>> hardware trigger support to the FIMD controller driver. But this broke
>> the display in at least the Exynos5800 Peach Pi Chromebook.
>>
>> So until the issue is fixed, avoid using HW trigger for the Exynos5420
>> based boards and use SW trigger as it was before the mentioned commit.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>> Hello Inki,
>>
>> Since commit a6f75aa161c5 landed in v4.7-rc1, I think $SUBJECT should be
>> picked to make sure that v4.7 is released with the display working for
>> the Exynos5420 based Chromebooks.
>>
>> We can then figure out what's wrong with the HW trigger support and fix
>> it for v4.8.
> 
> Agree. And below is a trivial comment.
>

I'm glad that you agree.

>>
>> Best regards,
>> Javier
>>
>>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>> index 1c23a8ff5e83..f10030ff00e6 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>> @@ -170,14 +170,11 @@ static struct fimd_driver_data exynos5420_fimd_driver_data = {
>>  	.lcdblk_vt_shift = 24,
>>  	.lcdblk_bypass_shift = 15,
>>  	.lcdblk_mic_bypass_shift = 11,
>> -	.trg_type = I80_HW_TRG,
>>  	.has_shadowcon = 1,
>>  	.has_vidoutcon = 1,
>>  	.has_vtsel = 1,
>>  	.has_mic_bypass = 1,
>>  	.has_dp_clk = 1,
>> -	.has_hw_trigger = 1,
>> -	.has_trigger_per_te = 1,
> 
> We don't need to remove above two lines. It would be enough to remove 'trg_type = I80_HW_TRG', which makes FIMD to be worked with SW trigger in default.
>

I know that removing .trg_type is enough but I also removed those lines
because the fields are not used if .trg_type != I80_HW_TRG. So there is
no point to leave a set for unused fields.

We can latter add those one HW trigger support is fixed for Exynos5420.

> Thanks,
> Inki Dae
> 
>>  };
>>  
>>  struct fimd_context {
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

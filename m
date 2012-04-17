From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 13:45:37 +0530
Subject: [PATCH 06/12] rtc-s3c: Fix breakage introduced by S3C2443/S3C2416
 support
In-Reply-To: <CAH9JG2V=5v0hp9rcynywcHYnrPUqN0XrS_hOcU-uY=FkNJ0O9g@mail.gmail.com>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-7-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2V=5v0hp9rcynywcHYnrPUqN0XrS_hOcU-uY=FkNJ0O9g@mail.gmail.com>
Message-ID: <CAJuYYwR14_wxBswzkVcObWAEDFqDXyi751gmiHyJNW+rA0JcQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 12:00, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> It's already merged with different patch,

This is a repost of the patch from Heiko Stuebner which would be
required to fix compilation issue for rtc driver. I think you are
referring to that patch but it is not merged yet. So I am reposting it
with this series.

Thanks,
Thomas.

>
> #ifdef CONFIG_OF
> static const struct of_device_id s3c_rtc_dt_match[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.compatible = "samsung,s3c2410-rtc",
> ? ? ? ? ? ? ? ?.data = &s3c_rtc_drv_data_array[TYPE_S3C2410],
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.compatible = "samsung,s3c2416-rtc",
> ? ? ? ? ? ? ? ?.data = &s3c_rtc_drv_data_array[TYPE_S3C2416],
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.compatible = "samsung,s3c2443-rtc",
> ? ? ? ? ? ? ? ?.data = &s3c_rtc_drv_data_array[TYPE_S3C2443],
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.compatible = "samsung,s3c6410-rtc",
> ? ? ? ? ? ? ? ?.data = &s3c_rtc_drv_data_array[TYPE_S3C64XX],
> ? ? ? ?},
> ? ? ? ?{},
> };
> MODULE_DEVICE_TABLE(of, s3c_rtc_dt_match);
> #else
> #define s3c_rtc_dt_match NULL
> #endif
>
> Thank you,
> Kyungmin Park
>
> On 4/17/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> From: Heiko Stuebner <heiko@sntech.de>
>>
>> Commits 7006ee4f (rtc-s3c: make room for more variants in devicetree block)
>> and 6c0a2365 (rtc-s3c: add variants for S3C2443 and S3C2416)
>> introduced build-failures with enabled CONFIG_USE_OF option.
>>
>> This patch fixes missing "," in s3c_rtc_dt_match and wrong handling of
>> the of_device_id.data property.
>>
>> Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> ?drivers/rtc/rtc-s3c.c | ? 18 +++++++++---------
>> ?1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
>> index 9ccea13..c792b6d 100644
>> --- a/drivers/rtc/rtc-s3c.c
>> +++ b/drivers/rtc/rtc-s3c.c
>> @@ -449,7 +449,7 @@ static inline int s3c_rtc_get_driver_data(struct
>> platform_device *pdev)
>> ? ? ? if (pdev->dev.of_node) {
>> ? ? ? ? ? ? ? const struct of_device_id *match;
>> ? ? ? ? ? ? ? match = of_match_node(s3c_rtc_dt_match, pdev->dev.of_node);
>> - ? ? ? ? ? ? return match->data;
>> + ? ? ? ? ? ? return (int)match->data;
>> ? ? ? }
>> ?#endif
>> ? ? ? return platform_get_device_id(pdev)->driver_data;
>> @@ -667,17 +667,17 @@ static int s3c_rtc_resume(struct platform_device
>> *pdev)
>> ?#ifdef CONFIG_OF
>> ?static const struct of_device_id s3c_rtc_dt_match[] = {
>> ? ? ? {
>> - ? ? ? ? ? ? .compatible = "samsung,s3c2410-rtc"
>> - ? ? ? ? ? ? .data = TYPE_S3C2410,
>> + ? ? ? ? ? ? .compatible = "samsung,s3c2410-rtc",
>> + ? ? ? ? ? ? .data = (void *)TYPE_S3C2410,
>> ? ? ? }, {
>> - ? ? ? ? ? ? .compatible = "samsung,s3c2416-rtc"
>> - ? ? ? ? ? ? .data = TYPE_S3C2416,
>> + ? ? ? ? ? ? .compatible = "samsung,s3c2416-rtc",
>> + ? ? ? ? ? ? .data = (void *)TYPE_S3C2416,
>> ? ? ? }, {
>> - ? ? ? ? ? ? .compatible = "samsung,s3c2443-rtc"
>> - ? ? ? ? ? ? .data = TYPE_S3C2443,
>> + ? ? ? ? ? ? .compatible = "samsung,s3c2443-rtc",
>> + ? ? ? ? ? ? .data = (void *)TYPE_S3C2443,
>> ? ? ? }, {
>> - ? ? ? ? ? ? .compatible = "samsung,s3c6410-rtc"
>> - ? ? ? ? ? ? .data = TYPE_S3C64XX,
>> + ? ? ? ? ? ? .compatible = "samsung,s3c6410-rtc",
>> + ? ? ? ? ? ? .data = (void *)TYPE_S3C64XX,
>> ? ? ? },
>> ? ? ? {},
>> ?};
>> --
>> 1.6.6.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
>> in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>

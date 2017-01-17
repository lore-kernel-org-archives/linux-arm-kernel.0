From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 17 Jan 2017 13:44:18 +0900
Subject: [PATCH 06/12] pinctrl: samsung: Add missing initconst annotation
In-Reply-To: <20170116191400.ehm3ivkmz4csynvq@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064526eucas1p1e3064fad71a3ab8de34d306dec531b14@eucas1p1.samsung.com>
 <1484549107-5957-7-git-send-email-m.szyprowski@samsung.com>
 <20170116191400.ehm3ivkmz4csynvq@kozik-lap>
Message-ID: <CA+Ln22EsV1mKzM5WZ4gwD+C2Yy22aMwy7YNgi7P=2Jy03XXaSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-17 4:14 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Mon, Jan 16, 2017 at 07:45:01AM +0100, Marek Szyprowski wrote:
>> Exynos5433 support has been added in parallel to adding initconst
>> annotation to most of the init data structures, so add those
>> annotations also to Exynos5433 structures.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-exynos.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> index bf753a596209..70b94ad10cc1 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> @@ -1266,7 +1266,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>  };
>>
>>  /* pin banks of exynos5433 pin-controller - ALIVE */
>> -static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
>> +static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
>>       EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
>> @@ -1279,28 +1279,28 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>  };
>
> Your change is aligned with existing code... but after I started to look
> into it I think this should not be initconst.
>
> The pin_banks (initconst) are referenced in pin_ctrl (initconst) which
> is referenced in samsung_pinctrl_dt_match (NOT initconst). The dt_match
> then is used in samsung_pinctrl_driver (for obvious reasons not
> initconst).
>
> We suppress the bind so this looks safe - this data should not be ever used
> after init - but it is not correct strictly speaking.
>
> Let's imagine some weird future platform which will use DT overlays with
> pinctrl. I think the overlays could affect the tree after the init
> stage.

I think it's not very realistic to have a Samsung on-SoC pin
controller in an overlay. AFAIR we already assume in several places
that this driver fully initializes in init stage, so we can save some
memory by discarding this data

Still, I guess we could add some measure to make sure nothing attempts
to probe this driver after the data is discarded.

Best regards,
Tomasz

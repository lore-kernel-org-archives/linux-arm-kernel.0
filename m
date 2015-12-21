From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 21 Dec 2015 14:51:14 +0800
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <1450451196.19539.9.camel@mtksdaap41>
References: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
 <1450451196.19539.9.camel@mtksdaap41>
Message-ID: <CAGS+omCDxj_wMDiAiywSv4hAtq6E9vm+CxgG8gs1TmrrS499mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:06 PM, Yingjoe Chen
<yingjoe.chen@mediatek.com> wrote:
> On Fri, 2015-12-18 at 12:21 +0800, Daniel Kurtz wrote:
>> Move pinctrl initialization earlier in boot so that real devices can find
>> their pctldev without probe deferring.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>>  drivers/pinctrl/mediatek/pinctrl-mt6397.c | 2 +-
>>  drivers/pinctrl/mediatek/pinctrl-mt8127.c | 2 +-
>>  drivers/pinctrl/mediatek/pinctrl-mt8135.c | 2 +-
>>  drivers/pinctrl/mediatek/pinctrl-mt8173.c | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
>> index f9751ae..a3780d4 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
>> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
>> @@ -70,7 +70,7 @@ static int __init mtk_pinctrl_init(void)
>>       return platform_driver_register(&mtk_pinctrl_driver);
>>  }
>>
>> -module_init(mtk_pinctrl_init);
>> +arch_initcall(mtk_pinctrl_init);
>
>
> MT6397 is PMIC, which depends on pwrap on main AP to work. Since
> pmic-wrap itself is module_platform_driver, I think it make sense to
> keep this one as module_init. Maybe adding a comment to explain why it
> is different from others will help.

I interpret this the other way - I think that since the PMIC wrapper
provides a bus required for the system PMIC it should also be a
builtin and use arch_initcall.

WDYT?

-Dan

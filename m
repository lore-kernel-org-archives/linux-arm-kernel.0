From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 27 Jan 2012 01:37:05 +0200
Subject: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
In-Reply-To: <20120126231921.GA29812@atomide.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
 <20120126231921.GA29812@atomide.com>
Message-ID: <CANOLnOPSwj-swMYR8CmFOf-Y0GWvdN-BQtneX4WLv87FwWTbtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 1:19 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [111217 16:03]:
>> hsmmc23_before_set_reg() can set MMCSDIO2ADPCLKISEL bit, which
>> enables internal clock for MMC2. Currently this function is also called
>> by code handling MMC3, and if .internal_clock is set in platform data
>> (by default it currently is), it will set MMCSDIO2ADPCLKISEL for MMC2
>> instead of MMC3 (MMC3 doesn't have such bit so nothing actually needs to
>> be done). This breaks 2nd SD slot on pandora.
>>
>> Fix this by changing hsmmc23_before_set_reg() to only handle MMC2.
>> Note that this removes .remux() call for MMC3, but no board currently
>> needs it and it's also not called for MMC4 and MMC5.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> applies both on mainline and hsmmc branch.
>>
>> ?arch/arm/mach-omap2/hsmmc.c | ? ?7 +++----
>> ?1 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
>> index f4a1020..d90ac08 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -171,7 +171,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
>> ? ? ? }
>> ?}
>>
>> -static void hsmmc23_before_set_reg(struct device *dev, int slot,
>> +static void hsmmc2_before_set_reg(struct device *dev, int slot,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int power_on, int vdd)
>> ?{
>> ? ? ? struct omap_mmc_platform_data *mmc = dev->platform_data;
>
> This hunk above changing the function name seems to be a typo?

No it's not, this function is changing MMC2 clock source and is no
longer called for MMC3 after this patch (the call for MMC3 was the
problem), so it loses hsmmc23 name.


>> @@ -378,14 +378,13 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>> ? ? ? ? ? ? ? ? ? ? ? c->caps &= ~MMC_CAP_8_BIT_DATA;
>> ? ? ? ? ? ? ? ? ? ? ? c->caps |= MMC_CAP_4_BIT_DATA;
>> ? ? ? ? ? ? ? }
>> - ? ? ? ? ? ? /* FALLTHROUGH */
>> - ? ? case 3:
>> ? ? ? ? ? ? ? if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
>> ? ? ? ? ? ? ? ? ? ? ? /* off-chip level shifting, or none */
>> - ? ? ? ? ? ? ? ? ? ? mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
>> + ? ? ? ? ? ? ? ? ? ? mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
>> ? ? ? ? ? ? ? ? ? ? ? mmc->slots[0].after_set_reg = NULL;
>> ? ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? break;
>> + ? ? case 3:
>> ? ? ? case 4:
>> ? ? ? case 5:
>> ? ? ? ? ? ? ? mmc->slots[0].before_set_reg = NULL;
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

-- 
Gra?vydas

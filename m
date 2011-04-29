From: niej0001@gmail.com (Jun Nie)
Date: Fri, 29 Apr 2011 10:13:00 +0800
Subject: [PATCH v2 1/3] ARM: mmp: add pxa910 mmc resource
In-Reply-To: <BANLkTinZfCzrM0+WomZ4cS2mkQRkty9qYA@mail.gmail.com>
References: <BANLkTi=XLp6hZ3H5rM6G32jhibz4xQo-Vg@mail.gmail.com>
	<20110428091110.GO17290@n2100.arm.linux.org.uk>
	<BANLkTinZfCzrM0+WomZ4cS2mkQRkty9qYA@mail.gmail.com>
Message-ID: <BANLkTikePbf43ffyCdQzNM0kyTo6tYLDFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/28 Eric Miao <eric.y.miao@gmail.com>:
> On Thu, Apr 28, 2011 at 5:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Apr 21, 2011 at 09:56:53AM +0800, Jun Nie wrote:
>>> +static inline int pxa910_add_sdhost(int id, struct sdhci_pxa_platdata *data)
>>> +{
>>> + ? ? struct pxa_device_desc *d = NULL;
>>> +
>>> + ? ? switch (id) {
>>> + ? ? case 0: d = &pxa910_device_sdh0; break;
>>> + ? ? case 1: d = &pxa910_device_sdh1; break;
>>> + ? ? case 2: d = &pxa910_device_sdh2; break;
>>> + ? ? default:
>>> + ? ? ? ? ? ? return -EINVAL;
>>> + ? ? }
>>> +
>>> + ? ? return pxa_register_device(d, data, sizeof(*data));
>>> +}
>>
>> How about:
>>
>> static inline int pxa910_add_sdhost(struct pxa_device_desc *dev,
>> ? ? ? ?struct sdhci_pxa_platdata *data)
>> {
>> ? ? ? ?return pxa_register_device(dev, data, sizeof(*data));
>> }
>>
>> #define pxa910_add_sdhost0(data) pxa910_add_sdhost(&pxa910_device_sdh0, data)
>> #define pxa910_add_sdhost1(data) pxa910_add_sdhost(&pxa910_device_sdh1, data)
>> #define pxa910_add_sdhost2(data) pxa910_add_sdhost(&pxa910_device_sdh2, data)
>>
>> instead - which seems more sane if you're going to call the function with
>> constant ID values.
>>
>
> Indeed. Better to revise the original code as well.
>

I am thinking to move QUIRKs into this function for it is SOC
specific, not board specific. Another item I want to move is bus
timing adjustment register setting API, which is for clock fine tune
and have different address/detail definition for different PXAs.
Zhangfei is preparing driver code for timing register setting.
How do you think about below change?

@@ -110,6 +110,8 @@ static inline int pxa910_add_sdh(int id, struct
sdhci_pxa_platdata *data)
                case 2: d = &pxa910_device_sdh2; break;
                default:
                           return -EINVAL;
        }

+       data->quirks    = SDHCI_QUIRK_BROKEN_ADMA,
+       data->soc_set_timing            = pxa910_sdh_specific_ctrl,
        return pxa_register_device(d, data, sizeof(*data));
 }

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index d616d09..fdd3457 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -1534,13 +1534,11 @@ static void mmc2_set_ops(struct sdhci_pxa *pxa)

 /* MMC0 controller for SD-MMC */
 static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc0 = {
-       .quirks                 = SDHCI_QUIRK_BROKEN_ADMA,
        .max_speed              = 48000000,
-       .soc_set_timing         = pxa910_sdh_specific_ctrl,
 };

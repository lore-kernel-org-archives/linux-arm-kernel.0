From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 6 Dec 2017 13:03:59 +0100
Subject: [RESEND PATCH 4/4] drm/meson: Add missing VPU init
In-Reply-To: <151256172859.3497.16672223686685414318@mail.alporthouse.com>
References: <1512561268-29806-1-git-send-email-narmstrong@baylibre.com>
 <1512561268-29806-5-git-send-email-narmstrong@baylibre.com>
 <151256172859.3497.16672223686685414318@mail.alporthouse.com>
Message-ID: <50101688-72c0-565e-bc15-9c229fd1a167@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2017 13:02, Chris Wilson wrote:
> Quoting Neil Armstrong (2017-12-06 11:54:28)
>> The VPU init misses these configurations values.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c       | 9 +++++++++
>>  drivers/gpu/drm/meson/meson_registers.h | 4 ++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index 3b804fd..f9ad0e9 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -151,6 +151,14 @@ static struct regmap_config meson_regmap_config = {
>>         .max_register   = 0x1000,
>>  };
>>  
>> +static void meson_vpu_init(struct meson_drm *priv)
>> +{
>> +       writel_relaxed(0x210000, priv->io_base + _REG(VPU_RDARB_MODE_L1C1));
>> +       writel_relaxed(0x10000, priv->io_base + _REG(VPU_RDARB_MODE_L1C2));
>> +       writel_relaxed(0x900000, priv->io_base + _REG(VPU_RDARB_MODE_L2C1));
>> +       writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>> +}
> 
>> diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
>> index 2847381..bca8714 100644
>> --- a/drivers/gpu/drm/meson/meson_registers.h
>> +++ b/drivers/gpu/drm/meson/meson_registers.h
>> @@ -1363,6 +1363,10 @@
>>  #define VPU_PROT3_STAT_1 0x277a
>>  #define VPU_PROT3_STAT_2 0x277b
>>  #define VPU_PROT3_REQ_ONOFF 0x277c
>> +#define VPU_RDARB_MODE_L1C1 0x2790
>> +#define VPU_RDARB_MODE_L1C2 0x2799
> 
> Hmm, not naturally aligned for writel. Is the register width correct,
> address correct, or this really is an unaligned iowrite?

The registers are aligned with the documentation, then are used with the _REG() macro
to align them with the bus (on top of the file).

Neil

> 
>> +#define VPU_RDARB_MODE_L2C1 0x279d
>> +#define VPU_WRARB_MODE_L2C1 0x27a2
> 
> Similarly,
> -Chris
> 

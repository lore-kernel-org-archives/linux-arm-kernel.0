From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 24 Mar 2017 14:27:24 +0800
Subject: [linux-sunxi] [PATCH v4 3/8] phy: sun4i-usb: add PHYCTL offset
 for H3 SoC
In-Reply-To: <CAGb2v65NHgDDPGChR4rg28NS1tuj2RZ9ERrQz2cSa_haZLypXA@mail.gmail.com>
References: <20170319161951.55834-1-icenowy@aosc.xyz>
 <20170319161951.55834-4-icenowy@aosc.xyz>
 <CAGb2v65NHgDDPGChR4rg28NS1tuj2RZ9ERrQz2cSa_haZLypXA@mail.gmail.com>
Message-ID: <1157651490336844@web12m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



24.03.2017, 11:05, "Chen-Yu Tsai" <wens@csie.org>:
> On Mon, Mar 20, 2017 at 12:19 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
>> ?The config structure of H3 in phy-sun4i-usb driver have the PHYCTL
>> ?register offset missing.
>>
>> ?Add it. Because it's a SoC after A33, its PHYCTL offset should be 0x10.
>
> You are implying that all SoCs after A33 have PHYCTL at 0x10.
>
> This is not true. As the A83T, which was released after the A33, has
> PHYCTL at the old offset.

No, in Allwinner's BSP A83T is using also PHYCTL at 0x10.

The code in linux-3.4/drivers/usb/sunxi_usb/include/sunxi_usb_bsp.c is
```
#if defined (CONFIG_ARCH_SUN8IW5) || defined (CONFIG_ARCH_SUN8IW6) || defined (CONFIG_ARCH_SUN8IW9) || defined (CONFIG_ARCH_SUN8IW8) || defined (CONFIG_ARCH_SUN8IW7)
#define  USBPHYC_REG_o_PHYCTL		    0x0410
#else
#define  USBPHYC_REG_o_PHYCTL		    0x0404
#endif
```

In linux-3.10/drivers/usb/sunxi_usb/include/sunxi_usb_bsp.c is
```
#if defined (CONFIG_ARCH_SUN50I) || defined (CONFIG_ARCH_SUN8IW10) || defined (CONFIG_ARCH_SUN8IW11)
#define  USBPHYC_REG_o_PHYCTL		    0x0410
#else
#define  USBPHYC_REG_o_PHYCTL		    0x0404
#endif
```

So sun50i* and sun50iw5~w11 all use PHYCTL at 0x10.

>
> Just state that H3 has PHYCTL at 0x10.
>
> ChenYu
>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?---
>> ?New patch in v4.
>>
>> ??drivers/phy/phy-sun4i-usb.c | 1 +
>> ??1 file changed, 1 insertion(+)
>>
>> ?diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> ?index 62b4d25448c6..a650f283f6ff 100644
>> ?--- a/drivers/phy/phy-sun4i-usb.c
>> ?+++ b/drivers/phy/phy-sun4i-usb.c
>> ?@@ -821,6 +821,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
>> ?????????.num_phys = 4,
>> ?????????.type = sun8i_h3_phy,
>> ?????????.disc_thresh = 3,
>> ?+ .phyctl_offset = REG_PHYCTL_A33,
>> ?????????.dedicated_clocks = true,
>> ?????????.enable_pmu_unk1 = true,
>> ??};
>> ?--
>> ?2.12.0
>>
>> ?--
>> ?You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> ?To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> ?For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

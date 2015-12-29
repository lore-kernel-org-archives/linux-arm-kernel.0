From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 29 Dec 2015 12:23:58 +0200
Subject: OMAP display kconfig options changing
In-Reply-To: <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <56741FA9.3080607@ti.com> <20151218160514.GK23396@atomide.com>
 <567430DB.4000507@ti.com>
 <CABxcv==VKi5jJ7=tEBe5fiPUpqpmaBd7C=t+_JohdXLA7eMR2Q@mail.gmail.com>
Message-ID: <56825F3E.5070602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier, Tony,

On 22/12/15 23:18, Javier Martinez Canillas wrote:

>> But if the userspace is using any omapfb specific apps, then yes, update
>> is necessary.
>>
> 
> Yes but these people should have a migration plan anyways since omapfb
> (and fbdev in general) is going away right?

Well, I would guess most people don't know/care about that.

>> Ok. I think it's then best that I just update the defconfig to enable
>> omapfb as modules, as it is currently.
>>
> 
> In that case I think you should squash the defconfig changes with
> commit ("70ba4e05531f omapfb/displays: change CONFIG_DISPLAY_* to
> CONFIG_FB_OMAP2_*") to maintain bisectability.

Here's the diff to change the defconfig to enable the same items as before:

diff --git a/arch/arm/configs/omap2plus_defconfig
b/arch/arm/configs/omap2plus_defconfig
index c5e1943e5427..b9581f1f0536 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -290,24 +290,23 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
-CONFIG_OMAP2_DSS=m
-CONFIG_OMAP5_DSS_HDMI=y
-CONFIG_OMAP2_DSS_SDI=y
-CONFIG_OMAP2_DSS_DSI=y
+CONFIG_FB_OMAP5_DSS_HDMI=y
+CONFIG_FB_OMAP2_DSS_SDI=y
+CONFIG_FB_OMAP2_DSS_DSI=y
 CONFIG_FB_OMAP2=m
-CONFIG_DISPLAY_ENCODER_TFP410=m
-CONFIG_DISPLAY_ENCODER_TPD12S015=m
-CONFIG_DISPLAY_CONNECTOR_DVI=m
-CONFIG_DISPLAY_CONNECTOR_HDMI=m
-CONFIG_DISPLAY_CONNECTOR_ANALOG_TV=m
-CONFIG_DISPLAY_PANEL_DPI=m
-CONFIG_DISPLAY_PANEL_DSI_CM=m
-CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=m
-CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02=m
-CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=m
-CONFIG_DISPLAY_PANEL_TPO_TD028TTEC1=m
-CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1=m
-CONFIG_DISPLAY_PANEL_NEC_NL8048HL11=m
+CONFIG_FB_OMAP2_ENCODER_TFP410=m
+CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
+CONFIG_FB_OMAP2_CONNECTOR_DVI=m
+CONFIG_FB_OMAP2_CONNECTOR_HDMI=m
+CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
+CONFIG_FB_OMAP2_PANEL_DPI=m
+CONFIG_FB_OMAP2_PANEL_DSI_CM=m
+CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM=m
+CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=m
+CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=m
+CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1=m
+CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1=m
+CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y

Tony, the diff above looks like something that's safe to merge via fbdev
tree. The context contains only display related configs. Is it ok if I
squash the above change to my series to keep bisectability?

> Alternatively, the current panel and encoders Kconfig symbols could
> remain for omapfb since that's the current ones used in
> omap2plus_defconfig where omapfb is the default and have new Kconfig
> symbols for omapdrm (i.e: CONFIG_DRM_OMAP_ENCODER_TFP410).

I want to change the config symbols, as the current ones are too generic
(e.g. CONFIG_DISPLAY_PANEL_DPI doesn't mention OMAP anywhere). I think
this is a good time to change them for omapfb. But this is probably a
good time to change them for omapdrm also, so I think I'll add that change.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151229/8458eaa2/attachment-0001.sig>

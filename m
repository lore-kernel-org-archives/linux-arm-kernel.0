From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Nov 2015 15:45:34 -0800
Subject: [PATCH v9 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <20151104011348.GL7274@google.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446083918-30809-1-git-send-email-ykk@rock-chips.com>
 <20151103043827.GA17261@localhost>
 <563955E6.7000905@rock-chips.com>
 <20151104011348.GL7274@google.com>
Message-ID: <20151105234534.GA77825@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A few updates:

On Tue, Nov 03, 2015 at 05:13:48PM -0800, Brian Norris wrote:
> On Wed, Nov 04, 2015 at 08:48:38AM +0800, Yakir Yang wrote:
> > On 11/03/2015 12:38 PM, Brian Norris wrote:
> > >On Thu, Oct 29, 2015 at 09:58:38AM +0800, Yakir Yang wrote:
> > >(FYI, I came across this by inspection when comparing Heiko's
> > >'somewhat-stable' branch [1] with this series. The former brings up eDP
> > >fine on veyron-jaq, whereas this one doesn't yet, even with the above
> > >change. Still debugging the issue.)

Some time after the above comment, I managed to kill the panel on my
Jaq :( I think the wiring around the hinge was a bit flaky, and it
finally went out for good.

> > Hmm... I'm not sure whether your eDP screen have the hotplug signal, so I
> 
> I believe hotplug is hooked up but...
> 
> > think you can try to add "analogix,force-hpd" flag into
> > rk3288-veyron-jaq.dts
> > 
> > &edp {
> >     analogix,need-force-hpd;
> > }
> 
> ...already tried, just in case. No luck.

However, now when testing a different Jaq device, now this series +
Heiko's DTS updates + the "analogix,force-hpd" (i.e., [1]) works fine,
modulo a few log warnings, some of which are probably expected (for
instance, I believe the EDID is known not-so-helpful). Snippets:

[    3.170176] rockchip-dp ff970000.dp: AUX CH command reply failed!
[    3.178058] rockchip-dp ff970000.dp: AUX CH command reply failed!
[    3.184166] rockchip-dp ff970000.dp: unable to handle edid

and later:

[    3.953300] rockchip-dp ff970000.dp: EDID data does not include any extensions.
[    3.966731] rockchip-dp ff970000.dp: EDID data does not include any extensions.
[    3.979409] rockchip-dp ff970000.dp: EDID data does not include any extensions.
[    3.998730] rockchip-dp ff970000.dp: Link Training Clock Recovery success
[    4.007046] rockchip-dp ff970000.dp: Link Training success!
[    4.115040] rockchip-dp ff970000.dp: Timeout of video streamclk ok
[    4.121211] rockchip-dp ff970000.dp: unable to config video
[    4.127616] rockchip-dp ff970000.dp: EDID data does not include any extensions.


So, I'll chalk that earlier failure up to a hardware failure (or
possibly a still yet-undiagnosed hardware difference; my new Jaq has
some small differences from the previous unit).

Also, it's still not real clear why HPD isn't working upstream (and we
have to use the "force-hpd" property), when it appears to work on our
downstream Chrome OS tree.

Finally, I'll leave you with some small bits I've noticed from exploring
this issue on Jaq:

 * The Chrome OS driver for this IP has a much longer timeout in (the
   equivalent of) analogix_dp_detect_hpd; it polls in 10-20 ms intervals
   (rather than 10-11 us) and takes something around 60 to 120 ms to
   notice the panel.
 * AFAICT, the Chrome OS driver never actually used the HPD interrupt;
   it was only polling the HPD status bit. So I can't claim that the
   functionality that Yakir is supporting here has ever been tested on
   these platforms. (Now, I'm not sure this is extremely important,
   since we still can fall back to polled status checks; see
   drm_kms_helper_poll_init().)

That's all I've got for now.

Regards,
Brian

[1] https://github.com/mmind/linux-rockchip/commits/tmp/analogixdp-veyron

plus this diff:

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 5c97e3153526..e77ae4c5531e 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -88,6 +88,18 @@
 	};
 };
 
+&backlight {
+	power-supply = <&backlight_regulator>;
+};
+
+&panel {
+	power-supply = <&panel_regulator>;
+};
+
+&edp {
+	analogix,need-force-hpd;
+};
+
 &rk808 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
index c82c22f3d0e1..994189f49db5 100644
--- a/drivers/phy/phy-rockchip-dp.c
+++ b/drivers/phy/phy-rockchip-dp.c
@@ -22,7 +22,7 @@
 
 #define GRF_SOC_CON12                           0x0274
 
-#define GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK   BIT(4)
+#define GRF_EDP_REF_CLK_SEL_INTER_HIWORD_MASK   BIT(20)
 #define GRF_EDP_REF_CLK_SEL_INTER               BIT(4)
 
 #define GRF_EDP_PHY_SIDDQ_HIWORD_MASK           BIT(21)

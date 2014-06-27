From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 21:48:27 +0100
Subject: HDMI and LVDS on mx6
In-Reply-To: <CAOMZO5C8n6tZbmoN_M_GB-Aq_1qDRensM7wi1_MSTSxJFFtwUw@mail.gmail.com>
References: <CAOMZO5C8n6tZbmoN_M_GB-Aq_1qDRensM7wi1_MSTSxJFFtwUw@mail.gmail.com>
Message-ID: <20140627204827.GR32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:35:58PM -0300, Fabio Estevam wrote:
> On mx6qsabresd we have LVDS and HDMI ports and with kernel 3.15 I had
> to disconnect/connect the HDMI cable in order to get both displays
> working.
> 
> I could workaround this by moving the LDB parent to a clock different
> than pll5.
> 
> Now with 3.16-rc1 the situation is even worse:
> 
> - Boot the kernel with HDMI cable connected: only LVDS is functional
> - Removing the HDMI cable causes LVDS to turn off
> - Connect HDMI cable, then LVDS turns on, but still no HDMI
> 
> I also tried moving the LDB parent to a clock different than pll5.,
> but it does not help in 3.16-rc1.

I don't know.  libdrm's modetest reports (with your patch to add lvds
support to the HB, and changing the ldb clock to the OTG PLL):

Encoders:
id      crtc    type    possible crtcs  possible clones
11      5       TMDS    0x00000003      0xffffffff
13      9       LVDS    0x00000003      0xffffffff

Connectors:
id      encoder status          type    size (mm)       modes   encoders
12      11      connected       HDMI-A  1280x720                21      11
  modes:
        name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot)
  1920x1080 50 1920 2448 2492 2640 1080 1084 1089 1125 flags: phsync, pvsync; type: preferred, driver
  1920x1080 60 1920 2008 2052 2200 1080 1084 1089 1125 flags: phsync, pvsync; type: driver
...
  props:
        1 EDID:
                flags: immutable blob
...
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
14      13      connected       LVDS    0x0             1       13
  modes:
        name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot)
  1024x768 60 1024 1064 1124 1344 768 775 785 806 flags: ; type: preferred, driver
  props:
        1 EDID:
                flags: immutable blob
...
CRTCs:
id      fb      pos     size
5       28      (0,0)   (1920x1080)
  1920x1080 50 1920 2448 2492 2640 1080 1084 1089 1125 flags: phsync, pvsync; type: preferred, driver
  props:
9       28      (0,0)   (1024x768)
  1024x768 60 1024 1064 1124 1344 768 775 785 806 flags: ; type: preferred, driver
  props:
...

The extracts from clk_summary:

    pll5_video                            1            1  1188000000          0
       pll5_post_div                      1            1   297000000          0
          pll5_video_div                  1            1   148500000          0
             ipu2_di1_pre_sel             0            0   148500000          0
                ipu2_di1_pre              0            0    74250000          0
                   ipu2_di1_sel           0            0    74250000          0
                      ipu2_di1            0            0    74250000          0
             ipu2_di0_pre_sel             0            0   148500000          0
                ipu2_di0_pre              0            0    49500000          0
                   ipu2_di0_sel           0            0    49500000          0
                      ipu2_di0            0            0    49500000          0
             ipu1_di1_pre_sel             0            0   148500000          0
                ipu1_di1_pre              0            0    49500000          0
             ipu1_di0_pre_sel             1            1   148500000          0
                ipu1_di0_pre              1            1   148500000          0
                   ipu1_di0_sel           1            1   148500000          0
                      ipu1_di0            1            1   148500000          0

    pll3_usb_otg                          5            6   480000000          0
       ldb_di1_sel                        1            1   480000000          0
          ldb_di1_div_3_5                 1            1   137142857          0
             ldb_di1_podf                 1            1    68571429          0
                ldb_di1                   1            1    68571429          0
                   ipu1_di1_sel           1            1    68571429          0
                      ipu1_di1            1            1    68571429          0

So it all looks as it should with your change.

In order to use the modetest program in libdrm, you need to update the
list of modules it looks for to be:

        char *modules[] = { "i915", "radeon", "nouveau", "vmwgfx", "omapdrm", "exynos", "armada-drm", "imx-drm" };

I'm hesitant to share my binary for that because of the numerous
different ARM EABIs, even if I did it probably wouldn't run for you.

The above dumps are after Xorg started up, and then shut down.
Ubuntu doesn't make it easy /not/ to boot into Xorg except by
package removal...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

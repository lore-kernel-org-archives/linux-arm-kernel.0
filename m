From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 29 Sep 2016 11:02:12 +0800
Subject: [PATCH v5 0/3] MT8173 HDMI 4K support
Message-ID: <1475118135-56780-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT8173 HDMI 4K support PATCH v5, based on 4.8-rc1.

In order to support HDMI 4K on MT8173,
we have to make some modifications.
1) Make sure that mtk_hdmi_send_infoframe is sent successfully.
2) Enhance the HDMI driving current to improve performance.
3) Make sure that pixel clock is 297MHz when resolution is 4K.

Changes since v4:
 - Update commit message and patch title.

Changes since v3:
 - Rebase to 4.8-rc1.
 - The valid range of tvdpll is 1G to 2G Hz, so, we Change the
   if statement of mode->clock to fit that and add a comment.

Changes since v2:
 - Remove the change about preparation for MT2701 support.

Changes since v1:
 - According to the suggestion from philipp, We use the new
   dpi0_sel rate set method.
 - calls clk_set_rate to set the dpi0_sel according to the
   pixel clock.
 - Remove the direct access to all the intermediate clock part.
 - Remove the intermediate tvdpll_d* clocks in dts.
 - According to suggestion from CK, we rename the clock parse
   function and remove it from mtk_dpi_conf struct.
 - Merges the hdmi Pll set rate for pixel clock greater than
   165MHz and smaller parts.

The PATCH depends on the following patch:
https://patchwork.kernel.org/patch/9262575/
(arm64: dts: mt8173: add mmsel clocks for 4K support)

Junzhi Zhao (3):
  drm/mediatek: do mtk_hdmi_send_infoframe after HDMI clock enable
  drm/mediatek: enhance the HDMI driving current
  drm/mediatek: modify the factor to make the pll_rate set in the 1G-2G
    range

 drivers/gpu/drm/mediatek/mtk_dpi.c             |    9 +++--
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |   17 ++++++----
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |   42 +++++++++++++++++-------
 3 files changed, 48 insertions(+), 20 deletions(-)

-- 
1.7.9.5

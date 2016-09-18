From: ayaka@soulik.info (Randy Li)
Date: Sun, 18 Sep 2016 22:27:37 +0800
Subject: [RFC PATCH v2 0/2] adding panel claa070wp03xg support for exynos
Message-ID: <1474208859-10045-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to add LCD panel with LVDS interface for exynos 4412 topeet
itop. That board using a bridge chip to convert the parallel RGB signal
to LVDS signal. I could make a fb0 node appear in system now. But I can't
make it work yet. redirecting the urandom to fb0 won't make anything
change in panel.

The timing for this panel is calcuated from Hyundai T7, but it looks
different to the vendor's kernel. But those timings settings is disabled, so
I decided not to use it.

I attach them as references:
/* From Hyundai T7 */
static struct s3cfb_lcd hs101h = {
	.width = 1280,
	.height = 800,
	.bpp = 24,
	.freq = 60,

	.timing = {
		.h_fp = 49,
		.h_bp = 17,
		.h_sw = 33,
		.v_fp = 4,
		.v_fpe = 1,
		.v_bp = 15,
		.v_bpe = 1,
		.v_sw = 6,
	},

	.polarity = {
		.rise_vclk = 0,
		.inv_hsync = 1,
		.inv_vsync = 1,
		.inv_vden = 0,
	},
};
/* From vendor */
static struct s3cfb_lcd dummy_mipi_lcd = {                                                                                   
	.width = 800,                                                                                 
        .height = 1280,                                         
        .bpp = 24,                                                                             
        .freq = 60,                                                                                                 
        .timing = {                                                                                                          
                .h_fp = 16,                                                                                            
                .h_bp = 140,                                                                                        
                .h_sw = 14,                                                                                             
                .v_fp = 8,                                                                                               
                //.v_fpe = 2,                                                                                                 
                .v_bp = 4,                                                                                               
                //.v_bpe = 1,                                                                                                 
                .v_sw = 4,                                                                                              
                .cmd_allow_len = 4,                                                                                           
        },                                                                                                                    
                                                                                                                              
        .polarity = {                                                                                                         
                .rise_vclk = 0,                                                                                          
                .inv_hsync = 0,                                                                                               
                .inv_vsync = 0,                                                                                               
                .inv_vden = 0,                                                                                                
        },                                                                                                                    
}


Randy Li (2):
  ARM: dts: samsung: add rga-lvds panel in itop elite
  drm/panel: Add support for Chunghwa CLAA070WP03XG panel

 .../display/panel/chunghwa,claa070wp03xg.txt       |  7 +++
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 54 +++++++++++++++++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 27 +++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/chunghwa,claa070wp03xg.txt

-- 
2.7.4

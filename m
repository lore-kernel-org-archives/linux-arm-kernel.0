From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Apr 2014 12:23:37 +0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140311034607.GA26502@S2101-09.ap.freescale.net>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
Message-ID: <20140407042334.GA28025@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 11:46:11AM +0800, Shawn Guo wrote:
> I just came across a couple problems when testing the series on
> my imx6dl-sabresd board in dual display case - HDMI + LVDS.  I tested it
> using Russell's branch below, which I believe has all the pieces put
> together.
> 
>   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
> 
> - When I enable HDMI and LVDS support in both kernel build and device
>   tree, HDMI seems working fine but LVDS color is corrupted quite badly.

Philipp,

Did you get any chance to reproduce this dual display issue?  Now it
shows on mainline kernel.

And I see another HDMI regression with my testing on mainline kernel.  I
can have my HDMI work at 1920x1080 with v3.14 kernel, but it can only
probes 1024x768 with the mainline today.  The Xorg.0.log are attached
below.  The hardware and user space are same, so I guess this is another
issue introduced by the recently kernel driver changes?

Shawn

mainline kernel
===============

[    20.606] (II) LoadModule: "modesetting"
[    20.607] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    20.609] (II) Module modesetting: vendor="X.Org Foundation"
[    20.609] 	compiled for 1.12.1.902, module version = 0.3.0
[    20.610] 	Module class: X.Org Video Driver
[    20.610] 	ABI class: X.Org Video Driver, version 12.0
[    20.610] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    20.610] (++) using VT number 7

[    20.624] (WW) Falling back to old probe method for modesetting
[    20.624] (II) modesetting(0): using default device
[    20.627] (II) modesetting(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    20.627] (==) modesetting(0): Depth 24, (==) framebuffer bpp 32
[    20.628] (==) modesetting(0): RGB weight 888
[    20.628] (==) modesetting(0): Default visual is TrueColor
[    20.628] (II) modesetting(0): ShadowFB: preferred NO, enabled NO
[    20.628] (II) modesetting(0): Output HDMI-0 has no monitor section
[    20.629] (II) modesetting(0): EDID for output HDMI-0
[    20.629] (II) modesetting(0): Printing probed modes for output HDMI-0
[    20.629] (II) modesetting(0): Modeline "1024x768"x60.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[    20.629] (II) modesetting(0): Modeline "800x600"x60.3   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz e)
[    20.629] (II) modesetting(0): Modeline "800x600"x56.2   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync (35.2 kHz e)
[    20.630] (II) modesetting(0): Modeline "848x480"x60.0   33.75  848 864 976 1088  480 486 494 517 +hsync +vsync (31.0 kHz e)
[    20.630] (II) modesetting(0): Modeline "640x480"x59.9   25.18  640 656 752 800  480 489 492 525 -hsync -vsync (31.5 kHz e)
[    20.630] (II) modesetting(0): Output HDMI-0 connected
[    20.630] (II) modesetting(0): Using exact sizes for initial modes
[    20.630] (II) modesetting(0): Output HDMI-0 using initial mode 1024x768
[    20.630] (II) modesetting(0): Using default gamma of (1.0, 1.0, 1.0) unless otherwise stated.
[    20.630] (==) modesetting(0): DPI set to (96, 96)

v3.14 kernel
============

[    20.214] (II) LoadModule: "modesetting"
[    20.215] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    20.217] (II) Module modesetting: vendor="X.Org Foundation"
[    20.217] 	compiled for 1.12.1.902, module version = 0.3.0
[    20.217] 	Module class: X.Org Video Driver
[    20.217] 	ABI class: X.Org Video Driver, version 12.0
[    20.217] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    20.217] (++) using VT number 7

[    20.240] (WW) Falling back to old probe method for modesetting
[    20.241] (II) modesetting(0): using default device
[    20.241] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[    20.244] (II) modesetting(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    20.244] (==) modesetting(0): Depth 24, (==) framebuffer bpp 32
[    20.244] (==) modesetting(0): RGB weight 888
[    20.244] (==) modesetting(0): Default visual is TrueColor
[    20.244] (II) modesetting(0): ShadowFB: preferred NO, enabled NO
[    20.282] (II) modesetting(0): Output HDMI-0 has no monitor section
[    20.329] (II) modesetting(0): EDID for output HDMI-0
[    20.330] (II) modesetting(0): Manufacturer: RAW  Model: 0  Serial#: 1
[    20.330] (II) modesetting(0): Year: 2012  Week: 6
[    20.330] (II) modesetting(0): EDID Version: 1.3
[    20.331] (II) modesetting(0): Digital Display Input
[    20.331] (II) modesetting(0): Indeterminate output size
[    20.331] (II) modesetting(0): Gamma: 2.20
[    20.331] (II) modesetting(0): No DPMS capabilities specified
[    20.331] (II) modesetting(0): Supported color encodings: RGB 4:4:4 YCrCb 4:4:4 
[    20.332] (II) modesetting(0): First detailed timing is preferred mode
[    20.332] (II) modesetting(0): redX: 0.636 redY: 0.349   greenX: 0.290 greenY: 0.589
[    20.332] (II) modesetting(0): blueX: 0.143 blueY: 0.080   whiteX: 0.313 whiteY: 0.329
[    20.332] (II) modesetting(0): Supported established timings:
[    20.333] (II) modesetting(0): 720x400 at 70Hz
[    20.333] (II) modesetting(0): 640x480 at 60Hz
[    20.333] (II) modesetting(0): 640x480 at 72Hz
[    20.333] (II) modesetting(0): 640x480 at 75Hz
[    20.333] (II) modesetting(0): 800x600 at 56Hz
[    20.334] (II) modesetting(0): 800x600 at 60Hz
[    20.334] (II) modesetting(0): 800x600 at 72Hz
[    20.334] (II) modesetting(0): 800x600 at 75Hz
[    20.334] (II) modesetting(0): 1024x768 at 60Hz
[    20.334] (II) modesetting(0): 1024x768 at 70Hz
[    20.334] (II) modesetting(0): 1024x768 at 75Hz
[    20.335] (II) modesetting(0): 1280x1024 at 75Hz
[    20.335] (II) modesetting(0): Manufacturer's mask: 1
[    20.335] (II) modesetting(0): Supported standard timings:
[    20.335] (II) modesetting(0): #0: hsize: 1920  vsize 1080  refresh: 60  vid: 49361
[    20.335] (II) modesetting(0): #1: hsize: 1680  vsize 1050  refresh: 60  vid: 179
[    20.336] (II) modesetting(0): #2: hsize: 1280  vsize 800  refresh: 60  vid: 129
[    20.336] (II) modesetting(0): #3: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
[    20.336] (II) modesetting(0): #4: hsize: 1280  vsize 960  refresh: 60  vid: 16513
[    20.336] (II) modesetting(0): #5: hsize: 1280  vsize 720  refresh: 60  vid: 49281
[    20.337] (II) modesetting(0): Supported detailed timing:
[    20.337] (II) modesetting(0): clock: 148.5 MHz   Image Size:  575 x 323 mm
[    20.337] (II) modesetting(0): h_active: 1920  h_sync: 2008  h_sync_end 2052 h_blank_end 2200 h_border: 0
[    20.337] (II) modesetting(0): v_active: 1080  v_sync: 1084  v_sync_end 1089 v_blanking: 1125 v_border: 0
[    20.337] (II) modesetting(0): Supported detailed timing:
[    20.338] (II) modesetting(0): clock: 85.5 MHz   Image Size:  575 x 323 mm
[    20.338] (II) modesetting(0): h_active: 1360  h_sync: 1424  h_sync_end 1536 h_blank_end 1792 h_border: 0
[    20.338] (II) modesetting(0): v_active: 768  v_sync: 771  v_sync_end 777 v_blanking: 795 v_border: 0
[    20.338] (II) modesetting(0): Ranges: V min: 50 V max: 76 Hz, H min: 30 H max: 80 kHz, PixClock max 165 MHz
[    20.339] (II) modesetting(0): Monitor name: TV
[    20.339] (II) modesetting(0): Supported detailed timing:
[    20.339] (II) modesetting(0): clock: 27.0 MHz   Image Size:  509 x 286 mm
[    20.339] (II) modesetting(0): h_active: 720  h_sync: 736  h_sync_end 798 h_blank_end 858 h_border: 0
[    20.339] (II) modesetting(0): v_active: 480  v_sync: 489  v_sync_end 495 v_blanking: 525 v_border: 0
[    20.340] (II) modesetting(0): Supported detailed timing:
[    20.340] (II) modesetting(0): clock: 27.0 MHz   Image Size:  509 x 286 mm
[    20.340] (II) modesetting(0): h_active: 720  h_sync: 732  h_sync_end 796 h_blank_end 864 h_border: 0
[    20.340] (II) modesetting(0): v_active: 576  v_sync: 581  v_sync_end 586 v_blanking: 625 v_border: 0
[    20.340] (II) modesetting(0): Supported detailed timing:
[    20.341] (II) modesetting(0): clock: 74.2 MHz   Image Size:  509 x 286 mm
[    20.341] (II) modesetting(0): h_active: 1920  h_sync: 2008  h_sync_end 2052 h_blank_end 2200 h_border: 0
[    20.341] (II) modesetting(0): v_active: 540  v_sync: 542  v_sync_end 547 v_blanking: 562 v_border: 0
[    20.341] (II) modesetting(0): Supported detailed timing:
[    20.341] (II) modesetting(0): clock: 74.2 MHz   Image Size:  509 x 286 mm
[    20.342] (II) modesetting(0): h_active: 1920  h_sync: 2448  h_sync_end 2492 h_blank_end 2640 h_border: 0
[    20.342] (II) modesetting(0): v_active: 540  v_sync: 542  v_sync_end 547 v_blanking: 562 v_border: 0
[    20.342] (II) modesetting(0): Number of EDID sections to follow: 1
[    20.342] (II) modesetting(0): EDID (in hex):
[    20.342] (II) modesetting(0): 	00ffffffffffff004837000001000000
[    20.343] (II) modesetting(0): 	06160103800000780ad7a5a2594a9624
[    20.343] (II) modesetting(0): 	145054afcf01d1c0b300810081808140
[    20.343] (II) modesetting(0): 	81c001010101023a801871382d40582c
[    20.343] (II) modesetting(0): 	45003f432100001a662150b051001b30
[    20.343] (II) modesetting(0): 	407036003f432100001e000000fd0032
[    20.344] (II) modesetting(0): 	4c1e5010000a202020202020000000fc
[    20.344] (II) modesetting(0): 	0054560a2020202020202020200a010e
[    20.344] (II) modesetting(0): 	020329f123097f074f90010203060715
[    20.344] (II) modesetting(0): 	161112130405141f830100006c030c00
[    20.344] (II) modesetting(0): 	1000b82dc0010101018c0ad08a20e02d
[    20.344] (II) modesetting(0): 	10103e9600fd1e110000188c0ad09020
[    20.345] (II) modesetting(0): 	4031200c405500fd1e11000018011d80
[    20.345] (II) modesetting(0): 	18711c1620582c2500fd1e1100009e01
[    20.345] (II) modesetting(0): 	1d80d0721c1620102c2580fd1e110000
[    20.345] (II) modesetting(0): 	9e00000000000000000000000000003e
[    20.345] (II) modesetting(0): EDID vendor "RAW", prod id 0
[    20.346] (II) modesetting(0): Using EDID range info for horizontal sync
[    20.347] (II) modesetting(0): Using EDID range info for vertical refresh
[    20.347] (II) modesetting(0): Printing DDC gathered Modelines:
[    20.347] (II) modesetting(0): Modeline "1920x1080"x0.0  148.50  1920 2008 2052 2200  1080 1084 1089 1125 +hsync -vsync (67.5 kHz eP)
[    20.347] (II) modesetting(0): Modeline "1360x768"x0.0   85.50  1360 1424 1536 1792  768 771 777 795 +hsync +vsync (47.7 kHz e)
[    20.347] (II) modesetting(0): Modeline "720x480"x0.0   27.00  720 736 798 858  480 489 495 525 -hsync -vsync (31.5 kHz e)
[    20.348] (II) modesetting(0): Modeline "720x576"x0.0   27.00  720 732 796 864  576 581 586 625 -hsync -vsync (31.2 kHz e)
[    20.348] (II) modesetting(0): Modeline "1920x1080i"x0.0   74.25  1920 2008 2052 2200  1080 1084 1094 1125 interlace +hsync +vsync (33.8 kHz e)
[    20.348] (II) modesetting(0): Modeline "1920x1080i"x0.0   74.25  1920 2448 2492 2640  1080 1084 1094 1125 interlace +hsync +vsync (28.1 kHz e)
[    20.348] (II) modesetting(0): Modeline "800x600"x0.0   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz e)
[    20.348] (II) modesetting(0): Modeline "800x600"x0.0   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync (35.2 kHz e)
[    20.349] (II) modesetting(0): Modeline "640x480"x0.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz e)
[    20.349] (II) modesetting(0): Modeline "640x480"x0.0   31.50  640 664 704 832  480 489 492 520 -hsync -vsync (37.9 kHz e)
[    20.349] (II) modesetting(0): Modeline "640x480"x0.0   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    20.349] (II) modesetting(0): Modeline "720x400"x0.0   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz e)
[    20.349] (II) modesetting(0): Modeline "1280x1024"x0.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz e)
[    20.350] (II) modesetting(0): Modeline "1024x768"x0.0   78.75  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz e)
[    20.350] (II) modesetting(0): Modeline "1024x768"x0.0   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync (56.5 kHz e)
[    20.350] (II) modesetting(0): Modeline "1024x768"x0.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[    20.350] (II) modesetting(0): Modeline "800x600"x0.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz e)
[    20.351] (II) modesetting(0): Modeline "800x600"x0.0   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync (48.1 kHz e)
[    20.351] (II) modesetting(0): Modeline "1920x1080"x60.0  172.80  1920 2040 2248 2576  1080 1081 1084 1118 -hsync +vsync (67.1 kHz e)
[    20.351] (II) modesetting(0): Modeline "1680x1050"x0.0  119.00  1680 1728 1760 1840  1050 1053 1059 1080 +hsync -vsync (64.7 kHz e)
[    20.351] (II) modesetting(0): Modeline "1280x800"x0.0   71.00  1280 1328 1360 1440  800 803 809 823 +hsync -vsync (49.3 kHz e)
[    20.351] (II) modesetting(0): Modeline "1280x1024"x0.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[    20.352] (II) modesetting(0): Modeline "1280x960"x0.0  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz e)
[    20.352] (II) modesetting(0): Modeline "1280x720"x60.0   74.48  1280 1336 1472 1664  720 721 724 746 -hsync +vsync (44.8 kHz e)
[    20.352] (II) modesetting(0): Modeline "1280x720"x0.0   74.25  1280 1390 1430 1650  720 725 730 750 +hsync +vsync (45.0 kHz e)
[    20.352] (II) modesetting(0): Modeline "1440x480i"x0.0   27.00  1440 1478 1602 1716  480 488 494 525 interlace -hsync -vsync (15.7 kHz e)
[    20.352] (II) modesetting(0): Modeline "1440x240"x0.0   27.00  1440 1478 1602 1716  240 244 247 262 -hsync -vsync (15.7 kHz e)
[    20.353] (II) modesetting(0): Modeline "1440x576i"x0.0   27.00  1440 1464 1590 1728  576 580 586 625 interlace -hsync -vsync (15.6 kHz e)
[    20.353] (II) modesetting(0): Modeline "1440x288"x0.0   27.00  1440 1464 1590 1728  288 290 293 312 -hsync -vsync (15.6 kHz e)
[    20.353] (II) modesetting(0): Modeline "1280x720"x0.0   74.25  1280 1720 1760 1980  720 725 730 750 +hsync +vsync (37.5 kHz e)
[    20.353] (II) modesetting(0): Modeline "1920x1080"x0.0   74.25  1920 2558 2602 2750  1080 1084 1089 1125 +hsync +vsync (27.0 kHz e)
[    20.354] (II) modesetting(0): Printing probed modes for output HDMI-0
[    20.354] (II) modesetting(0): Modeline "1920x1080"x60.0  148.50  1920 2008 2052 2200  1080 1084 1089 1125 +hsync -vsync (67.5 kHz eP)
[    20.354] (II) modesetting(0): Modeline "1920x1080"x60.0  148.50  1920 2008 2052 2200  1080 1084 1089 1125 +hsync +vsync (67.5 kHz e)
[    20.354] (II) modesetting(0): Modeline "1920x1080"x50.0  148.50  1920 2448 2492 2640  1080 1084 1089 1125 +hsync +vsync (56.2 kHz e)
[    20.354] (II) modesetting(0): Modeline "1920x1080"x59.9  148.35  1920 2008 2052 2200  1080 1084 1089 1125 +hsync +vsync (67.4 kHz e)
[    20.355] (II) modesetting(0): Modeline "1680x1050"x59.9  119.00  1680 1728 1760 1840  1050 1053 1059 1080 +hsync -vsync (64.7 kHz e)
[    20.355] (II) modesetting(0): Modeline "1280x1024"x75.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz e)
[    20.355] (II) modesetting(0): Modeline "1280x1024"x60.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[    20.355] (II) modesetting(0): Modeline "1280x960"x60.0  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz e)
[    20.356] (II) modesetting(0): Modeline "1360x768"x60.0   85.50  1360 1424 1536 1792  768 771 777 795 +hsync +vsync (47.7 kHz e)
[    20.356] (II) modesetting(0): Modeline "1280x800"x59.9   71.00  1280 1328 1360 1440  800 803 809 823 +hsync -vsync (49.3 kHz e)
[    20.356] (II) modesetting(0): Modeline "1280x720"x60.0   74.44  1280 1336 1472 1664  720 721 724 746 -hsync +vsync (44.7 kHz)
[    20.356] (II) modesetting(0): Modeline "1280x720"x60.0   74.25  1280 1390 1430 1650  720 725 730 750 +hsync +vsync (45.0 kHz e)
[    20.356] (II) modesetting(0): Modeline "1280x720"x50.0   74.25  1280 1720 1760 1980  720 725 730 750 +hsync +vsync (37.5 kHz e)
[    20.357] (II) modesetting(0): Modeline "1280x720"x59.9   74.18  1280 1390 1430 1650  720 725 730 750 +hsync +vsync (45.0 kHz e)
[    20.357] (II) modesetting(0): Modeline "1024x768"x75.1   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.1 kHz e)
[    20.357] (II) modesetting(0): Modeline "1024x768"x70.1   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync (56.5 kHz e)
[    20.357] (II) modesetting(0): Modeline "1024x768"x60.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[    20.357] (II) modesetting(0): Modeline "800x600"x72.2   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync (48.1 kHz e)
[    20.358] (II) modesetting(0): Modeline "800x600"x75.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz e)
[    20.358] (II) modesetting(0): Modeline "800x600"x60.3   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz e)
[    20.358] (II) modesetting(0): Modeline "800x600"x56.2   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync (35.2 kHz e)
[    20.358] (II) modesetting(0): Modeline "720x576"x50.0   27.00  720 732 796 864  576 581 586 625 -hsync -vsync (31.2 kHz e)
[    20.358] (II) modesetting(0): Modeline "848x480"x60.0   33.75  848 864 976 1088  480 486 494 517 +hsync +vsync (31.0 kHz e)
[    20.359] (II) modesetting(0): Modeline "720x480"x60.0   27.03  720 736 798 858  480 489 495 525 -hsync -vsync (31.5 kHz e)
[    20.359] (II) modesetting(0): Modeline "720x480"x59.9   27.00  720 736 798 858  480 489 495 525 -hsync -vsync (31.5 kHz e)
[    20.359] (II) modesetting(0): Modeline "640x480"x75.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz e)
[    20.359] (II) modesetting(0): Modeline "640x480"x72.8   31.50  640 664 704 832  480 489 491 520 -hsync -vsync (37.9 kHz e)
[    20.359] (II) modesetting(0): Modeline "640x480"x60.0   25.20  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    20.360] (II) modesetting(0): Modeline "640x480"x59.9   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    20.360] (II) modesetting(0): Modeline "640x480"x59.9   25.18  640 656 752 800  480 489 492 525 -hsync -vsync (31.5 kHz e)
[    20.360] (II) modesetting(0): Modeline "720x400"x70.1   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz e)
[    20.360] (II) modesetting(0): Output HDMI-0 connected
[    20.360] (II) modesetting(0): Using exact sizes for initial modes
[    20.361] (II) modesetting(0): Output HDMI-0 using initial mode 1920x1080
[    20.361] (II) modesetting(0): Using default gamma of (1.0, 1.0, 1.0) unless otherwise stated.
[    20.361] (==) modesetting(0): DPI set to (96, 96)

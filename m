From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 12 Feb 2015 01:55:08 +0100
Subject: [PATCH RFC 0/5] ARM: dts: zynq: pinctrl, LED, USB for Parallella
Message-ID: <1423702513-4032-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is based on linux-next plus Michal's aliases patch.
https://patchwork.kernel.org/patch/5812541/

Patch 2 adds pinctrl for the Parallella board. No such information was 
visible downstream, so this is based on S?ren's patch and the schematic 
plus some testing. In particular the Ethernet voltage level seems to be 
different from the other Zynq boards upstream (io-standard 1 vs. 4).

Patch 3 adds an LED. This is a feature not present downstream. No 
default trigger is thus used and I chose the label scheme used by sunxi 
and omap (zynq-zc702.dts uses just "ds23").
Tested as follows:
echo mmc0 > /sys/class/leds/parallella:cr10:usr/trigger #or s/mmc0/heartbeat/
(on openSUSE Tumbleweed I appended this to /etc/init.d/boot.local script)

Patch 5 goes on to add USB support. As the Microserver edition does not 
have USB, the bulk of nodes is moved to a new .dtsi file in patch 1.

Note: Adapteva's downstream tree has in the meantime split zynq-parallella.dts 
into zynq-parallella1-{hdmi,headless}.dts (without discussing this here first).
Since zynq-parallella.dts has already been released, I have chosen to 
stay with that name and have therefore named the Microserver edition 
zynq-parallella-microserver.dts, while naming the shared file 
zynq-parallella1.dtsi.
Anyone prefer to name the new file zynq-parallella1-microserver.dts?

On my work branch https://github.com/afaerber/linux/commits/parallella-next
I have further prepared a zynq-parallella-headless.dts variant 
following this scheme. Depending on how the Epiphany driver evolves, we 
may further need to split the non-Microserver variant(s) into e16 vs. e64
variants to cope with some Kickstarter boards.

Is there some rule for device tree file name stability when splitting a 
file due to additional nodes?

Example of historic growth:
 zynq-parallella.dtb (today works on all boards) -- now with USB/HDMI
 zynq-parallella-microserver.dtb (this series) -- without USB/HDMI
 zynq-parallella-headless.dtb -- with USB/HDMI, but no FPGA HDMI support
 zynq-parallella-e64.dtb -- with Epiphany-IV instead of Epiphany-III
 zynq-parallella-e64-headless.dtb -- ditto, but different FPGA bitstream
 zynq-parallella2-*.dtb
vs. extreme distinction:
 zynq-parallella1-e16-hdmi.dtb
 zynq-parallella1-e16-headless.dtb
 zynq-parallella1-e16-microserver.dtb (doesn't fully fit the scheme...)
 zynq-parallella1-e64-hdmi.dtb
 zynq-parallella1-e64-headless.dtb
 zynq-parallella2-*.dtb
In the former case, the name remains stable for capable boards, but using 
it on lesser capable boards may break. In the latter case, users of all 
boards need to choose a more specific file whenever incompatible changes 
are made. Since no effort has been made to provide users with a smooth
downstream-to-upstream path, I guess we can at least neglect that scenario,
already having diverged by now.

Regards,
Andreas

Andreas F?rber (5):
  ARM: dts: zynq: Split out common Parallella bits
  ARM: dts: zynq: Add pinctrl to Parallella
  ARM: dts: zynq: Add LED for Parallella
  ARM: dts: zynq: Split off Parallella Microserver device tree
  ARM: dts: zynq: Add USB for Parallella

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/zynq-parallella-microserver.dts |  19 ++
 arch/arm/boot/dts/zynq-parallella.dts             |  72 +-----
 arch/arm/boot/dts/zynq-parallella1.dtsi           | 297 ++++++++++++++++++++++
 4 files changed, 323 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-parallella-microserver.dts
 create mode 100644 arch/arm/boot/dts/zynq-parallella1.dtsi

-- 
2.2.2

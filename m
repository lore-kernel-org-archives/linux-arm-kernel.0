From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 05 Nov 2013 21:45:33 +0100
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230 and
 mv78260
Message-ID: <cover.1383681717.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As discussed earlier, here is a set of two patches fixing Armada XP
mv78230 and mv78260 PCIe units definition. AFAICT, the most accurate
information available regarding those is the table available on the
following page:

 http://www.marvell.com/embedded-processors/armada-xp/

First patch is simply a resend of the one Thomas reviewed with my
SoB. It fixes mv78230 .dtsi and has been tested on real hardware.

Second patch fixes mv78260 .dtsi to reflect the fact that the two first
units are x4 and quad x1 capable, and third (and last) interface is x4
only. This patch has only been compiled and not tested on real hardware.
As associated changes are quite error-prone, I think it needs some
careful review.

As a side note, Thomas, I noticed one more thing, this time in mv78460
.dtsi when comparing it w/ mv78230 and mv78260 ones. The first address
of "assigned-address" property varies in the former for each pcie
node:

$ grep assigned-address armada-xp-mv78230.dtsi 
         assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
$ grep assigned-address armada-xp-mv78260.dtsi 
         assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x84000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x88000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x8c000 0 0x2000>;
         assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
$ grep assigned-address armada-xp-mv78460.dtsi 
         assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
         assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
         assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
         assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
         assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
         assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
         assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
         assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
         assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
         assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;

I took at Documentation/devicetree/bindings/pci/mvebu-pci.txt but
failed to find an answer. Can you explain where the difference comes
from?

Cheers,

a+

Arnaud Ebalard (2):
  ARM: mvebu: second PCIe unit of Armada XP mv78230 is only x1 capable
  ARM: mvebu: fix second and third PCIe units of Armada XP mv78260

 arch/arm/boot/dts/armada-xp-mv78230.dtsi |  24 +++----
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 109 ++++++++++++++++++++++++-------
 2 files changed, 97 insertions(+), 36 deletions(-)

-- 
1.8.4.rc3

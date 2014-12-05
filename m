From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  5 Dec 2014 11:28:28 +0900
Subject: [PATCH v2] ARM: shmobile: dts: koelsch: Fix flash partition label and
 size
Message-ID: <1417746508-14557-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the size and names of flash partitions to match the
expectations of the loader which are as follows:

"loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
"user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
"flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]

["user"'s assumed breakdown]
U-boot       (0x0008_0000-0x000c_0000) 256KiB
bootargs     (0x000c_0000-0x0010_0000) 256KiB
Device tree  (0x0010_0000-0x0014_0000) 256KiB
zImage       (0x0014_0000-0x0060_0000) 4.75MiB

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* As suggested by Geert Uytterhoeven
  - Break out U-boot and bootargs into separate areas within the user
    partition description in the changelog
  - Refer to zImage rather than uImage in the changelog
* As suggested by Sergei Shtylyov
  - Correct base address of partition nodes to match the base address of
    their register

This replaces a patch that I previously posted, "shmobile: koelsch: Fix
flash partition label and size in device tree", which has the same aim but
does so for an older version of the loader which to my knowledge is not
found in the wild.

I plan to post a similar patch for Lager if this one goes well.

I have been informed that the flash layout should also be the same
for Alt (which currently does not have flash in its dts file in mainline).
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index bf58c79..6938377 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -452,13 +452,13 @@
 			read-only;
 		};
 		partition at 80000 {
-			label = "bootenv";
-			reg = <0x00080000 0x00080000>;
+			label = "user";
+			reg = <0x00080000 0x00580000>;
 			read-only;
 		};
-		partition at 100000 {
-			label = "data";
-			reg = <0x00100000 0x03f00000>;
+		partition at 600000 {
+			label = "flash";
+			reg = <0x00600000 0x03a00000>;
 		};
 	};
 };
-- 
2.1.3

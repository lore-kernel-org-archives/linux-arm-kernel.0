From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Apr 2015 11:16:24 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on Armada
 370 DB
Message-ID: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 DB boards are now being used with a more recent version
of U-Boot, which has Device Tree support, and remaps internal
registers at 0xf1000000 like most of the other Marvell EBU platforms.

Consequently, this commit updates the Device Tree describing this
platform to use this new internal register address, so that the
mainline kernel can easily be used on such boards that use a modern
bootloader. A comment is also added to warn users who could have
boards with an older bootloader version.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index e993c46..dede3e7 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -45,6 +45,15 @@
  *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -64,7 +73,7 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
-- 
2.1.0

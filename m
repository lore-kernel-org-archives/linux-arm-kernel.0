From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  7 Apr 2015 14:23:03 +0200
Subject: [PATCHv2] ARM: mvebu: use 0xf1000000 as internal registers on Armada
 370 DB
Message-ID: <1428409383-15922-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Marvell EBU SoCs (Kirkwood, Dove, Orion, Armada) have the
capability of changing the location of their internal registers (i.e
the registers for most hardware blocks inside the SoC). When coming
out of reset, the internal registers are mapped at 0xd0000000, but
since years and years, the tradition has been to have the internal
registers remapped at 0xf1000000 by the bootloader, and Linux has
since then assumed that the internal registers for the SoC were
located at 0xf1000000 on Kirkwood, Dove, Orion, etc. Linux has never
been aware that those registers are remappable (and there is no way to
know where they are mapped at runtime, since the register to configure
the address of the registers is itself within the internal registers).

Then came the Armada 370 and Armada XP, in which some of the very
early silicon steppings had an issue, which forced to use 0xd0000000:
the SoC was no longer working properly when the internal registers
were remapped at 0xf1000000. This issue is only affecting very early
silicon steppings and production steppings are not affected: the issue
has been fixed in between.

Since what we (Free Electrons) used to do the initial submission of
the Armada 370 and Armada XP platforms was evaluation boards with
those very early steppings, we submitted Device Tree that assumed the
internal registers were mapped at 0xd0000000. This is the case for
Armada 370 DB, Armada XP DB and Armada XP GP.

However, in practice, since Marvell has been shipping the evaluation
boards with production steppings of the SoC, they are shipping those
boards with bootloaders that remap the registers to 0xf1000000. We
have already changed this internal register address to 0xf1000000 for
the Armada XP DB in commit 82066bdb5a75 and for the Armada XP GP in
commit 91ed32200e6e (both merged in v3.15).

We only recently got our hand on an Armada 370 DB with a production
stepping of the SoC, which uses a bootloader that remaps internal
registers at 0xf1000000. Therefore, this commit aligns the Armada 370
DB to be like the Armada XP DB and Armada XP GP: assume that the
internal registers are mapped at 0xf1000000.

We would like to stress out the fact that the usage of 0xd0000000 as
the internal register base address was a temporary workaround for
early steppings deficiencies, and that the real long-term solution is
the usage of 0xf1000000. Having 0xd0000000 is an *accident* in the
life of the Marvell platform support in the kernel, as is confirmed by
the usage of 0xf1000000 in all previous Marvell platforms (Dove,
Kirkwood, Orion).

There are unfortunately a number of commercial devices that continue
to use 0xd0000000 even though they use production steppings of the
SoC, simply because the vendors of such devices have never bothered
using a more recent bootloader version from Marvell. There is not much
we can do about it, and we plan on keeping 0xd0000000 in the Device
Tree of such devices.

The main reason for remapping the internal registers at 0xf1000000
instead of 0xd0000000 is that it leaves more space in the 0 -> 4 GB
part of the physical address space for RAM. With registers at
0xd0000000, all RAM between 0xd0000000 to 0xffffffff is lost because
it's covered by the I/O registers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v1:
 - Improved commit log.

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

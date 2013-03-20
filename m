From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Mar 2013 15:00:09 +0100
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <20130320134612.GA27793@amd.pavel.ucw.cz>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <1363707936-17769-2-git-send-email-dinguyen@altera.com>
 <20130320134612.GA27793@amd.pavel.ucw.cz>
Message-ID: <20130320140009.GA27880@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Adds the main PLL clock groups for SOCFPGA into device tree file
> > so that the clock framework to query the clock and clock rates
> > appropriately.
> 
> Is there an easy way to test it?

Please consider cleanups below. If compiles and NFS root fails the
same way it failed below.

Thanks,
								Pavel

commit 82158c4cf015e3b8c3db1b5ba84722fe1a480dce
Author: Pavel Machek <pavel@pollux.denx.de>
Date:   Wed Mar 20 14:56:56 2013 +0100

    Convert clock_manager_base_addr to structure, to get type checking and
    nicer code.
    
    Improve constants alignment a bit.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 856625a..b88b992 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -30,7 +30,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
-void __iomem *clk_mgr_base_addr;
+struct clock_manager_hw __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 3504dbf..0239ff5 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -17,16 +17,13 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of.h>
 
-/* Clock Manager offsets */
-#define CLKMGR_CTRL    0x0
-#define CLKMGR_BYPASS 0x4
-
 /* Clock bypass bits */
 #define MAINPLL_BYPASS (1<<0)
 #define SDRAMPLL_BYPASS (1<<1)
@@ -37,12 +34,17 @@
 #define SOCFPGA_PLL_BG_PWRDWN  0x00000001
 #define SOCFPGA_PLL_EXT_ENA    0x00000002
 #define SOCFPGA_PLL_PWR_DOWN   0x00000004
-#define SOCFPGA_PLL_DIVF_MASK 0x0000FFF8
+#define SOCFPGA_PLL_DIVF_MASK  0x0000FFF8
 #define SOCFPGA_PLL_DIVF_SHIFT 3
-#define SOCFPGA_PLL_DIVQ_MASK 0x003F0000
+#define SOCFPGA_PLL_DIVQ_MASK  0x003F0000
 #define SOCFPGA_PLL_DIVQ_SHIFT 15
 
-extern void __iomem *clk_mgr_base_addr;
+struct clock_manager_hw {
+	u32 ctrl;
+	u32 bypass;
+};
+
+extern struct clock_manager_hw __iomem *clk_mgr_base_addr;
 
 struct socfpga_clk {
 	struct clk_hw hw;
@@ -83,7 +85,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 	unsigned long bypass;
 
 	reg = readl(socfpgaclk->reg);
-	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
+	bypass = readl(&clk_mgr_base_addr->bypass);
 	if (bypass & MAINPLL_BYPASS)
 		return parent_rate;
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

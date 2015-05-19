From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 May 2015 17:22:10 +0200
Subject: [PATCH v10 05/17] clk: tegra: Introduce ability for SoC-specific
 reset control callbacks
In-Reply-To: <555B517F.4080506@kapsi.fi>
References: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
 <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150519145922.GA28018@ulmo> <555B517F.4080506@kapsi.fi>
Message-ID: <20150519152208.GB28161@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 06:06:39PM +0300, Mikko Perttunen wrote:
> On 05/19/2015 05:59 PM, Thierry Reding wrote:
> >On Tue, May 19, 2015 at 02:39:27PM +0300, Mikko Perttunen wrote:
> >>This patch allows SoC-specific CAR initialization routines to register
> >>their own reset_assert and reset_deassert callbacks with the common Tegra
> >>CAR code. If defined, the common code will call these callbacks when a
> >>reset control with number >= num_periph_banks * 32 is attempted to be asserted
> >>or deasserted respectively. Numbers greater than or equal to num_periph_banks * 32
> >>are used to avoid clashes with low numbers that are automatically mapped to
> >>standard CAR reset lines.
> >>
> >>Each SoC with these special resets should specify the defined reset control
> >>numbers in a device tree header file.
> >
> >This is looking pretty good, but I think we can simplify a wee bit
> >more...
> >
> >>Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> >>Acked-by: Michael Turquette <mturquette@linaro.org>
> >>---
> >>  drivers/clk/tegra/clk.c | 39 +++++++++++++++++++++++++++++++--------
> >>  drivers/clk/tegra/clk.h |  3 +++
> >>  2 files changed, 34 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> >>index 41cd87c..c093ed9 100644
> >>--- a/drivers/clk/tegra/clk.c
> >>+++ b/drivers/clk/tegra/clk.c
> >>@@ -49,7 +49,6 @@
> >>  #define RST_DEVICES_L			0x004
> >>  #define RST_DEVICES_H			0x008
> >>  #define RST_DEVICES_U			0x00C
> >>-#define RST_DFLL_DVCO			0x2F4
> >>  #define RST_DEVICES_V			0x358
> >>  #define RST_DEVICES_W			0x35C
> >>  #define RST_DEVICES_X			0x28C
> >>@@ -79,6 +78,11 @@ static struct clk **clks;
> >>  static int clk_num;
> >>  static struct clk_onecell_data clk_data;
> >>
> >>+/* Handlers for SoC-specific reset lines */
> >>+static int (*special_reset_assert)(unsigned long);
> >>+static int (*special_reset_deassert)(unsigned long);
> >>+static int special_reset_num;
> >
> >I think we can get rid of this if we...
> >
> >>+
> >>  static struct tegra_clk_periph_regs periph_regs[] = {
> >>  	[0] = {
> >>  		.enb_reg = CLK_OUT_ENB_L,
> >>@@ -152,19 +156,29 @@ static int tegra_clk_rst_assert(struct reset_controller_dev *rcdev,
> >>  	 */
> >>  	tegra_read_chipid();
> >>
> >>-	writel_relaxed(BIT(id % 32),
> >>-			clk_base + periph_regs[id / 32].rst_set_reg);
> >>+	if (id < periph_banks * 32) {
> >>+		writel_relaxed(BIT(id % 32),
> >>+			       clk_base + periph_regs[id / 32].rst_set_reg);
> >>+		return 0;
> >>+	} else if (id < periph_banks * 32 + special_reset_num) {
> >>+		return special_reset_assert(id);
> >>+	}
> >
> >... pass id - periph_banks * 32 into special_reset_assert(). Oh, but
> >then...
> 
> The reason I don't subtract periph_banks * 32 is because this way the code
> in the SoC-specific callback can just include the dt-bindings header and use
> the same defines used in the device tree.

Indeed, you're right. Now if

	static int special_reset_num;

could be turned into

	static unsigned int num_special_reset;

I'd be happy to take this into the Tegra clock tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/473ddc4c/attachment-0001.sig>

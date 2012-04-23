From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 17:56:26 +0530
Subject: [PATCH V2 04/10] SPEAr13xx: Add common clock framework support
In-Reply-To: <c6acd3311d99bb61efb4a64389831c75812360ce.1335010373.git.viresh.kumar@st.com>
References: <cover.1335010373.git.viresh.kumar@st.com>
 <4a3362a884d1dfa8cdef65a10c97c43be4c17ff6.1335010373.git.viresh.kumar@st.com>
 <c6acd3311d99bb61efb4a64389831c75812360ce.1335010373.git.viresh.kumar@st.com>
Message-ID: <CAOh2x==n40acPerK5A2hPOwfX+c9PyadQKJd6kTDZJd39QuYiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/12, Viresh Kumar <viresh.linux@gmail.com> wrote:
> This patch adds SPEAr1310 and SPEAr1340's clock framework support. It is
> based
> on earlier support for SPEAr3xx family.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Mike Turquette <mturquette@ti.com>
> ---
>  drivers/clk/spear/Makefile          |    2 +
>  drivers/clk/spear/spear1310_clock.c | 1051

And squash this here:

From: Viresh Kumar <viresh.kumar@st.com>
Date: Mon, 23 Apr 2012 17:35:47 +0530
Subject: [PATCH 2/2] fixup! SPEAr13xx: Add common clock framework support

Local registers to 1310 moved to 1310's clock.c file.

---
 drivers/clk/spear/spear1310_clock.c |   59 +++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c
b/drivers/clk/spear/spear1310_clock.c
index c813016..9b22c60 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -170,6 +170,65 @@
 	#define SPEAR1310_PCLK_CLK_ENB			1
 	#define SPEAR1310_ACLK_CLK_ENB			0

+/* RAS Area Control Register */
+#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
+	#define SPEAR1310_SSP1_CLK_MASK			3
+	#define SPEAR1310_SSP1_CLK_SHIFT		26
+	#define SPEAR1310_TDM_CLK_MASK			1
+	#define SPEAR1310_TDM2_CLK_SHIFT		24
+	#define SPEAR1310_TDM1_CLK_SHIFT		23
+	#define SPEAR1310_I2C_CLK_MASK			1
+	#define SPEAR1310_I2C7_CLK_SHIFT		22
+	#define SPEAR1310_I2C6_CLK_SHIFT		21
+	#define SPEAR1310_I2C5_CLK_SHIFT		20
+	#define SPEAR1310_I2C4_CLK_SHIFT		19
+	#define SPEAR1310_I2C3_CLK_SHIFT		18
+	#define SPEAR1310_I2C2_CLK_SHIFT		17
+	#define SPEAR1310_I2C1_CLK_SHIFT		16
+	#define SPEAR1310_GPT64_CLK_MASK		1
+	#define SPEAR1310_GPT64_CLK_SHIFT		15
+	#define SPEAR1310_RAS_UART_CLK_MASK		1
+	#define SPEAR1310_UART5_CLK_SHIFT		14
+	#define SPEAR1310_UART4_CLK_SHIFT		13
+	#define SPEAR1310_UART3_CLK_SHIFT		12
+	#define SPEAR1310_UART2_CLK_SHIFT		11
+	#define SPEAR1310_UART1_CLK_SHIFT		10
+	#define SPEAR1310_PCI_CLK_MASK			1
+	#define SPEAR1310_PCI_CLK_SHIFT			0
+
+#define SPEAR1310_RAS_CTRL_REG1			(VA_SPEAR1310_RAS_BASE + 0x004)
+	#define SPEAR1310_PHY_CLK_MASK			0x3
+	#define SPEAR1310_RMII_PHY_CLK_SHIFT		0
+	#define SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT	2
+
+#define SPEAR1310_RAS_SW_CLK_CTRL		(VA_SPEAR1310_RAS_BASE + 0x0148)
+	#define SPEAR1310_CAN1_CLK_ENB			25
+	#define SPEAR1310_CAN0_CLK_ENB			24
+	#define SPEAR1310_GPT64_CLK_ENB			23
+	#define SPEAR1310_SSP1_CLK_ENB			22
+	#define SPEAR1310_I2C7_CLK_ENB			21
+	#define SPEAR1310_I2C6_CLK_ENB			20
+	#define SPEAR1310_I2C5_CLK_ENB			19
+	#define SPEAR1310_I2C4_CLK_ENB			18
+	#define SPEAR1310_I2C3_CLK_ENB			17
+	#define SPEAR1310_I2C2_CLK_ENB			16
+	#define SPEAR1310_I2C1_CLK_ENB			15
+	#define SPEAR1310_UART5_CLK_ENB			14
+	#define SPEAR1310_UART4_CLK_ENB			13
+	#define SPEAR1310_UART3_CLK_ENB			12
+	#define SPEAR1310_UART2_CLK_ENB			11
+	#define SPEAR1310_UART1_CLK_ENB			10
+	#define SPEAR1310_RS485_1_CLK_ENB		9
+	#define SPEAR1310_RS485_0_CLK_ENB		8
+	#define SPEAR1310_TDM2_CLK_ENB			7
+	#define SPEAR1310_TDM1_CLK_ENB			6
+	#define SPEAR1310_PCI_CLK_ENB			5
+	#define SPEAR1310_GMII_CLK_ENB			4
+	#define SPEAR1310_MII2_CLK_ENB			3
+	#define SPEAR1310_MII1_CLK_ENB			2
+	#define SPEAR1310_MII0_CLK_ENB			1
+	#define SPEAR1310_ESRAM_CLK_ENB			0
+
 static DEFINE_SPINLOCK(_lock);

 /* pll rate configuration table, in ascending order of rates */

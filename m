From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Mon, 28 Mar 2016 15:26:19 -0400
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
 <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
Message-ID: <56F9855B.9060009@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 03/28/2016 02:53 PM, Fabio Estevam wrote:
> Hi Akshay,
>
> On Wed, Mar 23, 2016 at 12:48 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
>
>> Any comment from NXP regarding the same? I have tested this patch as
>> it is and it resolves intermittent blank LVDS display issues we are
>> seeing on our boards. The questions is if the patch needs to be
>> updated to match EB821 document for the above sections?
>
> I am not aware of such document.
>
> Do you see any discrepancy with regards to the sequence from NXP 3.10 kernel?
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.10.17_1.0.1_ga&id=eecbe9a52587cf9eec30132fb9b8a6761f3a1e6d
>

The 2 discrepancies I see with this patch with regards to the sequence 
from NXP 3.10 kernel are:

1. NXP 3.10 kernel switches clock source as follows:
current_parent -> 7 -> 4 -> new_parent

Ref:
+	/*
+	 * Set the ldb_di0_clk and ldb_di1_clk to 111b.
+	 */
+	reg = readl_relaxed(ccm_base + 0x2c);
+	reg |= ((7 << 9) | (7 << 12));
+	writel_relaxed(reg, ccm_base + 0x2c);
+
+	/*
+	 * Set the ldb_di0_clk and ldb_di1_clk to 100b.
+	 */
+	reg = readl_relaxed(ccm_base + 0x2c);
+	reg &= ~((7 << 9) | (7 << 12));
+	reg |= ((4 << 9) | (4 << 12));
+	writel_relaxed(reg, ccm_base + 0x2c);
+
+	/*
+	 * Perform the LDB parent clock switch.
+	 */
+	clk_set_parent(clk[ldb_di0_sel], clk[new_parent]);
+	clk_set_parent(clk[ldb_di1_sel], clk[new_parent]);


If I am reading this patch correctly, then this patch does:
current_parent -> (current_parent | 4) -> (new_parent | 4) -> new_parent

Ref:
+	/* First switch to the bottom mux */
+	sel[i][1] = sel[i][0] | 4;
+
+	/* Then configure the top mux before switching back to it */
+	sel[i][2] = sel[i][3] | 4;
+
+	pr_debug("ccm: switching ldb_di%d_sel: %d->%d->%d->%d\n", i,
+			 sel[i][0], sel[i][1], sel[i][2], sel[i][3]);


2. The NXP 3.10 kernel does not have any restriction on what the new 
parent is.

Ref:
+ /*
+ * Perform the LDB parent clock switch.
+ */
+ clk_set_parent(clk[ldb_di0_sel], clk[new_parent]);
+ clk_set_parent(clk[ldb_di1_sel], clk[new_parent]);


This patch has a restriction on the new_parent if the current_parent is 
already pll3_usb_otg

Ref:
+               /*
+                * It is unclear whether the procedure works for 
switching from
+                * pll3_usb_otg to any other parent than pll5_video_div
+                */
+               if (sel[i][0] > 3 && sel[i][0] != (sel[i][3] | 4)) {
+                       pr_err("ccm: ldb_di%d_sel workaround only for 
top mux\n",
+                              i);
+                       sel[i][3] = sel[i][2] = sel[i][1] = sel[i][0];
+                       continue;
+               }
+

Thanks,
Akshay

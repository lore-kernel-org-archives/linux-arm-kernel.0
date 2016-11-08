From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Nov 2016 09:24:51 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <2e0ed43b-9a3e-48d4-4e8a-60d6f25ca4ee@suse.com>
References: <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
 <20161028182308.GB18325@live.com>
 <20161028202619.GA29625@obsidianresearch.com>
 <20161028210015.GA19901@live.com>
 <20161028220546.GA19693@obsidianresearch.com>
 <20161029000926.GA30169@live.com>
 <20161108004642.GB32444@obsidianresearch.com>
 <2e0ed43b-9a3e-48d4-4e8a-60d6f25ca4ee@suse.com>
Message-ID: <20161108162451.GA31453@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 10:59:43AM +0100, Matthias Brugger wrote:

> > 	/* don't globally reset PL if we're doing partial reconfig */
> > 	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> >+		if (!zynq_fpga_has_sync(buf, count)) {
> 
> Maybe we should add an error message here to let the user know what went
> wrong, as I think this error path could easily be hit by an user.

Sure, happy with this wording:

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index de475a6a1882..2f3da4c6e2e6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -181,7 +181,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
  */
 static bool zynq_fpga_has_sync(const char *buf, size_t count)
 {
-	for (; count > 4; buf += 4, --count)
+	for (; count > 4; buf += 4, count -= 4)
 		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
 		    buf[3] == 0xaa)
 			return true;
@@ -200,8 +200,11 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 	/* The hardware can only DMA multiples of 4 bytes, and we need at
 	 * least the sync word and something else to do anything.
 	 */
-	if (count <= 4 || (count % 4) != 0)
+	if (count <= 4 || (count % 4) != 0) {
+		dev_err(priv->dev,
+			"Invalid bitstream size, must be multiples of 4 bytes");
 		return -EINVAL;
+	}
 
 	err = clk_enable(priv->clk);
 	if (err)
@@ -210,6 +213,8 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
 		if (!zynq_fpga_has_sync(buf, count)) {
+			dev_err(priv->dev,
+				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file");
 			err = -EINVAL;
 			goto out_err;
 		}

From: david@hardeman.nu (David =?iso-8859-1?Q?H=E4rdeman?=)
Date: Mon, 19 May 2014 22:26:16 +0200
Subject: [PATCH v7 2/3] [media] rc: add sunxi-ir driver
In-Reply-To: <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
References: <1400104602-16431-1-git-send-email-bay@hackerdom.ru>
 <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
Message-ID: <20140519202616.GA25415@hardeman.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 03:56:41AM +0600, Alexander Bersenev wrote:
>This patch adds driver for sunxi IR controller.
>It is based on Alexsey Shestacov's work based on the original driver
>supplied by Allwinner.
>

...

>+static irqreturn_t sunxi_ir_irq(int irqno, void *dev_id)
>+{
>+	unsigned long status;
>+	unsigned char dt;
>+	unsigned int cnt, rc;
>+	struct sunxi_ir *ir = dev_id;
>+	DEFINE_IR_RAW_EVENT(rawir);
>+
>+	spin_lock(&ir->ir_lock);
>+
>+	status = readl(ir->base + SUNXI_IR_RXSTA_REG);
>+
>+	/* clean all pending statuses */
>+	writel(status | REG_RXSTA_CLEARALL, ir->base + SUNXI_IR_RXSTA_REG);
>+
>+	if (status & REG_RXINT_RAI_EN) {
>+		/* How many messages in fifo */
>+		rc  = (status >> REG_RXSTA_RAC__SHIFT) & REG_RXSTA_RAC__MASK;
>+		/* Sanity check */
>+		rc = rc > SUNXI_IR_FIFO_SIZE ? SUNXI_IR_FIFO_SIZE : rc;
>+		/* If we have data */
>+		for (cnt = 0; cnt < rc; cnt++) {
>+			/* for each bit in fifo */
>+			dt = readb(ir->base + SUNXI_IR_RXFIFO_REG);
>+			rawir.pulse = (dt & 0x80) != 0;
>+			rawir.duration = (dt & 0x7f) * SUNXI_IR_SAMPLE;

Can the hardware actually return a zero duration or should that be dt &
0x7f + 1?

(Not familiar with this particular hardware but I know I've seen that
behaviour before).

>+			ir_raw_event_store_with_filter(ir->rc, &rawir);
>+		}
>+	}
>+
>+	if (status & REG_RXINT_ROI_EN) {
>+		ir_raw_event_reset(ir->rc);
>+	} else if (status & REG_RXINT_RPEI_EN) {
>+		ir_raw_event_set_idle(ir->rc, true);
>+		ir_raw_event_handle(ir->rc);
>+	}
>+
>+	spin_unlock(&ir->ir_lock);
>+
>+	return IRQ_HANDLED;
>+}
....

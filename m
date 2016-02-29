From: tj@kernel.org (Tejun Heo)
Date: Mon, 29 Feb 2016 16:12:23 -0500
Subject: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <56CF64B9.4080605@caviumnetworks.com>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
 <alpine.DEB.2.11.1602171710350.19512@nanos>
 <56CF64B9.4080605@caviumnetworks.com>
Message-ID: <20160229211223.GZ3965@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry about the delay.

On Thu, Feb 25, 2016 at 12:31:53PM -0800, Tirumalesh Chalamarla wrote:
> On 02/17/2016 08:12 AM, Thomas Gleixner wrote:
> >On Tue, 16 Feb 2016, tchalamarla at caviumnetworks.com wrote:
> >>+#ifdef CONFIG_ARM64
> >>+/* Due to ERRATA#22536, ThunderX need to handle
> >>+ * HOST_IRQ_STAT differently.
> >>+ * Work around is to make sure all pending IRQs
> >>+ * are served before leaving handler
> >>+ */
> >>+static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
> >>+{
> >>+	struct ata_host *host = dev_instance;
> >>+	struct ahci_host_priv *hpriv;
> >>+	unsigned int rc = 0;
> >>+	void __iomem *mmio;
> >>+	u32 irq_stat, irq_masked;
> >>+	unsigned int handled = 1;
> >>+
> >>+	VPRINTK("ENTER\n");
> >
> >Come on. This VPRINK stuff is really pointless. Enable irq tracepoints, they
> >already track the enter/exit of interrupt handlers ....
> 
> sure. waiting for some more comments if any.

Yeah, VPRINTK way predates tracepoints and is kinda silly at this
point.  That said, it's used relatively consistently across libata and
some people still use it for debugging.  We can replace them with
proper tracepoints but that's a work for another patchset.  For now,
let's leave it in for consistency with counterparts.

Thanks.

-- 
tejun

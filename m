From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 22:43:09 +0000
Subject: [PATCH 1/5] gic: prevent gic from crossing NR_IRQ
In-Reply-To: <1264620749-24527-2-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-2-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100127224309.GD29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:32:25AM -0800, adharmap at codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> The gic code tries to initialize interrupts beyond NR_IRQ. Prevent
> code from doing that.

NAK.  This is completely the wrong approach.

        /*
         * Find out how many interrupts are supported.
         */
        max_irq = readl(base + GIC_DIST_CTR) & 0x1f;
        max_irq = (max_irq + 1) * 32;

        /*
         * The GIC only supports up to 1020 interrupt sources.
         * Limit this to either the architected maximum, or the
         * platform maximum.
         */
        if (max_irq > max(1020, NR_IRQS))
                max_irq = max(1020, NR_IRQS);
...
        for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {

This function is broken if irq_start != 0, and needs fixing - max_irq
needs to be limited to the _minimum_ of 1020 or NR_IRQS - irq_start.

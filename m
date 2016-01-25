From: tj@kernel.org (Tejun Heo)
Date: Mon, 25 Jan 2016 15:23:03 -0500
Subject: [PATCH v2] drivers: ata: wake port before DMA stop for ALPM
In-Reply-To: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
References: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
Message-ID: <20160125202303.GK3628@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 01:22:26PM -0800, Danesh Petigara wrote:
> The AHCI driver code stops and starts port DMA engines at will
> without considering the power state of the particular port. The
> AHCI specification isn't very clear on how to handle this scenario,
> leaving implementation open to interpretation.
> 
> Broadcom's STB SATA host controller is unable to handle port DMA
> controller restarts when the port in question is in low power mode.
> When a port enters partial or slumber mode, its PHY is powered down.
> When a controller restart is requested, the controller's internal
> state machine expects the PHY to be brought back up by software which
> never happens in this case, resulting in failures.
> 
> To avoid this situation, logic is added to manually wake up the port
> just before its DMA engine is stopped, if the port happens to be in
> a low power state. HBA initiated power management ensures that the port
> eventually returns to its configured low power state, when the link is
> idle (as per the conditions listed in the spec). A new host flag is also
> added to ensure this logic is only exercised for hosts with the above
> limitation.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Reviewed-by: Markus Mayer <mmayer@broadcom.com>

Applied to libata/for-4.5-fixes w/ some formatting changes.

Thanks.

-- 
tejun

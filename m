From: ecc@cmu.edu (Eric Cooper)
Date: Thu, 27 Jan 2011 22:24:54 -0500
Subject: kexec on kirkwood kernels?
In-Reply-To: <20110127072433.GI1147@pengutronix.de>
References: <20110127030024.GF19307@localhost>
	<20110127072433.GI1147@pengutronix.de>
Message-ID: <20110128032454.GG22555@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 08:24:33AM +0100, Uwe Kleine-K?nig wrote:
> Try enabling DEBUG_LL and EARLY_PRINTK in the kernel to boot and pass 
> 	earlyprintk
> as kernel parameter.

Thanks, that helped quite a bit.  After inserting various print
statements, I found that the system is hanging in the readl call in
orion_pcie_dev_id.  The call chain is:

    start_kernel
    time_init
    kirkwood_timer_init
    kirkwood_find_tclk
    kirkwood_pcie_id
    orion_pcie_dev_id
    readl

The readl is attempting to access the address
KIRKWOOD_REGS_VIRT_BASE + 0x40000.

This same code gets executed successfully when the kernel is started
from u-boot; I'm not sure what's different in the post-kexec
environment.  Any suggestions on what to try next would be
appreciated.

-- 
Eric Cooper             e c c @ c m u . e d u

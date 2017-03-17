From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Mar 2017 15:49:47 +0000
Subject: [PATCH] irqchip: gic-v3-its: Don't assume GICv3 hardware supports
 16bit INTID
In-Reply-To: <1489556815-27121-1-git-send-email-shankerd@codeaurora.org>
References: <1489556815-27121-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <a7e9f0a6-6118-a8a1-c6e9-8e6841c49f30@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/17 05:46, Shanker Donthineni wrote:
> The current ITS driver is assuming every ITS hardware implementation
> supports minimum of 16bit INTID. But this is not true, as per GICv3
> specification, INTID field is IMPLEMENTATION DEFINED in the range of
> 14-24 bits. We might see an unpredictable system behavior on systems
> where hardware support less than 16bits and software tries to use
> 64K LPI interrupts.
> 
> On Qualcomm Datacenter Technologies QDF2400 platform, boot log shows
> confusing information about number of LPI chunks as shown below. The
> QDF2400 ITS hardware supports 24bit INTID.
> 
> This patch allocates the memory resources for PEND/PROP tables based
> on discoverable value which is specified in GITS_TYPER.IDbits. Also
> taking this opportunity to increase number of LPI/MSI(x) to 128K if
> the hardware is capable, and show log message that reflects the
> correct number of LPI chunks.

As much as I like the idea of fixing the obvious bug that assuming 16bit
of ID space is, what is the rational of capping the support to another
arbitrary value?

Why can't we (just like other tables) try and allocate the full amount
required (with a possible back-off if allocations fail)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

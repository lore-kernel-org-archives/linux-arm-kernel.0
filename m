From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jun 2013 15:59:58 +0100
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130604145958.GY18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 04:03:17PM +0200, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> This commit fixes the regression on Armada 370 (the kernal hang during
> boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> 
> When coming out of either a Wait for Interrupt (WFI) or a Wait for
> Event (WFE) IDLE states, a specific timing sensitivity exists between
> the retiring WFI/WFE instructions and the newly issued subsequent
> instructions. This sensitivity can result in a CPU hang scenario.  The
> workaround is to insert either a Data Synchronization Barrier (DSB) or
> Data Memory Barrier (DMB) command immediately after the WFI/WFE
> instruction

Wouldn't a DMB be cheaper than a full blown DSB here?

Also, we could detect the PJ4B and only implement the workaround
on those CPUs rather than having to have it on every v7 CPU - which
is important when you consider the single zImage issues.

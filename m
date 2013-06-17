From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 09:31:51 +0100
Subject: [PATCH v4 2/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <alpine.LFD.2.03.1306072208460.18597@syhkavp.arg>
References: <1370599460-9947-1-git-send-email-gregory.clement@free-electrons.com>
 <1370599460-9947-3-git-send-email-gregory.clement@free-electrons.com>
 <alpine.LFD.2.03.1306072208460.18597@syhkavp.arg>
Message-ID: <20130617083151.GB2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 10:09:09PM -0400, Nicolas Pitre wrote:
> On Fri, 7 Jun 2013, Gregory CLEMENT wrote:
> 
> > This commit fixes the regression on Armada 370 (the kernal hang during
> > boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
> > TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".
> > 
> > When coming out of either a Wait for Interrupt (WFI) or a Wait for
> > Event (WFE) IDLE states, a specific timing sensitivity exists between
> > the retiring WFI/WFE instructions and the newly issued subsequent
> > instructions. This sensitivity can result in a CPU hang scenario.  The
> > workaround is to insert either a Data Synchronization Barrier (DSB) or
> > Data Memory Barrier (DMB) command immediately after the WFI/WFE
> > instruction.
> > 
> > This commit was based on the work of Lior Amsalem, but heavily
> > modified to apply the errata fix dynamically according to the
> > processor type thanks to the suggestions of Russell King and Nicolas
> > Pitre.
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Dropped-by: Me.  This causes build regression on anything using ARMv7 CPUs.

Doing this kind of thing conditionally is only of any use if you ensure
that _all_ the places you are using the new symbols you conditionally
define are also appropriately conditionalised, which in this patch they
aren't.

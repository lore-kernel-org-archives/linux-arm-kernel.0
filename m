From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 13:46:16 +0800
Subject: [PATCH v8 00/14] Consolidating GIC per-cpu interrupts
In-Reply-To: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110706054615.GC26324@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 09:49:01AM +0100, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
> 
> - They use a completely separate scheme to handle the interrupts,
>   mostly because the PPI concept doesn't really match the kernel view
>   of an interrupt.
> - PPIs can only be used by the timer code, unless we add more low-level
>   assembly code.
> - The local timer code can only be used by devices generating PPIs,
>   and not SPIs.
> - At least one platform (msm) has started implementing its own
>   alternative scheme.
> - Some low-level code gets duplicated, as usual...
> 
> The proposed solution is to let the GIC code expose the PPIs as
> something that the kernel can manage. Instead of having a single
> interrupt number shared on all cores, make the interrupt number be
> different on each CPU.
> 
> This enables the use of the normal kernel API (request_irq() and
> friends) and the elimination of some low level code. It also serves as
> the basis of the GIC device tree support code. On the other side, it
> causes quite a bit of churn in the timer code.
> 
> Previous versions of this series have received ACKs from some platform
> maintainers, but so far there has been very little comment on the core
> code. As I now have quite a large number of patches relying on this
> series (local timers as devices, device tree support for GIC and TWD),
> I'd be grateful for at least a hint indicating that this is going in
> the right direction. Or not.
> 
I'm about to start mainlining Freescale i.MX6 core code.  It will be
wonderful if these great consolidation works could hit v3.1 merge
window, so that I can base i.MX6 off them in the next cycle.

-- 
Regards,
Shawn

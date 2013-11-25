From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 25 Nov 2013 13:17:55 -0500
Subject: [PATCH 1/4] irqchip: armada-370-xp: fix IPI race condition
In-Reply-To: <1385396807-19027-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1385396807-19027-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131125181755.GA2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 05:26:44PM +0100, Thomas Petazzoni wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> In the Armada 370/XP driver, when we receive an IRQ 0, we read the
> list of doorbells that caused the interrupt from register
> ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS. This gives the list of IPIs that
> were generated. However, instead of acknowledging only the IPIs that
> were generated, we acknowledge *all* the IPIs, by writing
> ~IPI_DOORBELL_MASK in the ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS register.
> 
> This creates a race condition: if a new IPI that isn't part of the
> ones read into the temporary "ipimask" variable is fired before we
> acknowledge all IPIs, then we will simply loose it. This is causing
> scheduling hangs on SMP intensive workloads.
> 
> It is important to mention that this ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS
> register has the following behavior: "A CPU write of 0 clears the bits
> in this field. A CPU write of 1 has no effect". This is what allows us
> to simply write ~ipimask to acknoledge the handled IPIs.
> 
> Notice that the same problem is present in the MSI implementation, but
> it will be fixed as a separate patch, so that this IPI fix can be
> pushed to older stable versions as appropriate (all the way to 3.8),
> while the MSI code only appeared in 3.13.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> The problem has been present since 344e873e5657e8dc0 ('arm: mvebu: Add
> IPI support via doorbells'), that is since v3.8. However, notice that
> the IRQ driver was moved from arch/arm/mach-mvebu/ to drivers/irqchip
> in the process, and also that the very line being changed was slightly
> modified in 5ec69017cc944f3ed8 ('irqchip: armada-370-xp: slightly
> cleanup irq controller driver').
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

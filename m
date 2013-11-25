From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 25 Nov 2013 13:18:32 -0500
Subject: [PATCH 2/4] irqchip: armada-370-xp: fix MSI race condition
In-Reply-To: <1385396807-19027-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1385396807-19027-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131125181832.GB2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 05:26:45PM +0100, Thomas Petazzoni wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> In the Armada 370/XP driver, when we receive an IRQ 1, we read the
> list of doorbells that caused the interrupt from register
> ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS. This gives the list of MSIs that
> were generated. However, instead of acknowledging only the MSIs that
> were generated, we acknowledge *all* the MSIs, by writing
> ~MSI_DOORBELL_MASK in the ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS register.
> 
> This creates a race condition: if a new MSI that isn't part of the
> ones read into the temporary "msimask" variable is fired before we
> acknowledge all MSIs, then we will simply loose it.
> 
> It is important to mention that this ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS
> register has the following behavior: "A CPU write of 0 clears the bits
> in this field. A CPU write of 1 has no effect". This is what allows us
> to simply write ~msimask to acknoledge the handled MSIs.
> 
> Notice that the same problem is present in the IPI implementation, but
> it is fixed as a separate patch, so that this IPI fix can be pushed to
> older stable versions as appropriate (all the way to 3.8), while the
> MSI code only appeared in 3.13.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> This is only needed for 3.13, since the MSI support didn't exist in
> earlier kernel versions.
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

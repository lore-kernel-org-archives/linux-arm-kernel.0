From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 26 Mar 2013 07:24:55 +0900
Subject: [PATCH v2 1/2] irqchip: intc-irqpin: Add support for shared
 interrupt lines
In-Reply-To: <1364219503-7738-1-git-send-email-hechtb+renesas@gmail.com>
References: <1364219503-7738-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <CANqRtoTPy8LF-YvSiaWRyQjcvZG-qJK2tVi5KxkNfD4oNbOOeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian,

On Mon, Mar 25, 2013 at 10:51 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> On some hardware we don't have a 1-1 mapping from the external
> interrupts coming from INTC to the GIC SPI pins. We can however
> share lines to demux incoming IRQs on these SoCs.
>
> This patch enables the intc_irqpin driver to detect requests for shared
> interrupt lines and demuxes them properly by querying the INTC INTREQx0A
> registers.
>
> If you need multiple shared intc_irqpin device instances, be sure to mask
> out all interrupts on the INTC that share the one line before you start
> to register them. Else you run into IRQ floods that would be caused by
> interrupts for which no handler has been set up yet when the first
> intc_irqpin device is registered.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v2:
>
> Nothing fundamentally changed but several balancing issues:
>
> We don't check for mixing single and shared IRQs but expect the user not to
> do this. Code gets a good bit shorter.
>
> Same for unmasked IRQs. We don't check it but assume the user to do it.
>
> Add dis-/enable IRQ functions for the shared case. While we add verbosity,
> we unburden the normal case hotpath from the extra read/modify/write step
> to update the shared_irq_mask.
>
>  drivers/irqchip/irq-renesas-intc-irqpin.c |   90 ++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 7 deletions(-)

Thanks for this. I am happy how V2 turned out, and I am pleased to see
that the r8a7740 INTC code can with this patch finally be migrated
over from old INTC to GIC + INTC irqpin.

Acked-by: Magnus Damm <damm@opensource.se>

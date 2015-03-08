From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 8 Mar 2015 04:16:10 +0000
Subject: [PATCH v2] irqchip: armada: Fix chained per-cpu interrupts
In-Reply-To: <1425378443-28822-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425378443-28822-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150308041610.GE21207@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Tue, Mar 03, 2015 at 11:27:23AM +0100, Maxime Ripard wrote:
> On the Cortex-A9-based Armada SoCs, the MPIC is not the primary interrupt
> controller. Yet, it still has to handle some per-cpu interrupt.
> 
> To do so, it is chained with the GIC using a per-cpu interrupt. However, the
> current code only call irq_set_chained_handler, which is called and enable that
> interrupt only on the boot CPU, which means that the parent per-CPU interrupt
> is never unmasked on the secondary CPUs, preventing the per-CPU interrupt to
> actually work as expected.
> 
> This was not seen until now since the only MPIC PPI users were the Marvell
> timers that were not working, but not used either since the system use the ARM
> TWD by default, and the ethernet controllers, that are faking there interrupts
> as SPI, and don't really expect to have interrupts on the secondary cores
> anyway.
> 
> Add a CPU notifier that will enable the PPI on the secondary cores when they
> are brought up.
> 
> Cc: <stable@vger.kernel.org> # 3.15+
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes from v1:
>   - Renamed the function and notifier names
> 
>  drivers/irqchip/irq-armada-370-xp.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Applied to irqchip/urgent with Gregory's Ack.

thx,

Jason.

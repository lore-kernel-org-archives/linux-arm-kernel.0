From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 18 Dec 2012 10:57:34 +0800
Subject: [PATCH V3 1/5] ARM: tegra: add pending SGI checking API
In-Reply-To: <CAMbhsRSorDf-BebFn+t39zOK4VX4N0Fu0iPrM7XpKZcssTgX9A@mail.gmail.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-2-git-send-email-josephl@nvidia.com>
 <CAMbhsRSorDf-BebFn+t39zOK4VX4N0Fu0iPrM7XpKZcssTgX9A@mail.gmail.com>
Message-ID: <1355799454.16185.5.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-18 at 10:42 +0800, Colin Cross wrote:
> On Mon, Dec 17, 2012 at 6:30 PM, Joseph Lo <josephl@nvidia.com> wrote:
> > The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
> > include the power of GIC. That caused the SGI (Software Generated
> > Interrupt) been lost. Because the SGI can't wake up the CPU that in
> > the "powered-down" CPU idle mode. We need to check if there is any
> > pending SGI when go into "powered-down" CPU idle mode. This is important
> > especially when applying the coupled cpuidle framework into "power-down"
> > cpuidle dirver. Because the coupled cpuidle framework may have the
> > chance that misses IPI_SINGLE_FUNC handling sometimes.
> 
> This problem exists for any GIC-based SoC, and needs to be fixed in
> gic_cpu_save or gic_dist_save, whichever one loses the interrupt.
> 
Indeed, but may not need to be taken care for every SoC. It's depend on
HW design. Different SoC had different design about it. For ex, some SoC
only put CPU core to power saving mode not include GIC, or there is
another irq controller can handle the case when CPU go into power saving
mode. Differenc SoC had different usage here (some need to check all
pending irq, some need to check SGI only and some even no need to
consider this). So putting this into to common code may not a good
choice.

Thanks,
Joseph

> > For the PPI or SPI, something like the legacy peripheral interrupt. It
> > still can be maintained by Tegra legacy interrupt controller. If there
> > is any pending PPI or SPI when CPU in "powered-down" CPU idle mode. The
> > CPU can be woken up immediately. So we don't need to take care the same
> > situation for PPI or SPI.
> >
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> > V3:
> > * move the static mapping of GIC addr into tegra_pending_sgi
> > V2:
> > * new in V2
> > ---

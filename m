From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Nov 2017 08:04:56 -0600
Subject: [PATCH] irqchip/gic-v3: Support MSIs via aliases and distributor
In-Reply-To: <20171127102408.6631-1-sboyd@codeaurora.org>
References: <20171127102408.6631-1-sboyd@codeaurora.org>
Message-ID: <20171128140456.mexpe542h24s6ycy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 02:24:08AM -0800, Stephen Boyd wrote:
> Some GIC configurations don't have an accessible ITS, but they
> want to support MSIs through the distributor's SETSPI registers
> or through the IMPLEMENTATION DEFINED message-based interrupt
> request register region. This mode of operation is similar to the
> v2m support on gic-400, but we don't necessarily know what
> particular SPIs are supported as MSIs so we need some help from
> firmware to know what to do.
> 
> Introduce an "arm,spi-ranges" property for this, similar to the
> "marvell,spi-ranges" property, that indicates the base and size
> of each MSI range. This property applies equally to the
> distributor and alias registers. In either case, we detect this
> mode of operation by looking for a node with the "msi-controller"
> property and then probe the v2m frame code on top of it. Assume
> these nodes will have the "arm,spi-ranges" property in them so
> that the v2m code works mostly unmodified.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../bindings/interrupt-controller/arm,gic-v3.txt   |  48 +++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/irqchip/irq-gic-v2m.c                      | 102 ++++++++++++++++-----
>  drivers/irqchip/irq-gic-v3.c                       |   4 +
>  include/linux/irqchip/arm-gic-common.h             |   3 +
>  4 files changed, 129 insertions(+), 28 deletions(-)

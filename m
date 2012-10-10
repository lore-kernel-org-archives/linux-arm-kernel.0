From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 08:35:05 +0000
Subject: [RFC PATCH] arm: vt8500: Convert irq.c for multiplatform
 integration
In-Reply-To: <1349856509-20480-1-git-send-email-linux@prisktech.co.nz>
References: <1349856509-20480-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201210100835.05898.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Tony Prisk wrote:
> This patch converts arch-vt8500/irq.c to MULTI_IRQ_HANDLER and
> SPARSE_IRQ. IRQ domain is changed from legacy to linear.
> 
> Also, remove legacy code in include/mach/entry-macro.S and
> include/mach/irq.h to prepare for multiplatform.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Excellent!

Acked-by: Arnd Bergmann <arnd@arndb.de>

One small style comment for a preexisting issue I had not noticed before:

>  static void vt8500_irq_mask(struct irq_data *d)
>  {
> -	struct vt8500_irq_priv *priv =
> -			(struct vt8500_irq_priv *)(d->domain->host_data);
> +	struct vt8500_irq_data *priv = 
> +			(struct vt8500_irq_data *)(d->domain->host_data);

host_data is a void pointer, so you don't need the type cast. Writing this
as 

	struct vt8500_irq_priv *priv = d->domain->host_data;

is both the common convention and easier to read.

	Arnd

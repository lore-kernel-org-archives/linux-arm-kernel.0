From: balbi@ti.com (Felipe Balbi)
Date: Tue, 1 Apr 2014 17:46:54 -0500
Subject: [PATCH] irq: crossbar: improve allocate_free_irq() complexity
In-Reply-To: <1396392259-27437-1-git-send-email-balbi@ti.com>
References: <1396392259-27437-1-git-send-email-balbi@ti.com>
Message-ID: <20140401224654.GA23786@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 05:44:19PM -0500, Felipe Balbi wrote:
> current algorithm in allocate_free_irq() is O(n),
> by just keeping track of last allocated IRQ with a
> simple unsigned integer, we can find a free IRQ
> in O(1).
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> compile-tested only as J6 DTS is currently missing crossbar
> altogether :-(
> 
> There's a drawback with this patch which I'm not sure if we
> should care a lot because I couldn't entirely grasp when is
> domain->xlate() called and if we will map/unmap IRQs in runtime
> or will this *always* be done only during boot.
> 
> If we're talking about runtime IRQ remapping, then this, clearly,
> won't work. But if this will be done only during boot up, then we
> avoid iterating over the irq_map array each time we try to translate
> a new IRQ prior to mapping it.
> 
> Comments are highly welcome as I'll probably learn something new
> about the IRQ subsystem ;-)
> 
>  drivers/irqchip/irq-crossbar.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index fc817d2..1c4da5a 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -31,6 +31,7 @@ struct crossbar_device {
>  	void __iomem *crossbar_base;
>  	int *register_offsets;
>  	void (*write) (int, int);
> +	unsigned int current_irq;
>  };
>  
>  static struct crossbar_device *cb;
> @@ -52,16 +53,15 @@ static inline void crossbar_writeb(int irq_no, int cb_no)
>  
>  static inline int allocate_free_irq(int cb_no)
>  {
> -	int i;
> +	int current_irq;
>  
> -	for (i = 0; i < cb->int_max; i++) {
> -		if (cb->irq_map[i] == IRQ_FREE) {
> -			cb->irq_map[i] = cb_no;
> -			return i;
> -		}
> -	}
> +	if (cb->current_irq == cb->int_max)
> +		return -ENODEV;
> +
> +	current_irq = cb->current_irq++;
> +	cb->irq_map[current_irq++] = cb_no;

this increment is bogus, thought I had committed already, please ignore.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140401/35f28969/attachment.sig>

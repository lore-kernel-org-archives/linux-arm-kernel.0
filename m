From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 9 Jul 2012 16:02:48 +1000
Subject: linux-next: manual merge of the arm-soc tree with the gpio-lw tree
Message-ID: <20120709160248.c746b4286aa2558160f86571@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/gpio/gpio-mxc.c between commit fef2bca203e9 ("gpio/mxc: use the
edge_sel feature if available") from the gpio-lw tree and commit
1ab7ef158dfb ("gpio/mxc: move irq_domain_add_legacy call into gpio
driver") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/gpio/gpio-mxc.c
index f45bb54,e5db670..0000000
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@@ -184,19 -160,15 +184,19 @@@ static int gpio_set_irq_type(struct irq
  		edge = GPIO_INT_FALL_EDGE;
  		break;
  	case IRQ_TYPE_EDGE_BOTH:
 -		val = gpio_get_value(gpio);
 -		if (val) {
 -			edge = GPIO_INT_LOW_LEV;
 -			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
 +		if (GPIO_EDGE_SEL >= 0) {
 +			edge = GPIO_INT_BOTH_EDGES;
  		} else {
 -			edge = GPIO_INT_HIGH_LEV;
 -			pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
 +			val = gpio_get_value(gpio);
 +			if (val) {
 +				edge = GPIO_INT_LOW_LEV;
 +				pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
 +			} else {
 +				edge = GPIO_INT_HIGH_LEV;
 +				pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
 +			}
- 			port->both_edges |= 1 << (gpio & 31);
++			port->both_edges |= 1 << gpio_idx;
  		}
 -		port->both_edges |= 1 << gpio_idx;
  		break;
  	case IRQ_TYPE_LEVEL_LOW:
  		edge = GPIO_INT_LOW_LEV;
@@@ -208,24 -180,11 +208,24 @@@
  		return -EINVAL;
  	}
  
 -	reg += GPIO_ICR1 + ((gpio_idx & 0x10) >> 2); /* ICR1 or ICR2 */
 -	bit = gpio_idx & 0xf;
 -	val = readl(reg) & ~(0x3 << (bit << 1));
 -	writel(val | (edge << (bit << 1)), reg);
 +	if (GPIO_EDGE_SEL >= 0) {
 +		val = readl(port->base + GPIO_EDGE_SEL);
 +		if (edge == GPIO_INT_BOTH_EDGES)
- 			writel(val | (1 << (gpio & 0x1f)),
++			writel(val | (1 << gpio_idx),
 +				port->base + GPIO_EDGE_SEL);
 +		else
- 			writel(val & ~(1 << (gpio & 0x1f)),
++			writel(val & ~(1 << gpio_idx),
 +				port->base + GPIO_EDGE_SEL);
 +	}
 +
 +	if (edge != GPIO_INT_BOTH_EDGES) {
- 		reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
- 		bit = gpio & 0xf;
++		reg += GPIO_ICR1 + ((gpio_idx & 0x10) >> 2); /* ICR1 or ICR2 */
++		bit = gpio_idx & 0xf;
 +		val = readl(reg) & ~(0x3 << (bit << 1));
 +		writel(val | (edge << (bit << 1)), reg);
 +	}
 +
- 	writel(1 << (gpio & 0x1f), port->base + GPIO_ISR);
+ 	writel(1 << gpio_idx, port->base + GPIO_ISR);
  
  	return 0;
  }
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120709/490f1697/attachment.sig>

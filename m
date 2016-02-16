From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Feb 2016 08:50:24 +0000
Subject: [PATCH v2 4/5] irqchip:create irq domain for each mbigen device
In-Reply-To: <1455604648-20668-5-git-send-email-majun258@huawei.com>
References: <1455604648-20668-1-git-send-email-majun258@huawei.com>
 <1455604648-20668-5-git-send-email-majun258@huawei.com>
Message-ID: <20160216085024.3f573f40@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016 14:37:27 +0800
MaJun <majun258@huawei.com> wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> For peripheral devices which connect to mbigen,mbigen is a interrupt
> controller. So, we create irq domain for each mbigen device and add
> mbigen irq domain into irq hierarchy structure.
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen-v1.c |  136 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 136 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen-v1.c b/drivers/irqchip/irq-mbigen-v1.c
> index 9445658..61e7ad0 100644
> --- a/drivers/irqchip/irq-mbigen-v1.c
> +++ b/drivers/irqchip/irq-mbigen-v1.c
> @@ -16,11 +16,30 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +/* The maximum IRQ pin number of mbigen chip(start from 0) */
> +#define MAXIMUM_IRQ_PIN_NUM		640
> +
> +/**
> + * In mbigen vector register
> + * bit[31:16]:	device id
> + * bit[15:0]:	event id value
> + */
> +#define IRQ_EVENT_ID_MASK		0xffff
> +
> +/* offset of vector register in mbigen node */
> +#define REG_MBIGEN_VEC_OFFSET		0x300
> +#define REG_MBIGEN_EXT_VEC_OFFSET		0x320
> +
>  /**
>   * struct mbigen_device - holds the information of mbigen device.
>   *
> @@ -32,10 +51,112 @@ struct mbigen_device {
>  	void __iomem		*base;
>  };
>  
> +static int get_mbigen_nid(unsigned int offset)
> +{
> +	int nid = 0;
> +
> +	if (offset < 256)
> +		nid = offset / 64;
> +	else if (offset < 384)
> +		nid = 4;
> +	else if (offset < 640)
> +		nid = 5;
> +
> +	return nid;
> +}
> +
> +static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
> +{
> +	unsigned int nid;
> +
> +	nid = get_mbigen_nid(hwirq);
> +
> +	if (nid < 4)
> +		return (nid * 4) + REG_MBIGEN_VEC_OFFSET;
> +	else
> +		return (nid - 4) * 4 + REG_MBIGEN_EXT_VEC_OFFSET;
> +}
> +
> +static struct irq_chip mbigen_irq_chip = {
> +	.name =			"mbigen-v1",
> +};
> +
> +static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	/* The address of doorbell is encoded in mbigen register by default
> +	 * So,we don't need to program the doorbell address at here
> +	 * Besides, the event ID is decided by the hardware pin number,
> +	 * we can't change it in software.So, we don't need to encode the
> +	 * event ID in mbigen register.
> +	 */

Really? What if tomorrow I decide to change the EventID allocation
policy in the ITS driver? Have your HW engineers really baked the
behaviour of the Linux driver into the device?

I'm puzzled.

	M.
-- 
Jazz is not dead. It just smells funny.

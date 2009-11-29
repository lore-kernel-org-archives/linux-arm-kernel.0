From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Nov 2009 12:16:14 +0000
Subject: [PATCH V2] ARM: NUC900: add GDMA driver support for nuc900
	platform
In-Reply-To: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
References: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
Message-ID: <20091129121614.GA11445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some comments below.

On Thu, Nov 26, 2009 at 06:42:12PM +0800, Hu Ruihuan wrote:
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +
> +#include <asm/system.h>

You shouldn't need asm/system.h

> +#include <asm/irq.h>
> +#include <asm/atomic.h>
> +#include <mach/hardware.h>
> +
> +#define NUC900_DMA_CHANNELS           (2)
> +#define DMA_BASE                               (W90X900_VA_GDMA)
> +#define GDMA_INTCS                             (DMA_BASE + 0xa0)
> +
> +#define GDMA_GDGA                              (0x1c)
> +#define TC0F                                   (0x01 << 8)
> +#define TC1F                                   (0x01 << 10)
> +#define ENTC0F                                 (0x01)
> +#define ENTC1F                                 (0x01 << 2)
> +
> +#define GDMAEN                                 (0x01)
> +#define GDMAMS                                 (0x03 << 2)
> +#define DADIR                                  (0x01 << 4)
> +#define SADIR                                  (0x01 << 5)
> +#define DAFIX                                  (0x01 << 6)
> +#define SAFIX                                  (0x01 << 7)
> +#define D_INTS                                 (0x01 << 10)
> +#define TWSMASK                                (0x03 << 12)
> +#define TWS                                    (0x02 << 12)
> +
> +#define RUN                                    (0x01 << 3)
> +#define NON_DSCRIP                             (0x01 << 2)
> +#define ORDEN                                  (0x01 << 1)
> +#define RESET                                  (0x01)
> +#define DSCRIPMASK                             (0x0F)
> +#define CMDINFOMASK                            (0x03FFF)
> +
> +#define COUTN_TRANSFER                         (0x1000)/*count[13:0]=1024*/
> +#define CHANNELINERV                           (0x20)
> +
> +typedef void (*dma_callback_t)(void *data);
> +
> +struct nuc900_dma_descp {
> +       unsigned int next_descp;
> +       unsigned int srcaddr;
> +       unsigned int dstaddr;
> +       unsigned int commandinfo;
> +};
> +
> +struct nuc900_dma_t {
> +       const char *device;             /* this channel device, 0  if unused */
> +       dma_callback_t callback;        /* to call when DMA completes */
> +       void __iomem *dma_reg;
> +       void *data;                     /* ... with private data ptr */
> +       struct nuc900_dma_descp *descp;
> +};
> +
> +static struct nuc900_dma_t dma_chan[nuc900_DMA_CHANNELS];
> +static struct nuc900_dma_t *dmachan0, *dmachan1;
> +static atomic_t  shared_irq_using;
> +static spinlock_t dma_chan_lock;

Maybe consider using DEFINE_SPINLOCK(dma_chan_lock) ?

> +
> +
> +
> +static int register_dmachan_fromname(const char *dev_name,
> +                       struct nuc900_dma_t *dma, unsigned int *irq_request)
> +{
> +       int err;
> +
> +       BUG_ON(!dev_name);
> +
> +       err = 0;
> +
> +       if (!(dmachan0->device) && !(dmachan1->device)) {
> +               dma = dmachan0;
> +               *irq_request = 1;
> +       } else if ((dmachan0->device) && !(dmachan1->device)) {
> +                       if (strcmp(dmachan0->device, dev_name) == 0)
> +                               err = -EBUSY;
> +                       else
> +                               dma = dmachan1;
> +       } else if ((dmachan1->device) && !(dmachan0->device)) {
> +                       if (strcmp(dmachan1->device, dev_name) == 0)
> +                               err = -EBUSY;
> +                       else
> +                               dma = dmachan0;
> +       } else
> +               err = -EBUSY;
> +
> +       return err;
> +
> +}

Again, this initializes the local 'dma' pointer but doesn't return it.
If you want to be able to return a pointer as well as an error code,
try using linux/err.h:

struct nuc900_dma_t *register_dma_from_chan(const char *dev_name,
		unsigned int *irq_request)
{
	struct nuc900_dma_t *ret;
	...
		if (strcmp(dmachanX->device, dev_name) == 0)
			ret = ERR_PTR(-EBUSY);
		else
			ret = dmachan1;
	...
	return ret;
}

and use it as:

	struct nuc900_dma_t *dma;

	dma = register_dma_from_chan(...);
	if (IS_ERR(dma)) {
		err = PTR_ERR(dma);
		return err;
	}

This has advantages over the 'return via pointer-to-pointer in function
arguments' in that you can't end up with errors where your pointer is
not initialized.

> +
> +static void match_dmachan_fromname(const char *dev_name,
> +                                       struct nuc900_dma_t *dma)
> +{
> +       BUG_ON(!dev_name);
> +
> +       if (dmachan1->device) {
> +               if (strcmp(dmachan1->device, dev_name) == 0)
> +                       dma = dmachan1;
> +       } else if (dmachan0->device) {
> +               if (strcmp(dmachan0->device, dev_name) == 0)
> +                       dma = dmachan0;
> +       }

This code doesn't actually do anything - 'dma' is a local pointer which
you're initializing but not using.

> +}
> +
> +static irqreturn_t dma_irq_handler(int irq, void *dev_id)
> +{
> +       int status;
> +       local_irq_disable();
> +       status = __raw_readl(GDMA_GDGA);
> +
> +       if (status & (TC0F)) {
> +               __raw_writel((~TC0F), GDMA_GDGA);
> +               local_irq_enable();
> +               dmachan0->callback(dmachan0->data);
> +       }
> +
> +       if (status & (TC1F)) {
> +               __raw_writel((~TC1F), GDMA_GDGA);
> +               local_irq_enable();
> +               dmachan1->callback(dmachan1->data);
> +       }

if both TC0F and TC1F are both set, you'll write ~TC0F with IRQs disabled
but ~TC1F with IRQs enabled.  Wouldn't something like:

	local_irq_disable();
	status = __raw_readl(GDMA_GDGA) & (TC0F|TC1F);
	__raw_writel(~status, GDMA_GDGA);
	local_irq_enable();

	if (status & TC0F)
		dmachan0->callback(dmachan0->data);
	if (status & TC1F)
		dmachan1->callback(dmachan1->data);

be better?

> +
> +       return IRQ_HANDLED;
> +}
> +
> +int nuc900_request_dma(const char *dev_name, dma_callback_t callback,
> +                                                               void *data)
> +{
> +       struct nuc900_dma_t *dma = NULL;
> +       int err, irq_request;
> +
> +       err = 0;
> +       irq_request = 0;
> +       spin_lock(&dma_chan_lock);
> +       err = register_dmachan_fromname(dev_name, dma, &irq_request);
> +
> +       if (err < 0) {
> +               spin_unlock(&dma_chan_lock);
> +               return err;
> +       }
> +
> +       dma->device = dev_name;
> +
> +       if (irq_request) {
> +               err = request_irq(IRQ_GDMAGROUP, dma_irq_handler, IRQF_SHARED|
> +                               IRQF_DISABLED, NULL, NULL);

Not sure why you don't claim this at initialization time.

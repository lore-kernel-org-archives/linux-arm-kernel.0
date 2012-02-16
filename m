From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Feb 2012 23:35:33 -0700
Subject: [PATCH 2/5] gpio/omap: Use devm_ API and add request_mem_region
In-Reply-To: <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-3-git-send-email-b-cousson@ti.com>
 <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
Message-ID: <20120216063533.GA29232@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 11:11:52AM +0530, DebBarma, Tarun Kanti wrote:
> Hi Benoit,
> 
> On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> > Replace the regular kzalloc and ioremap with the devm_ equivalent
> > to simplify error handling.
> >
> > Add the missing devm_request_mem_region to reserve the region used
> > by the driver.
> >
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > ---
> > ?drivers/gpio/gpio-omap.c | ? 35 +++++++++++++++--------------------
> > ?1 files changed, 15 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index a0c3e03..c3a9dc8 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -19,7 +19,7 @@
> > ?#include <linux/err.h>
> > ?#include <linux/clk.h>
> > ?#include <linux/io.h>
> > -#include <linux/slab.h>
> > +#include <linux/device.h>
> > ?#include <linux/pm_runtime.h>
> > ?#include <linux/pm.h>
> >
> > @@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
> > ? ? ? ?struct gpio_bank *bank;
> > ? ? ? ?int ret = 0;
> >
> > - ? ? ? if (!dev->platform_data) {
> > - ? ? ? ? ? ? ? ret = -EINVAL;
> > - ? ? ? ? ? ? ? goto err_exit;
> > - ? ? ? }
> > + ? ? ? if (!dev->platform_data)
> > + ? ? ? ? ? ? ? return -EINVAL;
> >
> > - ? ? ? bank = kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
> > + ? ? ? bank = devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank), GFP_KERNEL);
> > ? ? ? ?if (!bank) {
> > ? ? ? ? ? ? ? ?dev_err(dev, "Memory alloc failed\n");
> > - ? ? ? ? ? ? ? ret = -ENOMEM;
> > - ? ? ? ? ? ? ? goto err_exit;
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > ? ? ? ?}
> >
> > ? ? ? ?res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > ? ? ? ?if (unlikely(!res)) {
> > ? ? ? ? ? ? ? ?dev_err(dev, "Invalid IRQ resource\n");
> > - ? ? ? ? ? ? ? ret = -ENODEV;
> > - ? ? ? ? ? ? ? goto err_free;
> > + ? ? ? ? ? ? ? return -ENODEV;
> How is the memory allocated to 'bank' getting freed before return -ENODEV?

The magic of devm_*() functions.  Anything allocated by those functions is
automatically freed on either probe failure or driver removal.

g.

From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 9 Sep 2014 16:52:09 +0300
Subject: [PATCH 1/2] acpi: lpss: convert from struct clk to struct clk_core
In-Reply-To: <7263163.khRHYpcBRO@vostro.rjw.lan>
References: <1410242868-14750-1-git-send-email-mturquette@linaro.org>
 <1410242868-14750-2-git-send-email-mturquette@linaro.org>
 <7263163.khRHYpcBRO@vostro.rjw.lan>
Message-ID: <20140909135209.GW13406@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 03:16:29PM +0200, Rafael J. Wysocki wrote:
> On Monday, September 08, 2014 11:07:47 PM Mike Turquette wrote:
> > Looks like this driver was missed during the original mass driver
> > rework[0]. This patch converts the LPSS driver to the new clock provider
> > data type (struct clk_core).
> > 
> > If there are no objections I propose to roll this patch into a rebase of
> > that patch[0] in my tree.
> > 
> > [0] http://lkml.kernel.org/r/<1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
> > 
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> 
> Mika, any comments here?

Adding Heikki who recently did some clock changes to acpi_lpss.c.

To me this looks fine.

> 
> > ---
> >  drivers/acpi/acpi_lpss.c               | 6 +++---
> >  include/linux/platform_data/clk-lpss.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > index 9dfec48..454179f 100644
> > --- a/drivers/acpi/acpi_lpss.c
> > +++ b/drivers/acpi/acpi_lpss.c
> > @@ -57,7 +57,7 @@ ACPI_MODULE_NAME("acpi_lpss");
> >  struct lpss_shared_clock {
> >  	const char *name;
> >  	unsigned long rate;
> > -	struct clk *clk;
> > +	struct clk_core *clk;
> >  };
> >  
> >  struct lpss_private_data;
> > @@ -83,7 +83,7 @@ static struct lpss_device_desc lpss_dma_desc = {
> >  struct lpss_private_data {
> >  	void __iomem *mmio_base;
> >  	resource_size_t mmio_size;
> > -	struct clk *clk;
> > +	struct clk_core *clk;
> >  	const struct lpss_device_desc *dev_desc;
> >  	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
> >  };
> > @@ -278,7 +278,7 @@ static int register_device_clock(struct acpi_device *adev,
> >  	const struct lpss_device_desc *dev_desc = pdata->dev_desc;
> >  	struct lpss_shared_clock *shared_clock = dev_desc->shared_clock;
> >  	const char *devname = dev_name(&adev->dev);
> > -	struct clk *clk = ERR_PTR(-ENODEV);
> > +	struct clk_core *clk = ERR_PTR(-ENODEV);
> >  	struct lpss_clk_data *clk_data;
> >  	const char *parent, *clk_name;
> >  	void __iomem *prv_base;
> > diff --git a/include/linux/platform_data/clk-lpss.h b/include/linux/platform_data/clk-lpss.h
> > index 2390199..3c3237c 100644
> > --- a/include/linux/platform_data/clk-lpss.h
> > +++ b/include/linux/platform_data/clk-lpss.h
> > @@ -15,7 +15,7 @@
> >  
> >  struct lpss_clk_data {
> >  	const char *name;
> > -	struct clk *clk;
> > +	struct clk_core *clk;
> >  };
> >  
> >  extern int lpt_clk_init(void);
> > 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 7 Nov 2016 13:57:35 +0000
Subject: [PATCH v10 01/11] remoteproc: st_slim_rproc: add a slimcore
 rproc driver
In-Reply-To: <20161103213703.GA15449@tuxbot>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
 <1476783556-2501-2-git-send-email-peter.griffin@linaro.org>
 <20161103213703.GA15449@tuxbot>
Message-ID: <20161107135735.GA27280@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, 03 Nov 2016, Bjorn Andersson wrote:

> On Tue 18 Oct 02:39 PDT 2016, Peter Griffin wrote:
> 
> > slim core is used as a basis for many IPs in the STi
> > chipsets such as fdma and demux. To avoid duplicating
> > the elf loading code in each device driver a slim
> > rproc driver has been created.
> > 
> > This driver is designed to be used by other device drivers
> > such as fdma, or demux whose IP is based around a slim core.
> > The device driver can call slim_rproc_alloc() to allocate
> > a slim rproc and slim_rproc_put() when finished.
> > 
> > This driver takes care of ioremapping the slim
> > registers (dmem, imem, slimcore, peripherals), whose offsets
> > and sizes can change between IP's. It also obtains and enables
> > any clocks used by the device. This approach avoids having
> > a double mapping of the registers as slim_rproc does not register
> > its own platform device. It also maps well to device tree
> > abstraction as it allows us to have one dt node for the whole
> > device.
> > 
> > All of the generic rproc elf loading code can be reused, and
> > we provide start() stop() hooks to start and stop the slim
> > core once the firmware has been loaded. This has been tested
> > successfully with fdma driver.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/remoteproc/Kconfig               |   7 +-
> >  drivers/remoteproc/Makefile              |   1 +
> >  drivers/remoteproc/st_slim_rproc.c       | 364 +++++++++++++++++++++++++++++++
> >  include/linux/remoteproc/st_slim_rproc.h |  58 +++++
> >  4 files changed, 428 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/remoteproc/st_slim_rproc.c
> >  create mode 100644 include/linux/remoteproc/st_slim_rproc.h
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index f396bfe..9270c8e 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -58,7 +58,6 @@ config DA8XX_REMOTEPROC
> >  	tristate "DA8xx/OMAP-L13x remoteproc support"
> >  	depends on ARCH_DAVINCI_DA8XX
> >  	select CMA if MMU
> > -	select REMOTEPROC
> 
> No, this is an unrelated change to this patch.

Sorry that crept in as part of the rebase. Will fix.
> 
> >  	select RPMSG_VIRTIO
> >  	help
> >  	  Say y here to support DA8xx/OMAP-L13x remote processors via the
> > @@ -99,10 +98,10 @@ config QCOM_WCNSS_PIL
> >  	tristate "Qualcomm WCNSS Peripheral Image Loader"
> >  	depends on OF && ARCH_QCOM
> >  	depends on QCOM_SMEM
> > +	depends on REMOTEPROC
> >  	select QCOM_MDT_LOADER
> >  	select QCOM_SCM
> >  	select QCOM_WCNSS_IRIS
> > -	select REMOTEPROC
> 
> Dito.

Will fix.

> 
> 
> As you now make changes to the entire remoteproc Kconfig file, rather
> than simply add a Kconfig symbol we can't bring this in via Vinod's tree
> without providing Linus with a messy merge conflict.
> 
> So the remoteproc parts now has to go through my tree.

OK, I think the best approach is for Vinod to create an immutable
branch with the entire fdma series on, and then both of you merge that branch into
your respective trees.

That way there won't be any conflicts and you can both accept further changes
for v4.9 release. Trying to take half the series via rproc, and half via dma trees won't work
because they have dependencies on each other.

I will send a v11 series in a moment which includes the feedback in this email
and also include the additional fixes which Vinod has applied since the driver
has been in linux-next.

> 
> >  	help
> >  	  Say y here to support the Peripheral Image Loader for the Qualcomm
> >  	  Wireless Connectivity Subsystem.
> > @@ -116,4 +115,8 @@ config ST_REMOTEPROC
> >  	  processor framework.
> >  	  This can be either built-in or a loadable module.
> >  
> > +config ST_SLIM_REMOTEPROC
> > +	tristate
> > +	select REMOTEPROC
> > +
> >  endmenu
> [..]
> > diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> [..]
> > +struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
> > +				char *fw_name)
> > +{
> [..]
> > +	rproc = rproc_alloc(dev, np->name, &slim_rproc_ops,
> > +			fw_name, sizeof(*slim_rproc));
> [..]
> > +	rproc_put(rproc);
> 
> As of v4.9 you need to rproc_free() rather than rproc_put() to undo
> rproc_alloc().

Will fix.

regards,

Peter.

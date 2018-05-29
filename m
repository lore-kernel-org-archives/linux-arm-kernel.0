From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 May 2018 10:59:45 +0200
Subject: [PATCH] PM / runtime: Fixup reference counting of device link
 suppliers at probe
In-Reply-To: <CAPDyKFphMCQ_S5aBVToGUL=Rvd0cBQ4O3Top3AYPdM79Ak_LzA@mail.gmail.com>
References: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0ikXsWdXq-h8rWLd-vfzi-gFmxyHmOGvRvDUoJHC3L2XA@mail.gmail.com>
 <CAPDyKFphMCQ_S5aBVToGUL=Rvd0cBQ4O3Top3AYPdM79Ak_LzA@mail.gmail.com>
Message-ID: <1602619.cydcNSDU3f@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 18, 2018 11:07:02 AM CEST Ulf Hansson wrote:
> On 18 May 2018 at 10:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, May 18, 2018 at 10:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> In the driver core, before it invokes really_probe() it runtime resumes the
> >> suppliers for the device via calling pm_runtime_get_suppliers(), which also
> >> increases the runtime PM usage count for each of the available supplier.
> >>
> >> This makes sense, as to be able to allow the consumer device to be probed
> >> by its driver. However, if the driver decides to add a new supplier link
> >> during ->probe(), hence updating the list of suppliers,
> >
> > Do any of the existing drivers do that?
> 
> Yes.
> 
> At least these, but possibly even more...
> 
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> drivers/gpu/drm/tegra/dc.c
> drivers/gpu/ipu-v3/ipu-prg.c
> drivers/pci/dwc/pci-dra7xx.c
> 
> >
> >> the following call to pm_runtime_put_suppliers(), invoked after really_probe()
> >> in the driver core, we get into trouble.

Patch applied, thanks!

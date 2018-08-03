From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Fri, 3 Aug 2018 18:07:09 +0000
Subject: [RFC] PCI: imx: Add multi-pd support
In-Reply-To: <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
References: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
 <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
Message-ID: <53f9f939dbce11e1c96986ff41f29dd6e41b9220.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-31 at 10:32 +0200, Ulf Hansson wrote:
> On 24 July 2018 at 20:17, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> > which can be power-gated independently. The driver needs to handle this
> > by keeping both domain active.
> > 
> > This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
> > it's own domain. Defining the DISPMIX domain requires a way for pcie to
> > keep it active or it will break when displays are off.
> > 
> > The power-domains on imx6sx are meant to look like this:
> >         power-domains = <&pd_disp>, <&pd_pci>;
> >         power-domain-names = "pcie", "pcie_phy";
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for taking the time to look at this, I will likely repost this
as PATCH in a series later.

> > Right now if a device has a single power domain it will be activated
> > before probe but if it has multiple domains they need to be explicitly
> > "attached" to and controlled. Supporting both is a bit awkward, this
> > patch makes the distinction based on (dev->pm_domain != NULL).
> > 
> > Maybe the PM core should make this distinction based on a flag in struct
> > device_driver instead of number of power-domains? So by default when a
> > device has multiple power domains they would would be activated
> > together and this patch would be unnecessary.
> 
> Activation is deliberately left to be manged by each user, as the PM
> core/genpd can't know when powering on the PM domains make sense.

By default the PM core could treat a list of pm domains just like it
treats a domain now. My patch doesn't do anything pci-specific, it just
attaches all domains and creates device links. Couldn't the core do
this?

> The main reason to why genpd powers on the PM domain for the single PM
> domain case, is because of legacy behaviors in drivers.

Wouldn't it be nicer to out-out of such legacy behaviors with a flag in
struct driver instead of single-versus-multiple domains?

> > The device_link is marked as "STATELESS" because otherwise a warning is
> > triggered in device_links_driver_bound. This seems to happen because the
> > pd devices are always marked as "DL_DEV_NO_DRIVER". Maybe they should be
> > instead always be marked as DL_DEV_DRIVER_BOUND?
> 
> Using STATELESS is correct, because the supplier devices, which are
> managed by genpd don't have any driver attached to them.

As far as I can tell these genpd_dev devices need to be manually
unregistered in the consumer's remove function, right? If they were
marked with DL_DEV_DRIVER_BOUND then you could use
DL_FLAG_AUTOREMOVE_SUPPLIER on them.

As far as I can tell the DL_DEV_* states are used to deal with probing
order but since no driver will ever bind to these suppliers we could
treat them as effectively always bounds.


Perhaps this can be revisited later, imx-pci is not a very good usecase
for this because it doesn't even support remove.

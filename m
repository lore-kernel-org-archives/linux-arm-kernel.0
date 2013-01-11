From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 11 Jan 2013 16:59:40 +0100
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50EFC8DB.6090903@nvidia.com>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <50EDD693.2060905@wwwdotorg.org> <50EFC8DB.6090903@nvidia.com>
Message-ID: <2615017.79obOGziy2@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 13:40:03 Prashant Gaikwad wrote:
> On Thursday 10 January 2013 02:14 AM, Stephen Warren wrote:
> > On 01/09/2013 10:34 AM, Stephen Warren wrote:

...

> > Second, the Toshiba AC100 uses an alternative driver for the I2C HW,
> > since it operates in I2C slave mode. So, the DT node for that driver
> > needs to include the clocks properties so the driver can get the clocks
> > 
> > through DT:
> >> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> >> b/arch/arm/boot/dts/tegra20-paz00.dts index edef66c..6495425 100644
> >> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> >> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> >> @@ -278,6 +278,8 @@
> >> 
> >>                  clock-frequency = <50000>;
> >>                  request-gpios = <&gpio 170 0>; /* gpio PV2 */
> >>                  slave-addr = <138>;
> >> 
> >> +               clocks = <&tegra_car 67>, <&tegra_car 124>;
> >> +               clock-names = "div-clk", "fast-clk";
> >> 
> >>          };
> >>          
> >>          i2c at 7000d000 {
> > 
> > Your changes don't actually cause the driver to break though, since it
> > abuses clk_get_sys() to retrieve clocks under a different driver name,
> > which matches what the clock driver provides. However, I think you
> > should also include the following patch at the end of your series to fix
> > 
> > this up, so the clock looking happens through device tree:
> >> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> >> index d8826ed..6d44076 100644
> >> --- a/drivers/staging/nvec/nvec.c
> >> +++ b/drivers/staging/nvec/nvec.c
> >> @@ -770,7 +770,7 @@ static int tegra_nvec_probe(struct platform_device
> >> *pdev)>> 
> >>                  return -ENODEV;
> >>          
> >>          }
> >> 
> >> -       i2c_clk = clk_get_sys("tegra-i2c.2", "div-clk");
> >> +       i2c_clk = clk_get(&pdev->dev, "div-clk");
> >> 
> >>          if (IS_ERR(i2c_clk)) {
> >>          
> >>                  dev_err(nvec->dev, "failed to get controller clock\n");
> >>                  return -ENODEV;
> 
> Included in the latest patches sent.

em, not yet in V4. Maybe you can also adjust the TODO (2nd entry) file now 
that this issue is fixed.

Thanks for taking care of this.

Marc

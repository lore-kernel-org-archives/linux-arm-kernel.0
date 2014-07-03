From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 3 Jul 2014 09:07:58 +0100
Subject: [PATCH 3/5] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <53B3DCBC.8000105@ti.com>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
 <1404133317-25953-4-git-send-email-lee.jones@linaro.org>
 <53B3DCBC.8000105@ti.com>
Message-ID: <20140703080758.GI30534@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jul 2014, Kishon Vijay Abraham I wrote:
> On Monday 30 June 2014 06:31 PM, Lee Jones wrote:
> > The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > devices. It has 2 ports which it can use for either; both SATA, both
> > PCIe or one of each in any configuration.
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Removed.

> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/phy/Kconfig         |  10 +
> >  drivers/phy/Makefile        |   1 +
> >  drivers/phy/phy-miphy365x.c | 630 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 641 insertions(+)
> >  create mode 100644 drivers/phy/phy-miphy365x.c

[...]

> > +struct miphy365x_dev {
> > +	struct device *dev;
> > +	struct mutex miphy_mutex;
> > +	struct miphy365x phys[ARRAY_SIZE(ports)];
> 
> Avoid using fixed array sizes for ports or channels. Refer [1].

Just addressing this point in this mail.  Any other subsequent points
will either be fixed up or addressed in other correspondence.

I don't agree with this point.  I don't believe the number of channels
should be dictated by the number of DT sub-nodes supplied.  Instead,
the driver should contain knowledge about what is supported and
validate the DT data accordingly.  If it's omitted we lose the ability
to conduct any kind of bounds checking, such like the following: 

        if (WARN_ON(port >= ARRAY_SIZE(ports)))
                return ERR_PTR(-EINVAL);
And
        if (child_count != ARRAY_SIZE(ports)) {
                dev_err(&pdev->dev, "%d ports supported, %d supplied\n",
                        ARRAY_SIZE(ports), child_count);
                return -EINVAL;
        }

If at a later point, we need to expand the driver to support a new
chip which supports more channels/ports then we need to expand the
bounds checking based on match data extracted from the supplied
compatible string.  For instance, if a 4 port controller is being used
and only 2 channels have been supplied, or vice versa then probe()
should fail.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

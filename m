From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Sep 2014 09:35:39 -0500
Subject: [PATCH 1/5] usb: dwc3: exynos: Add support for SCLK present on
 Exynos7
In-Reply-To: <CAFp+6iHLSaUjHqaKXXX0QLiRd3h+O67DRSQdExag-KUH0dnpag@mail.gmail.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-2-git-send-email-gautam.vivek@samsung.com>
 <20140828184847.GA18464@leverpostej>
 <CAFp+6iHLSaUjHqaKXXX0QLiRd3h+O67DRSQdExag-KUH0dnpag@mail.gmail.com>
Message-ID: <20140902143539.GC16872@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 04:09:08PM +0530, Vivek Gautam wrote:
> Hi,
> 
> 
> On Fri, Aug 29, 2014 at 12:18 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Aug 28, 2014 at 09:01:56AM +0100, Vivek Gautam wrote:
> >> Exynos7 also has a separate special gate clock going to the IP
> >> apart from the usual AHB clock. So add support for the same.
> >>
> >> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> >> ---
> >>  drivers/usb/dwc3/dwc3-exynos.c |   16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> >> index f9fb8ad..bab6395 100644
> >> --- a/drivers/usb/dwc3/dwc3-exynos.c
> >> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> >> @@ -35,6 +35,7 @@ struct dwc3_exynos {
> >>       struct device           *dev;
> >>
> >>       struct clk              *clk;
> >> +     struct clk              *sclk;
> >>       struct regulator        *vdd33;
> >>       struct regulator        *vdd10;
> >>  };
> >> @@ -141,10 +142,17 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
> >>               return -EINVAL;
> >>       }
> >>
> >> +     /* Exynos7 has a special gate clock going to this IP */
> >> +     exynos->sclk = devm_clk_get(dev, "usbdrd30_sclk");
> >> +     if (IS_ERR(exynos->sclk))
> >> +             dev_warn(dev, "couldn't get sclk\n");
> >
> > Doesn't this introduce a pointless warning for Exynos SoCs other than
> > Exynos7?
> 
> True, it will introduce an unnecessary warning for non-Exynos7 systems.
> I initially thought of introducing a compatible check for Exynos7-dwc3, but that
> way we may end up adding such checks for future SoCs which have similar
> controller but have some clock difference or some other small change, no ?

maybe dev_dbg() is what you want ? :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/0dde8948/attachment.sig>

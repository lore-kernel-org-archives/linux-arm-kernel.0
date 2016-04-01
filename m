From: b-liu@ti.com (Bin Liu)
Date: Fri, 1 Apr 2016 14:56:35 -0500
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <56FECFEB.2030708@cogentembedded.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com> <20160401144510.GA6264@uda0271908>
 <56FE9B8F.7050605@lechnology.com>
 <56FECFEB.2030708@cogentembedded.com>
Message-ID: <20160401195635.GA29841@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 01, 2016 at 10:45:47PM +0300, Sergei Shtylyov wrote:
> On 04/01/2016 07:02 PM, David Lechner wrote:
> 
> >>>>+EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
> >>>
> >>>Don't prefer export symbols from PHY driver. That'll create unnecessary
> >>>dependencies between the controller and the PHY.
> >>
> >>Agreed.
> >>
> >>>I think it'll be better to create a new attribute and use it?
> >>
> >>Another simpler option is to not support _set_mode() for DA8xx, and the
> >>phy driver set the otgmode bit in probe() based on dr_mode of the
> >>controller.
> >>
> >>Regards,
> >>-Bin.
> >
> >This certainly works for my particular use case, however, Sergei Shtylyov, who
> >wrote the da8xx musb glue layer originally, seemed to recall in his review of
> >the patch series that this really is necessary for OTG mode to work properly.
> 
>    No, it's still not necessary, however this method is now called
> from musb_init_controller() (it wasn't in my time). ISTR however
> that you needed to enforce the mode override in CFGCHIP2 for the
> host mode to function properly.

Yes, but I think we don't have to rely on musb_init_controller(), what
we can do is the phy probe() calls of_usb_get_dr_mode_by_phy() to get
the dr_mode of the controller then sets CFGCHIP2 bits accordingly, so
that we can drop _set_mode() in the phy driver.

Regards,
-Bin.

From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 09:47:00 +0200
Subject: [V7 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <CADApbei9u2LLSgA7E0vwRZ-iKAh7usqETzrsMSqdT5+6WZ3y+w@mail.gmail.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
 <1361167838-22929-2-git-send-email-chao.xie@marvell.com>
 <5121CD94.4060109@ti.com>
 <CADApbei9u2LLSgA7E0vwRZ-iKAh7usqETzrsMSqdT5+6WZ3y+w@mail.gmail.com>
Message-ID: <20130218074700.GD29848@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 02:58:29PM +0800, Chao Xie wrote:
> >> +static unsigned int u2o_get(void __iomem *base, unsigned int offset)
> >> +{
> >> +       return readl(base + offset);
> >> +}
> >> +
> >> +static void u2o_set(void __iomem *base, unsigned int offset,
> >> +               unsigned int value)
> >> +{
> >> +       u32 reg;
> >> +
> >> +       reg = readl(base + offset);
> >> +       reg |= value;
> >> +       writel(reg, base + offset);
> >> +       readl(base + offset);
> >
> >
> > spurious readl.
> >
> Writing to the PHY setting registers has to make sure that every
> writing has been issued already.
> The design engineer suggest us to add reading after the writing. It
> can make sure the writing has
> taken effect.

add a comment explaining that, then.

> >> +               _mv_usb2_phy_shutdown(mv_phy);
> >> +               for (i = 0; i < mv_phy->clks_num; i++)
> >> +                       clk_disable_unprepare(mv_phy->clks[i]);
> >> +       }
> >> +       usb_add_phy_dev(&mv_phy->phy);
> >> +
> >> +       platform_set_drvdata(pdev, mv_phy);
> >> +
> >> +       dev_info(&pdev->dev, "mv usb2 phy initialized\n");
> >
> >
> > dev_info makes the boot log noisy.
> >
> It is the only print in boot log for usb phy.
> I can change it to be dev_dbg.

you can manage completely without it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/bc2d6fad/attachment.sig>

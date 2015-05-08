From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 May 2015 14:51:02 +0200
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CABuKBeJ=HrwNMvV5N+6pnBgbB9k7e=8UPi3WWBTnpRFeEbTWvA@mail.gmail.com>
References: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
 <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeLvBfeXw+b+SxAEjGA2dzPhYBs-SiJUyP5dUA28R=Rjkg@mail.gmail.com>
 <20150508121944.GD6325@pengutronix.de>
 <CABuKBeJ=HrwNMvV5N+6pnBgbB9k7e=8UPi3WWBTnpRFeEbTWvA@mail.gmail.com>
Message-ID: <20150508125102.GE6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:28:37PM +0200, Matthias Brugger wrote:
> 2015-05-08 14:19 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > On Fri, May 08, 2015 at 02:16:06PM +0200, Matthias Brugger wrote:
> >> 2015-03-10 16:41 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> >> > +static int scpsys_power_on(struct generic_pm_domain *genpd)
> >> > +{
> >> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
> >> > +       struct scp *scp = scpd->scp;
> >> > +       struct scp_domain_data *data = scpd->data;
> >> > +       unsigned long expired;
> >> > +       void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
> >> > +       u32 sram_pdn_ack = data->sram_pdn_ack_bits;
> >> > +       u32 val;
> >> > +       int ret;
> >> > +
> >> > +       val = readl(ctl_addr);
> >> > +       val |= PWR_ON_BIT;
> >> > +       writel(val, ctl_addr);
> >> > +       val |= PWR_ON_2ND_BIT;
> >> > +       writel(val, ctl_addr);
> >> > +
> >> > +       /* wait until PWR_ACK = 1 */
> >> > +       expired = jiffies + HZ;
> >> > +       while (!(readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
> >> > +                       !(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
> >> > +               cpu_relax();
> >> > +               if (time_after(jiffies, expired)) {
> >> > +                       ret = -EIO;
> >> > +                       goto out;
> >> > +               }
> >> > +       }
> >> > +
> >> > +       val &= ~PWR_CLK_DIS_BIT;
> >> > +       writel(val, ctl_addr);
> >> > +
> >> > +       val &= ~PWR_ISO_BIT;
> >> > +       writel(val, ctl_addr);
> >> > +
> >> > +       val |= PWR_RST_B_BIT;
> >> > +       writel(val, ctl_addr);
> >> > +
> >> > +       val &= ~data->sram_pdn_bits;
> >> > +       writel(val, ctl_addr);
> >> > +
> >> > +       /* wait until SRAM_PDN_ACK all 0 */
> >> > +       expired = jiffies + HZ;
> >> > +       while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
> >>
> >> I think "sram_pdn_ack &&" was added accidently here. It is always
> >> bigger then zero.
> >
> > Nope, it's zero for MT8173_POWER_DOMAIN_MFG_ASYNC.
> 
> In probe you turn on all power domains defined in scp_domain_data[].
> So all but MT8173_POWER_DOMAIN_MFG_ASYNC will fail.
> Does this make sense?

What makes you think that enabling the domains will fail? That doesn't
happen.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

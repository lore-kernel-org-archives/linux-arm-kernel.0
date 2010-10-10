From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 04:03:21 +0200
Subject: [PATCH 02/13] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <AANLkTikPa+5gp13mLdFYhvcwGdXuPU4th_9CxdFsoC4u@mail.gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
	<1286663971-15634-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTikPa+5gp13mLdFYhvcwGdXuPU4th_9CxdFsoC4u@mail.gmail.com>
Message-ID: <201010100403.22064.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 10. ??jna 2010 02:31:24 Haojian Zhuang napsal(a):
> On Sun, Oct 10, 2010 at 6:39 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This is important because on PXA3xx, the physical mapping of SMEMC
> > registers differs from the one on PXA2xx. In order to get PCMCIA working
> > on both PXA2xx and PXA320, the PCMCIA driver was adjusted accordingly as
> > well.
> > 
> > Also, various places in the kernel had to be patched to use
> > __raw_read/__raw_write.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---

[SNIP]
> > @@ -205,19 +218,18 @@ pxa2xx_pcmcia_frequency_change(struct
> > soc_pcmcia_socket *skt, static void pxa2xx_configure_sockets(struct
> > device *dev)
> >  {
> >        struct pcmcia_low_level *ops = dev->platform_data;
> > -
> >        /*
> >         * We have at least one socket, so set MECR:CIT
> >         * (Card Is There)
> >         */
> > -       MECR |= MECR_CIT;
> > +       uint32_t mecr = MECR_CIT;
> > 
> >        /* Set MECR:NOS (Number Of Sockets) */
> >        if ((ops->first + ops->nr) > 1 ||
> >            machine_is_viper() || machine_is_arcom_zeus())
> > -               MECR |= MECR_NOS;
> > -       else
> > -               MECR &= ~MECR_NOS;
> > +               mecr |= MECR_NOS;
> > +
> > +       __raw_writel(mecr, MECR);
> 
> In original, it only wants MECR |= MECR_NOS. But now, it becomes MECR
> = MECR_NOS. The meaning is changed.

The meaning is actually still the same, check the datasheet.

I admit the logic has changed a bit though.

Are you fine with having it this way ?

Cheers
> 
> >  }
> > 
> >  static const char *skt_names[] = {
> > @@ -272,14 +284,24 @@ static int pxa2xx_drv_pcmcia_probe(struct
> > platform_device *dev) struct soc_pcmcia_socket *skt;
> > 
> >        ops = (struct pcmcia_low_level *)dev->dev.platform_data;
> > -       if (!ops)
> > -               return -ENODEV;
> > +       if (!ops) {
> > +               ret = -ENODEV;
> > +               goto err0;
> > +       }
> > +
> > +       if (cpu_is_pxa320() && ops->nr > 1) {
> > +               dev_err(&dev->dev, "pxa320 supports only one pcmcia
> > slot"); +               ret = -EINVAL;
> > +               goto err0;
> > +       }
> > 
> >        pxa2xx_drv_pcmcia_ops(ops);
> > 
> >        sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
> > -       if (!sinfo)
> > -               return -ENOMEM;
> > +       if (!sinfo) {
> > +               ret = -ENOMEM;
> > +               goto err0;
> > +       }
> > 
> >        sinfo->nskt = ops->nr;
> > 
> > @@ -295,18 +317,19 @@ static int pxa2xx_drv_pcmcia_probe(struct
> > platform_device *dev)
> > 
> >                ret = pxa2xx_drv_pcmcia_add_one(skt);
> >                if (ret)
> > -                       break;
> > +                       goto err1;
> >        }
> > 
> > -       if (ret) {
> > -               while (--i >= 0)
> > -                       soc_pcmcia_remove_one(&sinfo->skt[i]);
> > -               kfree(sinfo);
> > -       } else {
> > -               pxa2xx_configure_sockets(&dev->dev);
> > -               dev_set_drvdata(&dev->dev, sinfo);
> > -       }
> > +       pxa2xx_configure_sockets(&dev->dev);
> > +       dev_set_drvdata(&dev->dev, sinfo);
> > 
> > +       return 0;
> > +
> > +err1:
> > +       while (--i >= 0)
> > +               soc_pcmcia_remove_one(&sinfo->skt[i]);
> > +       kfree(sinfo);
> > +err0:
> >        return ret;
> >  }
> > 
> > --
> > 1.7.1

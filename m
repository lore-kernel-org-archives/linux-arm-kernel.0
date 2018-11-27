From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 27 Nov 2018 09:37:23 +0100
Subject: [PATCH 2/2] gpio: mt7621: pass mediatek_gpio_bank_probe()
 failure up the stack
In-Reply-To: <CAGp9LzoNKmJvTccQd7Syi_XMew4Mhf_tXsMAAZ+asE5btH9Dag@mail.gmail.com>
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
 <1542823573-20228-2-git-send-email-hofrat@osadl.org>
 <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
 <20181127080113.GA2426@osadl.at>
 <CAGp9LzoNKmJvTccQd7Syi_XMew4Mhf_tXsMAAZ+asE5btH9Dag@mail.gmail.com>
Message-ID: <20181127083722.GA7641@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 12:32:59AM -0800, Sean Wang wrote:
> >
> > On Mon, Nov 26, 2018 at 11:49:26PM -0800, Sean Wang wrote:
> > > Nicholas Mc Guire <hofrat@osadl.org> ??? 2018???11???21??? ?????? ??????10:13?????????
> > > >
> > > > The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> > > > for the dev_err() messages). The probe function should return an error
> > > > if one of the banks failed to initialize properly.
> > > >
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> > > > ---
> > > >
> > > > Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
> > > > GPIOLIB=y, GPIO_MT7621=y
> > > >
> > > > Patch is against 4.20-rc3 (localversion-next is next-20181121)
> > > >
> > > >  drivers/gpio/gpio-mt7621.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> > > > index 1ec95bc..68fca8b 100644
> > > > --- a/drivers/gpio/gpio-mt7621.c
> > > > +++ b/drivers/gpio/gpio-mt7621.c
> > > > @@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
> > > >         struct device_node *np = dev->of_node;
> > > >         struct mtk *mtk;
> > > >         int i;
> > > > +       int ret;
> > > >
> > > >         mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
> > > >         if (!mtk)
> > > > @@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
> > > >         platform_set_drvdata(pdev, mtk);
> > > >         mediatek_gpio_irq_chip.name = dev_name(dev);
> > > >
> > > > -       for (i = 0; i < MTK_BANK_CNT; i++)
> > > > -               mediatek_gpio_bank_probe(dev, np, i);
> > > > +       for (i = 0; i < MTK_BANK_CNT; i++) {
> > > > +               ret = mediatek_gpio_bank_probe(dev, np, i);
> > > > +               if (!ret)
> > >
> > > it should be if (ret < 0) ?
> >
> > I don?t think so mediatek_gpio_bank_probe() returns 0 on success
> > and all other returns are error paths - while the current code
> > only returns negative values I do thik that any non 0 would be
> > an error indication so !ret should be fine here.
> >
> !0 would be true
>
...sorry - stupid me - thanks for catching that !

thx!
hofrat
 

From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Nov 2014 19:54:08 +0100
Subject: [PATCH] net: hisilicon: unmap IO resources when cleanup
In-Reply-To: <5479345A.20408@gmail.com>
References: <1417225690-135860-1-git-send-email-shengyong1@huawei.com>
 <5479345A.20408@gmail.com>
Message-ID: <4355983.Q40FtqNjx8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 November 2014 10:50:02 Orson Zhai wrote:
> On 2014?11?29? 09:48, Sheng Yong wrote:
> > Unmap IO resources if the driver initailization failed or the driver is
> > unmounted.
> >
> > Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> > ---
> >   drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> > index 0ffdcd3..3399ce6 100644
> > --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> > +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> > @@ -917,26 +917,26 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
> >       priv->ctrl_base = devm_ioremap_resource(dev, res);
> >       if (IS_ERR(priv->ctrl_base)) {
> >               ret = PTR_ERR(priv->ctrl_base);
> > -             goto out_free_netdev;
> > +             goto out_base;
> As i know we don't need to do anything but return error code from probe 
> when using devm_xxx for getting resource.
> What's the idea to io-unmap explicitly here?
> 

I think it's actually a bug to pair devm_ioremap() with iounmap,
since the iounmap will be done twice then, and that causes
undefined behavior.

In cases where you have to unmap something explicitly, devm_iounmap
should be used, but in this case the patch seems entirely wrong,
the code without the patch looks correct.

	Arnd

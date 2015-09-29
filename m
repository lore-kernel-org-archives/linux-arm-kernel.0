From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 29 Sep 2015 13:58:04 +0200
Subject: [PATCH] drm/rockchip: vop: Correct enabled clocks during setup
In-Reply-To: <560A6EBF.4080902@rock-chips.com>
References: <1443518893-28142-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <560A600C.8060203@rock-chips.com> <560A6EBF.4080902@rock-chips.com>
Message-ID: <1443527884.31869.48.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-29 at 18:58 +0800, Yakir Yang wrote:
> 
> On 09/29/2015 05:55 PM, Yakir Yang wrote:
> > 
> > 
> > On 09/29/2015 05:28 PM, Sjoerd Simons wrote:
> > > When doing the initial setup both the hclk and the aclk need to
> > > be
> > > enabled otherwise the board will simply hang. This only occurs
> > > when
> > > building the vop driver as a module, when its built-in the
> > > initial setup
> 
> Hmm... My previous test was built-in the vop driver, and just notice
> that
> you say problem only occurred when building the vop driver as module.
> That's to say my test was wrong, so I try to do the right things.
> 
> But I found that vop driver module and rockchipdrm driver module in
> dependency cycles, here are the build message:
>      depmod: ERROR: Found 2 modules in dependency cycles!


I've only tested with mainline which doesn't seem to have that issue?
So can't easily help you there unfortunately.


> Thanks,
> - Yakir
> 
> > > happens to run before the clock framework shuts of unused clocks
> > > (including the aclk).
> > > 
> > > While there also switch to doing prepare and enable in one step
> > > rather
> > > then separate steps to reduce the amount of code required.
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > 
> > Looks good and test on chromeos-3.14 tree, no problem, so
> > 
> > Tested-by: Yakir Yang <ykk@rock-chips.com>
> > 
> > > ---
> > > 
> > >   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 
> > > +++++++++++------------------
> > >   1 file changed, 14 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c 
> > > b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index 5d8ae5e..48719df 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > @@ -1575,32 +1575,25 @@ static int vop_initial(struct vop *vop)
> > >           return PTR_ERR(vop->dclk);
> > >       }
> > >   -    ret = clk_prepare(vop->hclk);
> > > -    if (ret < 0) {
> > > -        dev_err(vop->dev, "failed to prepare hclk\n");
> > > -        return ret;
> > > -    }
> > > -
> > >       ret = clk_prepare(vop->dclk);
> > >       if (ret < 0) {
> > >           dev_err(vop->dev, "failed to prepare dclk\n");
> > > -        goto err_unprepare_hclk;
> > > +        return ret;
> > >       }
> > >   -    ret = clk_prepare(vop->aclk);
> > > +    /* Enable both the hclk and aclk to setup the vop */
> > > +    ret = clk_prepare_enable(vop->hclk);
> > >       if (ret < 0) {
> > > -        dev_err(vop->dev, "failed to prepare aclk\n");
> > > +        dev_err(vop->dev, "failed to prepare/enable hclk\n");
> > >           goto err_unprepare_dclk;
> > >       }
> > >   -    /*
> > > -     * enable hclk, so that we can config vop register.
> > > -     */
> > > -    ret = clk_enable(vop->hclk);
> > > +    ret = clk_prepare_enable(vop->aclk);
> > >       if (ret < 0) {
> > > -        dev_err(vop->dev, "failed to prepare aclk\n");
> > > -        goto err_unprepare_aclk;
> > > +        dev_err(vop->dev, "failed to prepare/enable aclk\n");
> > > +        goto err_disable_hclk;
> > >       }
> > > +
> > >       /*
> > >        * do hclk_reset, reset all vop registers.
> > >        */
> > > @@ -1608,7 +1601,7 @@ static int vop_initial(struct vop *vop)
> > >       if (IS_ERR(ahb_rst)) {
> > >           dev_err(vop->dev, "failed to get ahb reset\n");
> > >           ret = PTR_ERR(ahb_rst);
> > > -        goto err_disable_hclk;
> > > +        goto err_disable_aclk;
> > >       }
> > >       reset_control_assert(ahb_rst);
> > >       usleep_range(10, 20);
> > > @@ -1634,26 +1627,25 @@ static int vop_initial(struct vop *vop)
> > >       if (IS_ERR(vop->dclk_rst)) {
> > >           dev_err(vop->dev, "failed to get dclk reset\n");
> > >           ret = PTR_ERR(vop->dclk_rst);
> > > -        goto err_unprepare_aclk;
> > > +        goto err_disable_aclk;
> > >       }
> > >       reset_control_assert(vop->dclk_rst);
> > >       usleep_range(10, 20);
> > >       reset_control_deassert(vop->dclk_rst);
> > >         clk_disable(vop->hclk);
> > > +    clk_disable(vop->aclk);
> > >         vop->is_enabled = false;
> > >         return 0;
> > >   +err_disable_aclk:
> > > +    clk_disable_unprepare(vop->aclk);
> > >   err_disable_hclk:
> > > -    clk_disable(vop->hclk);
> > > -err_unprepare_aclk:
> > > -    clk_unprepare(vop->aclk);
> > > +    clk_disable_unprepare(vop->hclk);
> > >   err_unprepare_dclk:
> > >       clk_unprepare(vop->dclk);
> > > -err_unprepare_hclk:
> > > -    clk_unprepare(vop->hclk);
> > >       return ret;
> > >   }
> > 
> 
> 

-- 
Sjoerd Simons
Collabora Ltd.

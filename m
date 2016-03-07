From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 07 Mar 2016 18:57:16 +0100
Subject: [PATCH 1/2] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup() in
 error path
In-Reply-To: <CAD=FV=XMvYYwOHH_SEovAeHV1Sv9BbiAP4fGnF3Gq3aS1hfQaw@mail.gmail.com>
References: <1457133723-24869-1-git-send-email-dianders@chromium.org>
 <56DD3DAF.8090700@rock-chips.com>
 <CAD=FV=XMvYYwOHH_SEovAeHV1Sv9BbiAP4fGnF3Gq3aS1hfQaw@mail.gmail.com>
Message-ID: <1693114.6CV9KAkHOO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 7. M?rz 2016, 09:36:07 schrieb Doug Anderson:
> Hi,
> 
> On Mon, Mar 7, 2016 at 12:37 AM, Mark yao <mark.yao@rock-chips.com> wrote:
> > On 2016?03?05? 20:39, Russell King - ARM Linux wrote:
> >> On Sat, Mar 05, 2016 at 12:11:16PM +0000, John Keeping wrote:
> >>> On Fri, Mar 04, 2016 at 03:22:01PM -0800, Douglas Anderson wrote:
> >>>> The drm_encoder_cleanup() was missing both from the error path of
> >>>> dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
> >>>> enabled and we ended up deferring probe of HDMI at boot.
> >>>> 
> >>>> This call isn't needed from unbind() because if dw_hdmi_bind() returns
> >>>> no error then it takes over the job of freeing the encoder (in
> >>>> dw_hdmi_unbind).
> >>>> 
> >>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>> ---
> >>> 
> >>> Does dw_hdmi-imx need a similar change?  I wonder if it would be cleaner
> >>> to push this into dw_hdmi_bind() if it affects all of the platforms..
> >> 
> >> I don't think moving it there would make sense - keep the initialisation
> >> and cleanup together in the same file so that it's contained together.
> > 
> > I don't like this patch too, initialisation and cleanup not in the same
> > file looks bad,
> > 
> > How about:
> > 
> > drivers/gpu/drm/bridge/dw-hdmi.c
> > void dw_hdmi_unbind(struct device *dev, struct device *master, void *data)
> > 
> >         hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> > 
> > hdmi->connector.funcs->destroy(&hdmi->connector);
> > -       hdmi->encoder->funcs->destroy(hdmi->encoder);
> > 
> > drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > static int dw_hdmi_rockchip_bind(struct device *dev, struct device
> > *master,
> > 
> > -       return dw_hdmi_bind(dev, master, data, encoder, iores, irq,
> > plat_data);
> > +       ret = dw_hdmi_bind(dev, master, data, encoder, iores, irq,
> > plat_data);
> > +       if (ret)
> > +               drm_encoder_cleanup(encoder);
> > +
> > +       return ret;
> > 
> >  }
> >  
> >  static void dw_hdmi_rockchip_unbind(struct device *dev, struct device
> > 
> > *master,
> > 
> >                                     void *data)
> >  
> >  {
> > 
> > +       drm_encoder_cleanup(...);
> > 
> >         return dw_hdmi_unbind(dev, master, data);
> >  
> >  }
> 
> That'a a reasonable suggestion in theory.  ...but we run into the same
> problem I've run into before with the strange relationship between
> dw_hdmi and its descendants.

I don't think handing off the cleanup responsibility is really in question 
here. I.e. I do believe it should also be fine to expect (as definition) the 
core driver to cleanup the encoder _after_ it sucessfully claimed it in 
dw_hdmi_bind().

We do the same in the rockchip power-domains, handing off the struct clk-
pointer to the pm_clk stuff (due to the clk-pointer being unique per-device 
nowadays).

So just making sure it is sucessfully handed off should also be ok.


Heiko

> 
> Specifically:
> 
> * "struct dw_hdmi", which has a pointer to encoder, is private to dw-hdmi.c
> 
> * We could get the encoder if we had a pointer to the "struct
> rockchip_hdmi", but there's no way to get that.  You would _think_ you
> could get it back using platform_get_drvdata() because it was stashed
> with platform_set_drvdata().  ...but you'd be wrong.  The
> platform_set_drvdata() is just there to fool you.  I believe when you
> call dw_hdmi_bind() it clobbers your drvdata when it calls
> dev_set_drvdata(dev, hdmi);
> 
> 
> Said another way: taking your suggestion means we need to add some way
> for dw_hdmi-rockchip.c to get a pointer to the encoder from a "struct
> device".  We could (A) move the "struct dw_hdmi" definition to a
> private header and allow dw_hdmi-rockchip.c to include it or we could
> (B) add a dw_hdmi_get_encoder() API call that dw_hdmi-rockchip.c could
> call.
> 
> 
> If someone would let me know whether (A) or (B) is OK I'm happy to post a
> patch.
> 
> 
> ...or, of course, if I've made a mistake in all the above, feel free
> to point it out.
> 
> 
> -Doug

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 09:36:29 +0200
Subject: [PATCH 09/11] drm/sun4i: Support two display pipelines
In-Reply-To: <CAGb2v64etokrb2at8Z9mpRfLhQO_2BcypZBF_rG7sVSRKiW1KQ@mail.gmail.com>
References: <20170309100534.14023-1-wens@csie.org>
 <20170309100534.14023-10-wens@csie.org>
 <20170309103636.j5jtjhwjztzchr6u@lukather>
 <CAGb2v66gFtEiESQHC9sU-XmNOoR3gCJAyQ+ZWozQmuvtWaaJMQ@mail.gmail.com>
 <20170309144009.kgixcnrjg4cot6ut@lukather>
 <CAGb2v64fmMj-YX+A-Gm_T7U=dr9J6ekwX4thqD7zegoqGMdSFQ@mail.gmail.com>
 <20170418095741.dfay2drvyiwpmlyl@lukather>
 <CAGb2v64etokrb2at8Z9mpRfLhQO_2BcypZBF_rG7sVSRKiW1KQ@mail.gmail.com>
Message-ID: <20170420073629.ngcckusehl4iuapa@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tue, Apr 18, 2017 at 06:10:26PM +0800, Chen-Yu Tsai wrote:
> >> >> >> @@ -540,14 +539,22 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
> >> >> >>       /* This can fail if the DT does not have any downstream encoders. */
> >> >> >>       tcon->id = sun4i_tcon_of_get_id(dev->of_node);
> >> >> >>       if (tcon->id < 0) {
> >> >> >> -             /*
> >> >> >> -              * TODO We currently support only 1 TCON, so we can
> >> >> >> -              * safely set this to 0. This should be revisited
> >> >> >> -              * when we add support for multiple pipelines.
> >> >> >> -              */
> >> >> >> -             tcon->id = 0;
> >> >> >> +             int i;
> >> >> >> +
> >> >> >> +             /* find the first empty tcon in sun4i_drv */
> >> >> >> +             for (i = 0; i < SUN4I_DRM_MAX_PIPELINES; i++)
> >> >> >> +                     if (!drv->tcon[i])
> >> >> >> +                             tcon->id = i;
> >> >> >> +
> >> >> >> +             /* bail out if that failed */
> >> >> >> +             if (tcon->id < 0)
> >> >> >> +                     return tcon->id;
> >> >> >>       }
> >> >> >>
> >> >> >> +     /* We only support SUN4I_DRM_MAX_PIPELINES number of tcons */
> >> >> >> +     if (tcon->id >= SUN4I_DRM_MAX_PIPELINES)
> >> >> >> +             return -EINVAL;
> >> >> >> +
> >> >> >>       tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
> >> >> >>       if (IS_ERR(tcon->lcd_rst)) {
> >> >> >>               dev_err(dev, "Couldn't get our reset line\n");
> >> >> >> @@ -588,7 +595,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
> >> >> >>               goto err_free_dotclock;
> >> >> >>       }
> >> >> >>
> >> >> >> -     tcon->crtc = sun4i_crtc_init(drm, drv->backend, tcon);
> >> >> >> +     tcon->crtc = sun4i_crtc_init(drm, drv->backend[tcon->id], tcon);
> >> >> >
> >> >> > I'm not a big fan of those IDs. The heuristic seems to be a bit
> >> >> > fragile since we really never enforced any order in our bindings.
> >> >>
> >> >> Yes. I seem to have forgotten that bit which I had intended to add.
> >> >> The endpoint IDs would ideally match the actual mux values used.
> >> >
> >> > That works for me, but the binding documentation would need to be
> >> > amended.
> >> >
> >> >> On the TCON side that's not doable, so we might have to just require
> >> >> them being in an increasing order.
> >> >
> >> > What are you planning to use those IDs on for the TCON?
> >>
> >> This reply sat in my draft box for way too long.
> >>
> >> As mentioned, the IDs on the TCON side are for the IDing the TV encoders.
> >> I think having the IDs for the same type of encoder be increasing, such
> >> that the endpoint for TV encoder 1 has a higher ID than the one for TV
> >> encoder 0 should be enough. There aren't any other instances where we
> >> have 2 or more of the same type. Or we could just add some kind of index
> >> property to the TV encoder node. This is for the A20 by the way.
> >
> > Sorry if I'm missing a bit of context here, but I still don't get
> > *why* you would need to ID them. So far, your explanation seems to
> > have been "so that we can ID them", which is pretty circular to me :)
> 
> The mux controls for the TCON output path to the TV/HDMI/MIPI encoders,
> and the TV encoder outputs, reside in the address space of the first TCON
> and TV encoder, respectively. That's why we need to ID them, to access
> the mux controls in the right block to setup the display pipeline.

Cant' we just do that based on the endpoint ID? Especially if the only
thing we really need to tell is which TCON, we basically just have to
loop around until we find a TCON, and use that one (and the same
applies for the TV encoder).

This needs to be documented properly, but I don't see anything wrong
with that

> >> >> > You seem to use it for two things:
> >> >> >  - to match a TCON to its backend in our code
> >> >> >  - to not step on each others' toes when registering the backends/tcons
> >> >> >
> >> >> > I think the second could be easily addressed using a linked list, and
> >> >> > the first one by storing the of_node. Then we just need to follow the
> >> >> > OF graph to our input of_node, and then iterate through our registered
> >> >> > backend list to find the one with the same of_node.
> >> >>
> >> >> Yes that would work for the above purposes.
> >> >>
> >> >> For getting the first TCON to access the mux registers, it kind of falls
> >> >> short. We also need something like this for the TV encoders on A10/A20.
> >> >> They too have a mux, which seems to be in the first TV encoder. This
> >> >> controls how the 8 DACs are mapped to the 4 external pins.
> >> >
> >> > How are those pins muxed between the two? Can't we just create a
> >> > connector that would be usable for both encoders?
> >>
> >> They are freely muxable. However if you want VGA output, you need 3 pins
> >> for RGB from the same TV encoder, plus H/V sync from it's upstream TCON.
> >
> > (you don't really need hsync and vsync on VGA, those are optional signals)
> 
> Really? I think you are confusing VGA with the broader "component RGB video".
> AFAIK most monitors need separate sync signals.
> 
> See https://en.wikipedia.org/wiki/Component_video#RGB_analog_component_video

Hmm, Wikipedia seem to contradict itself :)
https://en.wikipedia.org/wiki/VGA_connector

In the video signal box... but yeah, it seems like it's needed in VGA.

> >> And you have one pin left that you can use for composite, which would
> >> likely be fed from the other TCON, as you need interlaced YUV data,
> >> which is like the opposite of VGA.
> >
> > I'm not sure how these muxers should be implemented in DRM. One
> > trivial way would be to have a small pinctrl driver in the TCON driver
> > to deal with that, and switch states in both TV encoders at runtime
> > (if needed, statically otherwise).
> >
> > Or maybe we can do something simpler, I don't know.
> 
> Pinctrl or pinctrl like seems to be a good solution. The lines are routed
> on the board so it doesn't make sense to have something runtime configurable.
> We just need to know which pins are in the same group, and what kind of
> signals they each expect.

I discussed this with Boris yesterday, and he also pointed out that
there is another solution that might work. The global DRM device also
has an atomic_check method we could use to check that we aren't using
an impossible combination (2 VGA outputs for example), and assign the
pins properly between the two blocks that need them.

This would be easier to implement than a pinctrl driver.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/267ccdb3/attachment-0001.sig>

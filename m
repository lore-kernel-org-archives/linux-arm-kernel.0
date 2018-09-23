From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Sun, 23 Sep 2018 21:40:02 +0200
Subject: [linux-sunxi] Re: [PATCH 13/27] drm/sun4i: Add support for H6 DE3
 mixer 0
In-Reply-To: <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
 <CAGb2v65LzGgXORTx7PR+udZsrgGgmnXeaOW-jb=KMjHjTg7bRg@mail.gmail.com>
Message-ID: <6201242.bzTTWRITmP@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne sobota, 22. september 2018 ob 15:47:03 CEST je Chen-Yu Tsai napisal(a):
> On Sat, Sep 22, 2018 at 9:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > > Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> > > 4K image @60Hz. It also support 10 bit colors.
> > 
> > AFAICT 10 bit color support is not implemented? Please mention this.

ok.

> > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index a9218abf0935..54eca2dd4b33
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct
> > > platform_device *pdev)> > 
> > >         return 0;
> > >  
> > >  }
> > > 
> > > +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
> > 
> > Please sort the per-compatible structures according to "version sort"
> > rules.> 
> > > +       .ccsc           = 0,
> > > +       .is_de3         = true,
> > > +       .mod_rate       = 600000000,
> > > +       .scaler_mask    = 0xf,
> > > +       .ui_num         = 3,
> > > +       .vi_num         = 1,
> > > +};
> > > +
> > > 
> > >  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
> > >  
> > >         .ccsc           = 0,
> > >         .scaler_mask    = 0xf,
> > > 
> > > @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg
> > > sun8i_v3s_mixer_cfg = {> > 
> > >  };
> > >  
> > >  static const struct of_device_id sun8i_mixer_of_table[] = {
> > > 
> > > +       {
> > > +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> > > +               .data = &sun50i_h6_mixer0_cfg,
> > > +       },
> > 
> > Same here.
> > 
> > ChenYu
> 
> BTW, DE 3.0 includes a register in DE TOP called "DE IP configure register",
> which gives the number of IP blocks per class, per mixer. If we retrieve
> the configuration from this register, then we shouldn't need to
> differentiate between mixer-0 and mixer-1 with compatible strings.
> 
> What do you think?

IIRC, not all setting were correct when read from registers, but I would need 
to check again. I'm also not sure if register holds all possible settings, so 
it is safer to have separate list. We would also have to devise mechanism to 
get this data from DE2/3 CCU driver (it occupies the same memory space).

Perhaps the strongest argument is that some SoCs with DE3 have HW bug in 
mixer1 block, including that in H6. In order to work, mod clock has to be 
enabled for mixer0 and mixer1 at the same time. I would associate that quirk 
with mixer1 compatible.

Best regards,
Jernej

From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 13 Nov 2013 08:50:32 +0100
Subject: [PATCHv3 3/8] staging: imx-drm: ipuv3-crtc: don't harcode some
 mode flags.
In-Reply-To: <CAOMZO5ASDO22eHVLn18dQ31TJEjemtGp+SQqHk9XtYj6Hx3aLg@mail.gmail.com>
References: <1384274965-30549-1-git-send-email-denis@eukrea.com>
 <1384274965-30549-3-git-send-email-denis@eukrea.com>
 <CAOMZO5ASDO22eHVLn18dQ31TJEjemtGp+SQqHk9XtYj6Hx3aLg@mail.gmail.com>
Message-ID: <20131113085032.5be4bc4b@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Le Wed, 13 Nov 2013 01:52:25 -0200,
Fabio Estevam <festevam@gmail.com> a ?crit :
> On Tue, Nov 12, 2013 at 2:49 PM, Denis Carikli <denis@eukrea.com> wrote:
> > +       if (mode->flags & DRM_MODE_FLAG_DE_HIGH)
> > +               sig_cfg.enable_pol = 1;
> > +       if (mode->flags & DRM_MODE_FLAG_PIXDATA_POSEDGE)
> > +               sig_cfg.clk_pol = 1;
> >
> > -       sig_cfg.enable_pol = 1;
> > -       sig_cfg.clk_pol = 1;
> 
> 
> What are the sig_cfg.enable_pol and sig_cfg.clk_pol values you need
> for your display to operate correctly?

in ipuv3-crtc, line 159 :
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/imx-drm/ipuv3-crtc.c#n159

polarity of the enable signal and the pixel clock are hard coded to 1.

These settings are then used in ipu-di.c to configurer the IPU display
interface :
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/imx-drm/ipu-v3/ipu-di.c#n631
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/imx-drm/ipu-v3/ipu-di.c#n642

This is a problem as the polarity of these signals can vary from one
TFT panel to an other. In our case, we need and active low enable and a
negative edge clock but currently there is no way to configure these
settings in ipuv3-crtc as they are hardcoded to 1 : that's what Denis
is trying to fix.

Eric

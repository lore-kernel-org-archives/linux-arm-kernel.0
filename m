From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 6 Nov 2009 17:40:14 +0100 (CET)
Subject: [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
In-Reply-To: <20091104123536.9b95d161.ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
	<f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
	<Pine.LNX.4.64.0911040907400.4837@axis700.grange>
	<20091104123536.9b95d161.ospite@studenti.unina.it>
Message-ID: <Pine.LNX.4.64.0911061720570.4389@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(added Robert to CC)

On Wed, 4 Nov 2009, Antonio Ospite wrote:

> On Wed, 4 Nov 2009 09:13:16 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > > > +/* camera */
> > > > +static int a780_pxacamera_init(struct device *dev)
> > > > +{
> > > > + ? ? ? int err;
> > > > +
> > > > + ? ? ? /*
> > > > + ? ? ? ?* GPIO50_GPIO is CAM_EN: active low
> > > > + ? ? ? ?* GPIO19_GPIO is CAM_RST: active high
> > > > + ? ? ? ?*/
> > > > + ? ? ? err = gpio_request(MFP_PIN_GPIO50, "nCAM_EN");
> > > 
> > > Mmm... MFP != GPIO, so this probably should be written simply as:
> > > 
> > > #define GPIO_nCAM_EN	(50)
> > 
> > ...but without parenthesis, please:
> > 
> > #define GPIO_nCAM_EN	50
> > 
> > same everywhere below
> >
> 
> OK.
> 
> BTW, Guennadi, shouldn't the pxa_camera platform_data expose also an
> exit() method for symmetry with the init() one, where we can free the
> requested resources?

Good that you mentioned this. In fact, I think, that .init should go. So 
far it is used in pcm990-baseboard.c to initialise pins. You're doing 
essentially the same - requesting and configuring GPIOs. And it has been 
agreed, that there is so far no real case, where a static 
GPIO-configuration wouldn't work. So, I would suggest you remove .init, 
configure GPIOs statically. And then submit a patch to remove .init 
completely from struct pxacamera_platform_data. Robert, do you agree?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

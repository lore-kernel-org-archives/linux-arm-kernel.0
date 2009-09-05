From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 5 Sep 2009 22:19:42 +0200 (CEST)
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <200909051149.56343.marek.vasut@gmail.com>
References: <200908031031.00676.marek.vasut@gmail.com>
	<200909050926.48309.marek.vasut@gmail.com>
	<Pine.LNX.4.64.0909051037300.4670@axis700.grange>
	<200909051149.56343.marek.vasut@gmail.com>
Message-ID: <Pine.LNX.4.64.0909052219030.4670@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Sep 2009, Marek Vasut wrote:

> Dne So 5. z??? 2009 10:55:55 Guennadi Liakhovetski napsal(a):
> > On Sat, 5 Sep 2009, Marek Vasut wrote:
> > > > > >  drivers/media/video/pxa_camera.c |    4 ++++
> > > > > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/media/video/pxa_camera.c
> > > > > > b/drivers/media/video/pxa_camera.c
> > > > > > index 46e0d8a..de0fc8a 100644
> > > > > > --- a/drivers/media/video/pxa_camera.c
> > > > > > +++ b/drivers/media/video/pxa_camera.c
> > > > > > @@ -1222,6 +1222,8 @@ static int required_buswidth(const struct
> > > > > > soc_camera_data_format *fmt)
> > > > > >  	case V4L2_PIX_FMT_YVYU:
> > > > > >  	case V4L2_PIX_FMT_RGB565:
> > > > > >  	case V4L2_PIX_FMT_RGB555:
> > > > > > +	case V4L2_PIX_FMT_RGB565X:
> > > > > > +	case V4L2_PIX_FMT_RGB555X:
> > > > > >  		return 8;
> > > > > >  	default:
> > > > > >  		return fmt->depth;
> > > > > > @@ -1260,6 +1262,8 @@ static int pxa_camera_get_formats(struct
> > > > > > soc_camera_device *icd, int idx,
> > > > > >  	case V4L2_PIX_FMT_YVYU:
> > > > > >  	case V4L2_PIX_FMT_RGB565:
> > > > > >  	case V4L2_PIX_FMT_RGB555:
> > > > > > +	case V4L2_PIX_FMT_RGB565X:
> > > > > > +	case V4L2_PIX_FMT_RGB555X:
> > > > > >  		formats++;
> > > > > >  		if (xlate) {
> > > > > >  			xlate->host_fmt = icd->formats + idx;
> > >
> > > What should we do with this patch? Any updates? I spoke to Guennadi and
> > > he thinks it's not a good idea to apply it (as pxaqci doesnt support
> > > those formats). But to my understanding, those formats are endian-swapped
> > > versions of the other ones without X at the end so there shouldnt be a
> > > problem with it.
> >
> > Marek, please, look in PXA270 datasheet. To support a specific pixel
> > format means, e.g., to be able to process it further, according to this
> > format's particular colour component ordering. Process further can mean
> > convert to another format, extract various information from the data
> > (statistics, etc.)... Now RGB555 looks like (from wikipedia)
> >
> > 15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
> > R4  R3  R2  R1  R0  G4  G3  G2  G1  G1  B4  B3  B2  B1  B1  --
> >
> > (Actually, I thought bit 15 was unused, but it doesn't matter for this
> > discussion.) Now, imagine what happens if you swap the two bytes. I don't
> > think the PXA will still be able to meaningfully process that format.
> >
> 
> Not on the pxa side, but on the camera side -- Bs and Rs swapped in the diagram 
> above.

And then? Are you trying to tell me, that the PXA then swaps them back?...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

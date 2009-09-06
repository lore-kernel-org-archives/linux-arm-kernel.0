From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 6 Sep 2009 05:50:23 +0200
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <Pine.LNX.4.64.0909052358080.4670@axis700.grange>
References: <200908031031.00676.marek.vasut@gmail.com>
	<200909052317.24048.marek.vasut@gmail.com>
	<Pine.LNX.4.64.0909052358080.4670@axis700.grange>
Message-ID: <200909060550.23681.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 6. z??? 2009 00:05:14 Guennadi Liakhovetski napsal(a):
> On Sat, 5 Sep 2009, Marek Vasut wrote:
> > Dne So 5. z?????? 2009 22:19:42 Guennadi Liakhovetski napsal(a):
> > > On Sat, 5 Sep 2009, Marek Vasut wrote:
> > > > Dne So 5. z?????? 2009 10:55:55 Guennadi Liakhovetski napsal(a):
> > > > > Marek, please, look in PXA270 datasheet. To support a specific
> > > > > pixel format means, e.g., to be able to process it further,
> > > > > according to this format's particular colour component ordering.
> > > > > Process further can mean convert to another format, extract various
> > > > > information from the data (statistics, etc.)... Now RGB555 looks
> > > > > like (from wikipedia)
> > > > >
> > > > > 15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
> > > > > R4  R3  R2  R1  R0  G4  G3  G2  G1  G1  B4  B3  B2  B1  B1  --
> > > > >
> > > > > (Actually, I thought bit 15 was unused, but it doesn't matter for
> > > > > this discussion.) Now, imagine what happens if you swap the two
> > > > > bytes. I don't think the PXA will still be able to meaningfully
> > > > > process that format.
> > > >
> > > > Not on the pxa side, but on the camera side -- Bs and Rs swapped in
> > > > the diagram above.
> > >
> > > And then? Are you trying to tell me, that the PXA then swaps them
> > > back?...
> >
> > No, the software has to do it then, I'm trying to tell you that it has
> > nothing to do with PXA (as PXA really doesnt care if the channel is
> > actually blue or red).
>
> Of course it does. I asked you to swap the above two bytes, you would get
> this:
>
> 15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
> G1  G0  B4  B3  B2  B1  B0  --  R4  R3  R2  R1  R0  G4  G3  G2
>
> and PXA would still inerpret this as
>
> R4  R3  R2  R1  R0  G4  G3  G2  G1  G0  B4  B3  B2  B1  B0  --
>
> i.e., it would take bits
>
> R2 R1 R0 G4 G3
>
> for blue, bits
>
> B1 B0 -- R4 R3
>
> for green, and bits
>
> G1 G0 B4 B3 B2
>
> as red. Which, as you see, makes no sense. That's why I'm saying, that it
> doesn't support this format, and we can only pass it through as raw data.

Ah damn, I see what you mean. What the camera does is it swaps the RED and BLUE 
channel:
15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
B4  B3  B2  B1  B0  G4  G3  G2  G1  G1  R4  R3  R2  R1  R1  --
so it's more a BGR555/565 then. I had to patch fswebcam for this.

Sorry for the confusion.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

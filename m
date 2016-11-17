From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 17 Nov 2016 15:57:07 +0100
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161116213306.s5o5zi7pgppwuq7t@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
 <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
 <20161027220316.y7u3h4qsfftryrmp@lukather>
 <20161028193420.0f7dc67ea1042ff72b09b701@free.fr>
 <20161107223741.gjxj4tqwuxud2iqc@lukather>
 <20161108153752.a17440e784f2e3993c79ee69@free.fr>
 <20161116213306.s5o5zi7pgppwuq7t@lukather>
Message-ID: <20161117155707.cd8881bc7893b131d8507b92@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2016 22:33:06 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > > The Device Engine just handles the planes of the LCDs, but, indeed,
> > > > the LCDs must know about the DE and the DE must know about the LCDs.
> > > > There are 2 ways to realize this knowledge in the DT:
> > > > 1) either the DE has one or two phandle's to the LCDs,
> > > > 2) or the LCDs have a phandle to the DE.
> > > > 
> > > > I chose the 1st way, the DE ports pointing to the endpoint of the LCDs
> > > > which is part of the video link (OF-graph LCD <-> connector).
> > > > It would be possible to have phandles to the LCDs themselves, but this
> > > > asks for more code.
> > > > 
> > > > The second way is also possible, but it also complexifies a bit the
> > > > exchanges DE <-> LCD.
> > > 
> > > I'm still not sure how it would complexify anything, and why you can't
> > > use the display graph to model the relation between the display engine
> > > and the TCON (and why you want to use a generic property that refers
> > > to the of-graph while it really isn't).
> > 
> > Complexification:
> > 1- my solution:
> >   At startup time, the DE device is the DRM device.
> 
> How do you deal with SoCs with multiple display engines then?

In the H3, A83T and A64, there is only one DE.
If many DEs in a SoC, there may be either one DRM device per DE or one
DRM device for the whole system. In this last case, the (global) DE
would have many resources (many I/O memory maps / IRQs..) and the
physical DE of each endpoint would be indicated by the position of its
phandle in the 'ports' array (DT documentation).

> > It has to know the devices entering in the video chains.
> >   The CRTCs (LCD/TCON) are found by
> > 	ports[i] -> parent
> >   The connectors are found by
> > 	ports[i] -> endpoint -> remote_endpoint -> parent
> > 2- with ports pointing to the LCDs:
> >   The CRTCs (LCD/TCON) are simply
> > 	ports[i]
> >   The connectors are found by
> > 	loop on all ports of ports[i]
> > 		ports[i][j] -> endpoint -> remote_endpoint -> parent
> > 3- with a phandle to the DE in the LCDs:
> 
> What do you mean with LCD? Panels? Why would panels have a phandle to
> the display engine?

LCD is the same as CRTC. I don't think people will connect old CRT's to
their new ARM boards. LCD's may be panels, modern TV sets, or any
digital display. The word LCD seems clearer to me in this context, even
if there may a DAC as an ancoder.

> >   The DE cannot be the DRM device because there is no information about
> >   the video devices in the DT. Then, the DRM devices are the LCDs.
> >   These LCDs must give their indices to the DE. So, the DE must implement
> >   some callback function to accept a LCD definition, and there must be
> >   a list of DEs in the driver to make the association DE <-> LCD[i]
> >   Some more problem may be raised if a user wants to have the same frame
> >   buffer on the 2 LCDs of a DE.
> 
> I have no idea what you're talking about, sorry.

Here is the DT (I am using back 'CRTC'):

	de: display-controller at xxx {
		...
	};
	crtc0: crt-controller at xxx{
		...
		display-controller = <&de>;
		ports {
			...		/* to the crtc0 connectors */
		}
	};
	crtc1: crt-controller at xxx{
		...
		display-controller = <&de>;
		ports {
			...		/* to the crtc1 connectors */
		};
	};

There are 2 DRM devices: one on crtc0, the other one on crtc1.
The DE device is isolated. But, to treat the planes, it must receive
information about the CRTCs. How?

> > Anyway, my solution is already used in the IMX Soc.
> > See 'display-subsystem' in arch/arm/boot/dts/imx6q.dtsi for an example.
> 
> Pointing out random example in the tree doesn't make a compelling
> argument.

This is not a random example. There was a thread about the 'ports'
phandle in the DT definition of the IMX video subsystem, and what kind
of OF function should be used (see one of my previous mails). In the DRI
list, nobody objected about the phandle by itself.

> > > > > > > Panel functions? In the CRTC driver?
> > > > > > 
> > > > > > Yes, dumb panel.
> > > > > 
> > > > > What do you mean by that? Using a Parallel/RGB interface?
> > > > 
> > > > Sorry, I though this was a well-known name. The 'dump panel' was used
> > > > in the documentation of my previous ARM machine as the video frame sent
> > > > to the HDMI controller. 'video_frame' is OK for you?
> > > 
> > > If it's the frame sent to the encoder, then it would be the CRTC by
> > > DRM's nomenclature.
> > 
> > The CRTC is a software entity. The frame buffer is a hardware entity.
> 
> Why are you about framebuffer now, this is nowhere in that
> discussion. Any way, the framebuffer is also what is put in a plane,
> so there's a name collision here, and you'll probably want to change
> it.
> 
> Judging by the previous discussion, this should really be called
> encoder if it encodes the frames on a bus format, or CRTC if it
> composes the planes.

I think that we will end in agreeing on the words. We just need some
time!
Here is how I understand the Allwinner's DE2:

- the TCON is the piece of hardware which gets some memory area and
  sends it to a bus according to some configuation (screen resolution,
  timings...). The bus data are encoded and transmitted to the connector.
  At the end, the display device receives frames. So, going back to the
  TCON, the memory are is the frame buffer.

- this frame buffer is virtual, empty, 'dumb', it is a dumb panel!
  It is filled by planes. This job is done by a specific image
  processor, the one contained in the DE2.

- the DE2 processor gets the plane source images from the SoC memory.
  It adjusts the images according to many configuration parameters and
  includes the result into the frame buffer.

So:
	LCD = CRTC = frame buffer = dumb panel = TCON

- LCD = hardware piece of a display device (terminal side) which renders
  the colored pixels in a digital way. By extension, the hardware part
  (computer side) of a display engine which handles the definitions of
  a digital or analog physical display device. By extension also,
  the software structure (driver side) which defines a physical screen.

- CRTC = DRM software entity which handles the definitions of a screen,
  but not just a CRT.

- frame buffer = piece of memory which contains the images which are
  sent to a screen.

- dumb panel = abstract entity which defines the characteristics of a
  physical screen.

You may note that, in the DE2 scheme, the TCON and LCD are not in the
same (software) device while they are part of the same DRM software
entity, the CTRC.

> > > > > If it is similar, I think hardcoding the pipe number is pretty bad,
> > > > > because that would restrict the combination of planes and formats,
> > > > > while some other might have worked.
> > > > 
> > > > From what I understood about the DE2, the pipes just define the priority
> > > > of the overlay channels (one pipe for one channel).
> > > > With the cursor constraint, there must be at least 2 channels in
> > > > order (primary, cursor). Then, with these 2 channels/pipes, there can be
> > > > 6 so-called overlay planes (3 RGB/YUV and 3 RGB only).
> > > > Enabling the pipes 2 and 3 (LCD 0 only) would offer 8 more planes, but
> > > > RGB only. Then, it might be useful to have dynamic pipes.
> > > 
> > > That's very valuable (and definitely should go into a comment),
> > > thanks!
> > > 
> > > I still believe that's it should be into a (simple at first)
> > > atomic_check. That would be easier to extend and quite easy to
> > > document and get simply by looking at the code.
> > 
> > Sorry for I don't understand what you mean.
> 
> You can check all the constraints you exposed above in atomic_check
> instead of hardcoding it.

Sorry, but I don't like to run useless code for pure static definition.

> > The DE and the LCDs are different devices on different drivers.
> > A DE must be only one device because it has to handle concurent
> > accesses from its 2 LCDs. Then 2 drivers.
> 
> If it's different drivers, why are they in the same module?
> 
> > But only one module. Why? Because there cannot be double direction
> > calls from one module to an other one, and, in our case, for example,
> > - the DRM (DE) device must call vblank functions which are handled in
> >   the CRTC (TCON) device, and
> > - the CRTC device must call DE initialization functions at startup time.
> 
> I'm sorry, but that doesn't make any sense. The crtc device should
> take care of the CRTC functions. Your DRM CRTC and encoders can
> definitely be shared across different devices, you can have a look at
> how we're doing it for sun4i.
> 
> We basically have 3 drivers to create most of the display pipeline:
>   - One for the DRM device
>   - One for the display engine
>   - One for the TCON

Your DRM device is useless. It is simpler to have the DRM device as the
display engine.
Also, maybe, you have not the constraint the DE being shared between
2 CRTCs.

> Once they have all loaded and registered in the component framework,
> their bind callback is called, and it's when the DRM entities are
> created using exported functions to manipulate what needs to be setup.
> 
> It's definitely doable, it just takes some effort.

It seems you did not look at what I have coded...

> > On the other side, removing the cursor would just let one more plane.
> > Do we really need this one? In other words, I'd be pleased to know how
> > you run 7 applications doing video overlay.
> 
> You can use those planes to do composition too, with each application
> having one or more plane. Android uses that.
> 
> There's no argument to have a cursor plane, really. Even regular
> graphic stack like X can use a regular overlay to have its cursor on
> it. It doesn't *remove* anything, it just allows to use the plane for
> what it was supposed to be used for.

I'd be glad to know how you can have a hardware cursor without defining
it in drm_crtc_init_with_planes().

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

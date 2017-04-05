From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Apr 2017 11:34:19 +0200
Subject: [RFC] [media] imx: assume MEDIA_ENT_F_ATV_DECODER entities
 output video on pad 1
In-Reply-To: <20170405082134.GF7909@n2100.armlinux.org.uk>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1490894749.2404.33.camel@pengutronix.de>
 <20170404231053.GE7909@n2100.armlinux.org.uk>
 <19f0ce92-cad6-8950-8018-e3224e2bf266@gmail.com>
 <7235285c-f39a-64bc-195a-11cfde9e67c5@gmail.com>
 <20170405082134.GF7909@n2100.armlinux.org.uk>
Message-ID: <1491384859.2381.51.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-05 at 09:21 +0100, Russell King - ARM Linux wrote:
[...]
> > Actually what was I thinking, the TVP5150 is already an example of
> > such a device.
> > 
> > All of this could be solved if there was some direction information
> > in port nodes.
> 
> I disagree.
>
> Philipp identified that the TVP5150 has four pads:
> 
> * Input pad
> * Video output pad
> * VBI output pad
> * Audio output pad

I didn't think hard enough about this earlier, but there are really only
two hardware interfaces on TVP5150. The ADC input, which can be
connected to either of two composite input pins (AIP1A, AIP1B), or use
both for s-video, and the digital output connected to pins (YOUT[7:0]).

VBI data can be transferred via the output pins during horizontal or
vertical blanking, if I understand correctly, or read from a FIFO via
I2C.

There is no apparent support for audio data whatsoever, and the only
mention of audio in the data manual is a vague reference about an "audio
interface available on the TVP5150" providing a clock to an audio
interface between an external audio decoder and the backend processor.

Further, commit 55606310e77f ("[media] tvp5150: create the expected
number of pads") creates DEMOD_NUM_PADS pads, but doesn't mention or
initialize the audio pad. It clearly expects the value of DEMOD_NUM_PADS
to be 3. And indeed the fourth pad was added later in commit
bddc418787cc ("[media] au0828: use standard demod pads struct").

So to me it looks like the VBI and audio pads should be removed from
TVP5150.

> So, it has one input and three outputs.  How does marking the direction
> in the port node (which would indicate that there was a data flow out of
> TVP5150 into the iMX6 capture) help identify which of those pads should
> be used?
>
> It would eliminate the input pad, but you still have three output pads
> to choose from.
> 
> So no, your idea can't work.

In this case, removal of the VBI and audio pads might make this work,
but in general this is true. In my opinion, to make this truly generic,
we need an interface to ask the driver which media entity pad a given
device tree port corresponds to, as there might not even be a single
media entity corresponding to all ports for more complex devices.

> As I already stated, I believe that this case is already covered by
> video-interfaces.txt:
> 
>   If more than
>   one port is present in a device node or there is more than one endpoint at a
>   port, or port node needs to be associated with a selected hardware interface,
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   a common scheme using '#address-cells', '#size-cells' and 'reg' properties is
>   used.
> 
> So, according to that, you do not need to have more than one port node
> to use the reg property - it's _either_ more than one port _or_ to
> select the hardware interface.

I don't think enforcing a 1:1 correspondence between device tree node
and media entity and enforcing port reg property == entity pad index is
a good idea in the long run. Binding errors are going to be made that
will have to be worked around at the driver level, and more complex
devices might have to create multiple media entities / v4l2 subdevices
with external ports that interface with the of graph.

> It all hinges on whether you consider the video output, VBI output or
> audio output to be separate hardware interfaces that the singular
> specified "port" node needs to select between.
> 
> There's another reason why the TVP5150 binding looks wrong and broken,
> however.  How does the audio output get routed to other parts of the
> system if you're using the video output, and how is that relationship
> defined?  It's a v4l2 subdev pad, so it would need to be part of the
> v4l2 subdev graph.  It sounds to me like the binding was created with
> a narrow focused "this is the board in front of me, it only has video
> wired up, I'm not going to consider other use cases" blinkered view.

I think the output part is accurate, as the audio pad is an artifact of
an unrelated change. I'm not so sure about the VBI pad, but I think that
shouldn't exist either. The input pad, on the other hand, not having any
of graph representation in the device tree seems a bit strange. There
was a custom binding for the inputs, that got quickly reverted:
https://patchwork.kernel.org/patch/8395521/

regards
Philipp

From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 13:36:55 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130810161123.GW23006@n2100.arm.linux.org.uk>
References: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
Message-ID: <20130811123655.GX6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 05:11:23PM +0100, Russell King - ARM Linux wrote:

> It would appear that the problem is that the AIF widgets are not finding
> their stream - the implicit routes are not being created.  It _appears_
> that the strean name in widgets are only ever connected to the streams
> within the same DAPM context.

That shouldn't be the case in general - DAPM binds first to a widget in
the local context for disambiguation and then falls back to a search of
the gobal context.  However it is possible that you've got an ordering
issue during registration.

> So, it's because the capture isn't wired up.  The capture isn't wired
> up on this platform, so how do I tell ASoC not to bother with the
> capture side with DPCM?  Creating a link for the capture side to the
> dummy codec is wrong, because that allows capture to be brought up when
> in fact there is no capture wired up on the board (and means that we'll
> end up trying to use unconnected inputs.)

What I'd expect to happen is that the wiring for the SoC internal bits
can be there since it physically is there but we don't generate anything
that userspace can see unless we also provide a back end it can be wired
up to.  We probably need to fill that bit in though since I don't think
anyone ever tried to use this stuff on a unidirectional system before.

> but doesn't stop those warnings (not really surprising, because it isn't
> the card level which is being complained about).  Probably the easiest
> way to stop that appearing is to just disable OSS compatibility.

> That's something which should be documented until it is fixed - that
> DPCM is currently incompatible with OSS.

That's not likely to ever be supported even if anyone cared, very few
ASoC drivers will work with OSS due to the very poor mapping between OSS
parameter configuration and ALSA parameter configuration.

> So, there are two issues which still need resolving:
> 1. The registration of Codec widgets from the platform introduced by
>    Liam in be09ad90e17b79fdb0d513a31e814ff4d42e3dff
> 	ASoC: core: Add platform DAI widget mapping

Well, that patch isn't visibly doing anything with CODECs - it's acting
on the CPU and platform, not on the CODECs.  I think what's happening
there is that if you've got the same device for the DAI and platform
then the widgets will be created twice, once by the DAI and once by the
platform.  The current code is fine if they're separate devices but will
fail if they are the same device.

We just need to make the DAPM context per device I think, possibly as
part of moving over to components (based on the work that Morimoto-san
started) though we could do it without that.

> 2. How to deal with disconnected front end streams which have no backend
>    provided by their connected codec (in this case, front end can do
>    capture and playback, back end can only do playback.)

Like I say I think we should just not be complaining if there's no
capture back end available.  Probably just checking if there's any
at all is good enough for realistic uses.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/7bf64496/attachment.sig>

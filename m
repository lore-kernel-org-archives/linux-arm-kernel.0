From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 22:52:32 +0100
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718212350.GC24642@n2100.arm.linux.org.uk>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
 <20130718173727.2cfa38d3@skate>
 <20130718210637.GW22506@sirena.org.uk>
 <20130718211521.GX22506@sirena.org.uk>
 <20130718212350.GC24642@n2100.arm.linux.org.uk>
Message-ID: <20130718215231.GY22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:23:50PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 18, 2013 at 10:15:21PM +0100, Mark Brown wrote:

> > This means that for uda134x (which I think is what you're using here, I

> No, this report is against ALC5623, which does appear to have widgets.
> I was remarking that this looks like the same kind of issue I had with
> UDA134x.

Ah, OK.  In that case the issue is likely to be that no connection has
been made between the audio interface and the outputs desired - probably
some routing control needs to be enabled by userspace.  If there's no
visible path between a source of audio (like playback from the CPU) and
a sink (such as an output) then the framework will think there's nothing
to do.

> So if everything on the codec is powered down, it's not surprising that
> there is no audio output.

Indeed, and if the routing isn't set up to connect an audio path the
core will not bother powering it on at all.  The issue with the UDA134x
is that we need to give the framework the information that the playback
interfaces are connected to an output (or restore the code to do this in
the core but at this point since it's all data driven now in the drivers
it's easier and more robust to just plumb them in and avoid having to
deal with special cases which keep tripping us up).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/72605e9e/attachment.sig>

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 12 Jul 2013 00:11:56 +0200
Subject: Armada 510 display controller
In-Reply-To: <CAMLZHHRNjbQy7zfw=bD1kC+pKh946rOBWKyFOyhzyoLkdkE0PA@mail.gmail.com>
References: <CAMLZHHRNjbQy7zfw=bD1kC+pKh946rOBWKyFOyhzyoLkdkE0PA@mail.gmail.com>
Message-ID: <51DF2DAC.3080605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 09:59 PM, Daniel Drake wrote:
> We seem to have reached an initial conclusion from the "Best practice
> device tree design for display subsystems/DRM". Thanks for the
> discussion. I am trying to come up with a binding + implementation.
>
> I am a bit stuck though, because I don't fully understand what the
> DCON on the Armada 510 does.

Daniel,

just ignore DCON for now. Its reset state allows us to use Dove
DRM in the only way we plan to already. Later if somebody comes
up with a board that has both LCD0 and LCD1 connected, we propose
the DT binding.

> In that thread, the ascii art suggests that it receives the output
> from the two LCD controllers. From there it can send the image to a
> VGA output or a parallel bus (where the HDMI encoder lies). Does it
> let you choose which LCD controller input goes to which output? Can
> you clone one input onto both outputs?

You can clone LCD0 to VGA but not the other way round. I guess it
use kind of useless anyway. Or you want to clone HDMI to analog VGA? ;)
 From a DT point-of-view DCON it completely independent.

> If it plays such an integral role in the "get an image from Cubox onto
> my TV" path, as suggested in the diagram, why can't I see any code in
> the armada_drm driver that configures it?

It does, but currently reset state is sufficient for us.

> We also have a naming conflict that might be annoying. The MMP2 and
> MMP3 can effectively drive 3 different video outputs (2 panels + 1
> HDMI), but the documentation and register layout does not treat it as
> 3 different devices. Rather it is just 1 device, annoyingly named
> "display controller". Comparing MMP to Armada 510, the MMP "display
> controller" seems to act like the 510's LCD controllers and display
> controller combined, i.e. it coordinates both the reading of image
> data from memory *and* sending it to a configurable selection of
> output devices.

That is also the case for A510. LCD0 reads from memory and drives
dumb RGB connected to HDMI controller. LCD1 can also read from memory
and drive VGA. DCON allows you to clone video from LCD0 to VGA instead
of LCD1.

> That might produce a challenge for writing good documentation that
> covers all the target hardware. That will become apparent once I'm
> clearer on what the Armada 510 DCON is and how to document it's
> possible involvement in the DT. If necessary, maybe we could refer to
> the Armada 510 DCON as "output controller" or "output selector" or
> something like that, to avoid the name conflict.

I don't recall if DCON really is named "display controller" in the
public datasheet. It was the most likely name, so I called it display
controller. For the documentation, name it output multiplexer/selector.
Both LCD controller and Display controller are not very helpful for the
function anyway.

Sebastian

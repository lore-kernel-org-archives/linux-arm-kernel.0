From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 09 May 2016 11:04:15 +0200
Subject: [RFC PATCH 0/7] AC97 device/driver model revamp
In-Reply-To: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <s5hlh3j8uwg.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Apr 2016 23:15:32 +0200,
Robert Jarzmik wrote:
> 
> It all started in the pxa device-tree submission here :
>    https://lkml.org/lkml/2016/2/25/965
> It will be maintained in :
>    git fetch https://github.com/rjarzmik/linux.git work/ac97
> 
> And now it transformed into this RFC, which would bring a ground for AC'97
> devices closer to the linux device/driver model.
> 
> This is just an RFC to see if we understand each other Mark.
> 
> Amongst the driving ideas behind this RFC :
>  - use device/driver model for AC'97
>    device/driver binding is based on vendor_id{1,2}
>  - use auto-probe of the AC'97 bus to enumerate codecs and create devices
>  - be compatible with previous platform_data model for codecs
>    => this enables a smooth transition, where a codec (here wm9713) can
>       be used either through platform_device or automatic discovery
>  - struct snd_ac97 is not used
>    This structure is really heavy, and doesn't represent an AC97 device, but
>    rather an AC'97 codec internals IIUC.
>    I think it's right place would be in include/sound/ac97/codec.h.
>    This is also a problem for regmap adherence, hence the
>    include/sound/ac97/compat.h.
>  - a new AC'97 bus Kconfig is created
>    This was done for a smooth transition ... let's see if it's a good idea.
>  - split the AC'97 into :
>    - the codec
>    - the digital controller
>    - the bus
> 
> Amongst the things that are not all touched yet :
>  - ac97_codec.c
>    The generic AC'97 codec in sound/pci/ac97/ac97_codec.c has really a lot
>    features, which are not at all PCI related. They could be transfered to
>    sound/ac97, without the pci specific field.
>    => this deserves a deep ahead thinking, which I'll do if the current approach
>    is accepted by the communauty.
> 
> The most important patch is 2/7 "ALSA: ac97: add an ac97 bus". This is the main
> evaluation point for the serie, the others are here so that I can test it all.
> 
> Well, this is a long term effort, which might need a complete rewrite according
> to the comments it'll get. Let's expose it for comments and see how I can
> progress with it.

I think it's good in general.  The implementation looks fairly simple
and thin enough.

An open question is whether migrating the former AC97 layer into the
new bus.  I'm not sure about this.  Transition to a new layer always
brings subtle bugs, especially when the target devices are in wide
range of legacy ones...   If any, we should start just wrapping via
the new bus ops.

Some other nitpicks:
- We usually use snd_ prefix for sound stuff.  Better to keep this for
  exported symbols at least.

- I don't see much value in the usefulness of compat_* stuff.
  For example, it doesn't cover the actual reset procedure or such
  done as in the old ac97 code.  So it won't work compatibly.  If it's
  a few lines of changes, the direct call would be likely simpler in
  the end.

- The order of patches needs reconsideration.  The current patchset
  will break the build, as the hook to sound/ac97/* is done in the
  last patch, while you're already building against to the new stuff
  beforehand.


I'll comment more on each patch if any...


thanks,

Takashi

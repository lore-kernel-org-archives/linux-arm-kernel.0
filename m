From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 7 Oct 2016 18:44:41 +0100
Subject: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
 issue.
In-Reply-To: <CACvgo50vU5_=KFUCAZDaQPepPdsbnF8KN1b+f6KJNuBW6qRdSg@mail.gmail.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
 <CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
 <20160920083251.GB26093@griffinp-ThinkPad-X1-Carbon-2nd>
 <8760pqncee.fsf@intel.com>
 <20161006093721.GA436@griffinp-ThinkPad-X1-Carbon-2nd>
 <CACvgo50vU5_=KFUCAZDaQPepPdsbnF8KN1b+f6KJNuBW6qRdSg@mail.gmail.com>
Message-ID: <20161007174441.GA27720@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,

On Thu, 06 Oct 2016, Emil Velikov wrote:

> On 6 October 2016 at 10:37, Peter Griffin <peter.griffin@linaro.org> wrote:
> 
> > In fact the help text for VIRTIO even states this option should be selected
> > by any driver which implements virtio.
> >
> Almost but not quite. It says:
> 
> "This option is selected by any driver which implements the virtio _bus_"
> 

Ah I thought DRM_VIRTIO_GPU was implementing a virtio bus, bus it seems that it 
uses pci. Which does raise the question of why it is depending on VIRTIO at all
and not VIRTIO_PCI.

> REMOTEPROC obviously does that while the ST SLIM driver does not. Thus
> the latter should _not_ select, be that explicitly or implicitly via
> REMOTEPROC, the symbol.

Yep OK.

> 
> >>
> >> People tend to abuse select because it's "convenient". If you depend,
> >> but some of your dependencies aren't met, you're in for some digging
> >> through Kconfig to find the missing deps. Just to make the option you
> >> want visible in menuconfig. If you instead select something with
> >> dependencies, it'll be right most of the time, and it's "convenient",
> >> until it breaks. (And hey, it usually breaks for someone else with some
> >> other config, so it's still convenient for you.)
> >
> > I'm sure they do but in this case it is actually the use of 'depends on'
> > which has caused the breakage and inconvenience for somebody else and sadly this
> > inconvienice is still on-going due to this patch not being applied or getting an
> > acked-by from the appropriate maintainers.
> >
> Surely you're not saying that pre-existing driver following the
> documentation, is 'causing breakage' for a new driver {ab,mis}using a
> feature ?

Your right I wasn't saying that :)

My point was that this patch wasn't 'wrong' when referring to the Kconfig
documentation Jani referenced as VIRTIO has no dependencies.

Also I thought DRM_VIRTIO_GPU driver implemented a VIRTIO bus which re-enforced
the view that it should be selecting VIRTIO. 

> 
> This reminds me an old saying: "If the shoe doesn?t fit, it doesn?t
> mean there is anything wrong with your feet."

If the shoe doesn't fit, chop off the leg :)

> You seem to be suggesting the opposite ?
> 
> >>
> >> Perhaps kconfig should complain about selecting visible symbols and
> >> symbols with dependencies.
> >
> > That sounds like it would be a useful addition.
> >
> > Is it possible to get this patch applied or an acked-by to avoid further delay
> > to the fdma series?
> >
> Please don't apply duct tape, especially where it's _not_ needed.
> 
> $ sed -i s/select REMOTEPROC/depends on REMOTEPROC/ drivers/remoteproc/Kconfig
> 
> ... will resolve things in the right place. The alternative will lead
> to random issues in other subsystems.
> 

If Bjorn is OK with it, then it is fine with me.

I will update remoteproc Kconfig setup in fdma v10, this will drop the
requirement for this patch in drm subsystem.

I can then send the whitespace cleanup patch separately to DRM ML.

regards,

Peter.

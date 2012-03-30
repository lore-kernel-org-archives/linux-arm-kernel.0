From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Mar 2012 11:07:42 +0100
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
 <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
Message-ID: <20120330100742.GB21950@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 03:27:01PM -0700, Erik Gilling wrote:
> On Fri, Mar 9, 2012 at 4:41 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Mon, Feb 27, 2012 at 09:15:35PM +0900, MyungJoo Ham wrote:

> >> +#ifdef CONFIG_ANDROID
> >> + ? ? ? ? ? ? extcon_class = class_create(THIS_MODULE, "switch");
> >> +#else /* !CONFIG_ANDROID */
> >> + ? ? ? ? ? ? extcon_class = class_create(THIS_MODULE, "extcon");
> >> +#endif /* CONFIG_ANDROID */

> > This seems somewhat sad - if ANDROID is turned on the standard ABI
> > vanishes. ?It'd be much nicer to do this with a symlink (or with
> > symlinks within the android directory if the driver core doesn't support
> > that). ?That way userspace code can be written to the new ABI and will
> > work on Android systems without ifdefery.

> This won't work if userspace code is receiving uevents through netlink
> and comparing based on the device name which it does in android.  Why

That's not really the point here - the point is that the new ABI
vanishes as soon as you turn on the legacy Android ABI.  You're right
that the particular fix I suggested has issues but the overall problem
exists and should be dealt with more sensibly.

> change the name at all?  Extcon is much more specific than "switch."
> A switch can can be used for more than just external connections such
> as availability of HMDI audio (which is only available once a HDMI
> mode is chosen and the interface is enabled.)

I don't know myself, it was called extcon when first proposed for
mainline.  Renaming does have the advantage of indicating to userspace
that this is the mainline, reviewed version and that things might be a
bit different as a result of that review.

Things like the HDMI audio example you cite do seem close enough to the
term to still be useful, they're related to an external connection and
it's state.  If you were really worrying about it you might expect HDMI
audio to be reported via something like the ALSA APIs rather than a
totally unrelated ABI like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120330/de012e9f/attachment.sig>

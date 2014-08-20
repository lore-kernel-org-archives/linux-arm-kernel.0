From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 17:25:08 +0200
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAOesGMhDe0zFYkUWqBOTunK76wccdKOQ8b+EFAzeTr+oOUQyWA@mail.gmail.com>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
 <CAL1qeaH-WfA-DLKwuXA_hBPHYuXksAibLq__zisrT9ALaRGdAw@mail.gmail.com>
 <53F28F90.3000004@wwwdotorg.org>
 <CAL1qeaFnfLDOXq07fY4xLfdRpG8FQ63ya+-0Hk+ewA1wXkLOLw@mail.gmail.com>
 <53F3C5FD.4050808@wwwdotorg.org>
 <CAOesGMhDe0zFYkUWqBOTunK76wccdKOQ8b+EFAzeTr+oOUQyWA@mail.gmail.com>
Message-ID: <20140820152507.GA3427@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 06:37:48AM -0700, Olof Johansson wrote:
> On Tue, Aug 19, 2014 at 2:47 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 08/18/2014 06:11 PM, Andrew Bresticker wrote:
> >>
> >> On Mon, Aug 18, 2014 at 4:43 PM, Stephen Warren <swarren@wwwdotorg.org>
> >> wrote:
> >>>
> >>> On 08/18/2014 05:24 PM, Andrew Bresticker wrote:
> >>>>
> >>>>
> >>>> On Mon, Aug 18, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>> On 08/16/2014 09:20 AM, Andreas F?rber wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> Am 13.08.2014 21:14, schrieb Dylan Reid:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> The Acer Chromebook 13, codenamed Big, contains an NVIDIA tegra124
> >>>>>>> processor and is similar to the Venice2 reference platform.
> >>>>>>>
> >>>>>>> The keyboard, USB 2, audio, HDMI, sdcard, and emmc have been tested
> >>>>>>> and work on the 1266x768 models.  The HD models haven't yet been
> >>>>>>> tested.
> >>>>>>>
> >>>>>>> WiFi does not work yet, it needs at least some PMIC changes to enable
> >>>>>>> the 32k clock.
> >>>>>>>
> >>>>>>> The elan trackpad is not yet functional but hopefully will be soon as
> >>>>>>> there are patches under review.
> >>>>>>>
> >>>>>>> There is also an issue on reboot because the TPM isn't reset.  It
> >>>>>>> will
> >>>>>>> cause the stock firmware to enter recovery mode.  This can be worked
> >>>>>>> around by an EC-reset, press the refresh and power keys at the same
> >>>>>>> time.
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>>>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000..79f1852
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>> @@ -0,0 +1,1136 @@
> >>>>>>> +/dts-v1/;
> >>>>>>> +
> >>>>>>> +#include <dt-bindings/input/input.h>
> >>>>>>> +#include "tegra124.dtsi"
> >>>>>>> +
> >>>>>>> +/ {
> >>>>>>> +       model = "Acer Chromebook 13";
> >>>>>>> +       compatible = "google,nyan-big", "nvidia,tegra124";
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> In light of v1 and the above commit message referring to this as
> >>>>>> Google
> >>>>>> Big, shouldn't this be "google,big", "nvidia,tegra124" and optionally
> >>>>>> "google,nyan" as secondary string, independent of the new file name?
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> Despite this board having been derived from Nyan, it isn't Nyan, so I
> >>>>> don't
> >>>>> think Nyan should be part of any compatible value, nor a separate
> >>>>> compatible
> >>>>> value.
> >>>>
> >>>>
> >>>>
> >>>> "google,nyan-big" is the compatible string that the bootloader on
> >>>> these devices looks for.  It's also the convention we are now using
> >>>> for our ARM devices, as Olof has already mentioned.
> >>>
> >>>
> >>> I don't understand "that the bootloader looks for"; why is the bootloader
> >>> doing anything w.r.t the compatible value in the DT that's passed to the
> >>> kernel.
> >>
> >>
> >> The ChromeOS bootloader ("depthcharge") boots FIT images and selects
> >> the appropriate device-tree from the image based on the compatible
> >> string.  On Big boards, it looks for "google,nyan-big".  This only
> >> becomes an issue if there are multiple device-trees in the FIT image.
> >> If there's only a single configuration (or you chain-load U-Boot),
> >> then the bootloader will boot with that configuration.  If you build a
> >> kernel image in the ChromiumOS environment, however, you'll end up
> >> with multiple device-trees (all those built by the kernel config at
> >> least) in the FIT image - this is what allows us to boot the same
> >> binary on different boards.
> >
> >
> > This just makes me dislike FIT (and DT ABIs) even more, although I suppose
> > the same issue would arise if the DTBs were stored in separate files and
> > looked up by filename.
> 
> Yes, or stored in separate files and looked up by compatible field.
> 
> Do you have a suggestion on a better way to solve it, btw? Definitely
> not one of those things we can fix retroactively, but if it works
> poorly for you upstream we'll consider improvements if we can for
> future products.
> 
> I'm not a huge fan of fitImage myself, but it gets the work done.

It's been a long time since I've used FIT, but I seem to remember that
it was simply a device tree-based description of a file format. As such
couldn't you add an additional property to the configuration entry that
the bootloader could match on? That would avoid the need to parse an
embedded device tree and it might be useful to keep variants for the
same board in the same FIT image.

Perhaps you can explain a little more what the use-cases are. For
example how are people suppose to run an upstream kernel on one of these
Chromebooks? Do they completely replace one FIT image with another (and
in the process delete or rename the original one)? Or can they simply
add another FIT image that contains the kernel and DTB from upstream? Is
there a way to add new configurations to an existing FIT image? How does
dual-booting work? Does the user get a menu to choose a configuration
they want to boot if multiple entries are compatible with the detected
board?

Upstream U-Boot exports some variables (such as $soc and $board) to the
shell environment so that scripts can use them. What I usually end up
doing is put files (zImage, DTB, ...) in locations based on those names
so that I can boot all systems from the same SD card (or TFTP/NFS setup)
yet retain the possibility to update each of the files separately. Maybe
something like that could work for Chromebooks. If you locate files by
filename you become much less reliable on the content itself. Files
could be named tegra124-nyan-big.dtb even if the compatible was just
"google,big". The same goes for additional properties in FIT images.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/0e95bf1d/attachment.sig>

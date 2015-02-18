From: mporter@linaro.org (Matt Porter)
Date: Wed, 18 Feb 2015 11:46:29 -0500
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
Message-ID: <20150218164629.GM26795@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 05:53:50PM +0200, Pantelis Antoniou wrote:
> Hi Mark,
> 
> > On Feb 18, 2015, at 17:41 , Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Hi Pantelis,
> > 
> > On Wed, Feb 18, 2015 at 02:59:34PM +0000, Pantelis Antoniou wrote:
> >> Implement a method of applying DT quirks early in the boot sequence.
> >> 
> >> A DT quirk is a subtree of the boot DT that can be applied to
> >> a target in the base DT resulting in a modification of the live
> >> tree. The format of the quirk nodes is that of a device tree overlay.
> >> 
> >> For details please refer to Documentation/devicetree/quirks.txt
> >> 
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> >> ---
> >> Documentation/devicetree/quirks.txt | 101 ++++++++++
> >> drivers/of/dynamic.c                | 358 ++++++++++++++++++++++++++++++++++++
> >> include/linux/of.h                  |  16 ++
> >> 3 files changed, 475 insertions(+)
> >> create mode 100644 Documentation/devicetree/quirks.txt
> >> 
> >> diff --git a/Documentation/devicetree/quirks.txt b/Documentation/devicetree/quirks.txt
> >> new file mode 100644
> >> index 0000000..789319a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/quirks.txt
> >> @@ -0,0 +1,101 @@
> >> +A Device Tree quirk is the way which allows modification of the
> >> +boot device tree under the control of a per-platform specific method.
> >> +
> >> +Take for instance the case of a board family that comprises of a
> >> +number of different board revisions, all being incremental changes
> >> +after an initial release.
> >> +
> >> +Since all board revisions must be supported via a single software image
> >> +the only way to support this scheme is by having a different DTB for each
> >> +revision with the bootloader selecting which one to use at boot time.
> > 
> > Not necessarily at boot time. The boards don't have to run the exact
> > same FW/bootloader binary, so the relevant DTB could be programmed onto
> > each board.
> > 
> 
> That has not been the case in any kind of board I?ve worked with.
> 
> A special firmware image that requires a different programming step at
> the factory to select the correct DTB for each is always one more thing
> that can go wrong.
> 
> >> +While this may in theory work, in practice it is very cumbersome
> >> +for the following reasons:
> >> +
> >> +1. The act of selecting a different boot device tree blob requires
> >> +a reasonably advanced bootloader with some kind of configuration or
> >> +scripting capabilities. Sadly this is not the case many times, the
> >> +bootloader is extremely dumb and can only use a single dt blob.
> > 
> > You can have several bootloader builds, or even a single build with
> > something like appended DTB to get an appropriate DTB if the same binary
> > will otherwise work across all variants of a board.
> > 
> 
> No, the same DTB will not work across all the variants of a board.
> 
> > So it's not necessarily true that you need a complex bootloader.
> > 
> 
> >> +2. On many instances boot time is extremely critical; in some cases
> >> +there are hard requirements like having working video feeds in under
> >> +2 seconds from power-up. This leaves an extremely small time budget for
> >> +boot-up, as low as 500ms to kernel entry. The sanest way to get there
> >> +is by removing the standard bootloader from the normal boot sequence
> >> +altogether by having a very small boot shim that loads the kernel and
> >> +immediately jumps to kernel, like falcon-boot mode in u-boot does.
> > 
> > Given my previous comments above I don't see why this is relevant.
> > You're already passing _some_ DTB here, so if you can organise for the
> > board to statically provide a sane DTB that's fine, or you can resort to
> > appended DTB if it's not possible to update the board configuration.
> > 
> 
> You?re missing the point. I can?t use the same DTB for each revision of the
> board. Each board is similar but it?s not identical.
> 
> >> +3. Having different DTBs/DTSs for different board revisions easily leads to
> >> +drift between versions. Since no developer is expected to have every single
> >> +board revision at hand, things are easy to get out of sync, with board versions
> >> +failing to boot even though the kernel is up to date.
> > 
> > I'm not sure I follow. Surely if you don't have every board revision at
> > hand you can't test quirks exhaustively either?
> > 
> 
> It?s one less thing to worry about. For example in the current mainline kernel
> already there is a drift between the beaglebone white and the beaglebone black.
> 
> Having the same DTS is just easier to keep things in sync.

Absolutely, we have the problem in the dts files today where we have
lots of duplicated bits. I know one case that I think you are alluding
to is how BBW has the aes and sham enabled but BBB does not. That's with
just two variants. :( This would definitely drive better organization
of dtses and cure a lot of bitrot if they could share a common file.
OTOH, some might argue that the bone common dtsi should just enable those
nodes staticly for this case.

-Matt

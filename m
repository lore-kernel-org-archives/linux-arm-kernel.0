From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 27 Oct 2013 13:56:03 +0000
Subject: [PATCHv3][ 3/5] video: mx3fb: Add device tree suport.
In-Reply-To: <93D2899F-E285-4794-8F32-AD55360A4A80@codeaurora.org>
References: <1382532229-32755-1-git-send-email-denis@eukrea.com>
 <1382532229-32755-3-git-send-email-denis@eukrea.com>
 <20131025195040.0CCC3C404DA@trevor.secretlab.ca>
 <20131026001854.GE17135@pengutronix.de>
 <93D2899F-E285-4794-8F32-AD55360A4A80@codeaurora.org>
Message-ID: <20131027135603.1589FC4039D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Oct 2013 01:43:23 -0500, Kumar Gala <galak@codeaurora.org> wrote:
> 
> On Oct 25, 2013, at 7:18 PM, Sascha Hauer wrote:
> 
> > On Fri, Oct 25, 2013 at 08:50:40PM +0100, Grant Likely wrote:
> >> On Wed, 23 Oct 2013 14:43:47 +0200, Denis Carikli <denis@eukrea.com> wrote:
> >>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> >>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>> Cc: linux-fbdev at vger.kernel.org
> >>> Cc: Rob Herring <rob.herring@calxeda.com>
> >>> Cc: Pawel Moll <pawel.moll@arm.com>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Stephen Warren <swarren@wwwdotorg.org>
> >>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >>> Cc: devicetree at vger.kernel.org
> >>> Cc: Sascha Hauer <kernel@pengutronix.de>
> >>> Cc: linux-arm-kernel at lists.infradead.org
> >>> Cc: Eric B??nard <eric@eukrea.com>
> >>> Signed-off-by: Denis Carikli <denis@eukrea.com>
> >>> ---
> >>> ChangeLog v2->v3:
> >>> - The device tree bindings were reworked in order to make it look more like the
> >>>  IPUv3 bindings.
> >>> - The interface_pix_fmt property now looks like the IPUv3 one.
> >>> ---
> >>> .../devicetree/bindings/video/fsl,mx3-fb.txt       |   35 ++++++
> >>> drivers/video/Kconfig                              |    2 +
> >>> drivers/video/mx3fb.c                              |  125 +++++++++++++++++---
> >>> 3 files changed, 147 insertions(+), 15 deletions(-)
> >>> create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> >>> new file mode 100644
> >>> index 0000000..0b31374
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> >>> @@ -0,0 +1,35 @@
> >>> +Freescale MX3 fb
> >>> +================
> >>> +
> >>> +Required properties:
> >>> +- compatible: Should be "fsl,mx3fb". compatible chips include the imx31 and the
> >>> +  imx35.
> >>> +- reg: should be register base and length as documented in the datasheet.
> >>> +- clocks: Handle to the ipu_gate clock.
> >>> +
> >>> +Example:
> >>> +
> >>> +lcdc: mx3fb at 53fc00b4 {
> >>> +	compatible = "fsl,mx3-fb";
> >>> +	reg = <0x53fc00b4 0x0b>;
> >>> +	clocks = <&clks 55>;
> >>> +};
> >> 
> >> This (and some of the other bindings) are trivial, and they are all
> >> associated with a single SoC. I think it would be better to collect all
> >> the mx3 bindings into a single file rather than distributing them all
> >> over the bindings tree.
> >> 
> >> I started thinking about this after some of the DT conversations in
> >> Edinburgh this week. Unless there is a high likelyhood of components
> >> being used separately, I think it is far more useful to collect all the
> >> bindings for an SoC into a single file. It will certainly reduce a lot
> >> of the boilerplate that we've been collecting in bindings documentation
> >> files.
> >> 
> >> A long time ago I took that approach for the mpc5200 documentation[1].
> >> Take a look at that organization and let me know what you think.
> > 
> > I don't think this is a good idea. When a new SoC comes out we don't
> > know which components will be reused on the next SoC. This will cause a
> > lot of bikeshedding when it actually is reused and then has to be moved.
> > 
> > Also I would find it quite inconsistent if I had to lookup some devices
> > in a SoC file and most bindings in subsystem specific files. So when
> > searching for a binding I would first have to know if the hardware is
> > unique to the SoC or not.
> 
> I agree that as new SoC come out its better to have these things split
> out.  Also for IP that is sold by vendors like Synopsys/Designware
> that get used on a lot of SoCs its makes it easier to ensure
> consistency by having the binding split out for the IP and not the
> SoC.

After looking at how many files we're now creating under
Documentation/devicetree/bindings, I'm starting to think we need to go
entirely the other way and put whole the whole family of an SoC into a
single binding file, particularly for the SoC integration level stuff
that isn't likely to be shared with SoCs from other vendors.

A decision on this can be deferred as we're working on schema tools.
Some of that may fall out when we figure out what the structure of the
schema files should be.

> Also, by having bindings for similar devices for different SoCs kept together it becomes easier for us to see patterns across SoCs as we might come up with a more generic binding in the future.  Far more difficult if things are SoC oriented.

The downside is bindings for a single SoC get distributed among a lot of
files which makes it more difficult to follow how the SoC is put
together and configured.

g.

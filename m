From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jan 2016 11:11:34 -0600
Subject: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <56A07A6D.3010406@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop>
 <56A07A6D.3010406@rock-chips.com>
Message-ID: <20160125171134.GA21713@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 02:27:57PM +0800, Andy Yan wrote:
> Hi Rob:
>    thanks for your review.
> On 2016?01?21? 02:28, Rob Herring wrote:
> >On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
> >>add device tree binding document for reboot-mode driver
> >>
> >>Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >>
> >>---
> >>
> >>Changes in v2: None
> >>Changes in v1: None
> >>
> >>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
> >>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
> >>  2 files changed, 93 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>new file mode 100644
> >>index 0000000..81d9f66
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>@@ -0,0 +1,41 @@
> >>+Generic reboot mode core map driver

[...]

> >>+		compatible = "syscon-reboot-mode";
> >>+		offset = <0x40>;
> >This doc by itself is a little confusing. For example, is a child of the
> >syscon node? I would remove offset (and perhaps compatible) from this
> >example.
> 
>    Yes, is a child of a syscon mapped node. For example, Rockchip platform
> use a register of PMU(rk3066/rk3288) or GRF(rk3036), PMU and GRF are aleady
> mapped by syscon.
>    offset and compatible are used by write interface driver like
> syscon-reboot-mode.c. If you don't like it appear in the core map doc, I
> will move it to the syscon-reboot-mode.txt?

Yes, try to make this doc stand on its own. It will obviously be 
incomplete lacking information on where in the DT it goes. So perhaps a 
note stating reboot-mode node location is defined in platform specific 
binding docs.

> >>+
> >>+		loader {
> >>+			linux,mode = "loader";
> >>+			loader,magic = <BOOT_LOADER>;
> >>+		};
> >Sorry, my previous suggestion was not clear. I'm suggesting get rid of
> >the subnodes and just do properties like this:
> >
> >loader = <BOOT_LOADER>;
> >maskrom = <BOOT_MASKROM>;
> >
> >That's the same amount of information unless node names and linux,mode
> >values are going to diverge. Do they need to? I can't see a reason.
> 
>     Because the command"linux,mode" and value"loader,magic" is vendor
> specific. I don't know what commands and how many mode other platform will
> use. So as John says in his reply, this sort of flexibility help us adapt
> the driver to different hardware/system environments.

The only part of "reboot to fastboot" that is vendor specific would be 
the magic value. While we can have custom modes, we should standardize 
the common ones as much as possible. As I pointed out in my reply to 
John, we can still support vendor specific modes with just a property.

> >
> >We need to be clear what loader means. More specifically, it is boot
> >into bootloader shell.
>     Actually, Rockchip platform will reboot into a bootloader download mode
> with this command. This mode can download faster than maskrom download mode.

My point is proven. I assumed one thing and you meant something else. 
Doesn't matter what the mode is, just needs to be clear.

Rob

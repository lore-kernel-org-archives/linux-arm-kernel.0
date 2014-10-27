From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 12:08:06 -0500
Subject: [PATCH v1 01/10] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <108805117.sS9iL5zouT@diego>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <20141027164103.GD2006@localhost> <20141027164741.GJ14253@saruman>
 <108805117.sS9iL5zouT@diego>
Message-ID: <20141027170806.GL14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 06:05:35PM +0100, Heiko St?bner wrote:
> Am Montag, 27. Oktober 2014, 11:47:41 schrieb Felipe Balbi:
> > On Mon, Oct 27, 2014 at 05:41:03PM +0100, Johan Hovold wrote:
> > > On Mon, Oct 27, 2014 at 11:38:40AM -0500, Felipe Balbi wrote:
> > > > On Mon, Oct 27, 2014 at 04:26:46PM +0000, Romain Perier wrote:
> > > > > As discussed on the mailing list, it makes more sense to rename this
> > > > > property to "system-power-controller". Problem being that the word
> > > > > "source" usually tends to be used for inputs and that is out of
> > > > > control of the OS. The poweroff capability is an output which simply
> > > > > turns the system-power off. Also, this property might be used by
> > > > > drivers which power-off the system and power back on subsequent RTC
> > > > > alarms. This seems to suggest to remove "poweroff" from the property
> > > > > name and to choose "system-power-controller" as the more generic
> > > > > name. This patchs adds the required renaming changes and defines an
> > > > > helper function which is compatible with both properties, the old one
> > > > > prefixed by a vendor name and the new one without any prefix.
> > > > 
> > > > I think you still need to support poweroff-source since it has been
> > > > released on a stable kernel. Perhaps add a warning message telling users
> > > > it's deprecated and asking them to switch over to
> > > > system-power-controller ? Still, simply removing it isn't very nice.
> > > 
> > > No, Romain sent a patch that replaced "<vendor>,system-power-controller"
> > > with "poweroff-source". It's now in Mark's tree (for v3.19), and this
> > > series "reverts" to the old name minus the vendor-prefix.
> > 
> > oh, so poweroff-source isn't in Linus' tree yet ? (/me goes grep)
> > 
> > Then it should be fine. My bad.
> > 
> > Many of the other comments are still valid because even though
> > poweroff-source isn't in mainline yet, this series still creates
> > bisection points which are broken. The best solution would be to drop
> > all those patches from Mark's tree. Read, not revert, drop.
> 
> There have never been any users of the poweroff-source. The act8846 in the 
> radxarock would have been the first, but I held off with the dts patch as the 
> naming issue came up at the same time.
> 
> So I guess if Romain keeps the renaming together there shouldn't be any other 
> bad bisection points?

Not build breaks, but there will always be the commit below:

commit a88f5c6deb2a44f694b01aac48231ec97059b26a
Author: Romain Perier <romain.perier@gmail.com>
Date:   Tue Oct 14 06:31:12 2014 +0000

    dt-bindings: Document the standard property "poweroff-source"
    
    Signed-off-by: Romain Perier <romain.perier@gmail.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/Documentation/devicetree/bindings/power/poweroff.txt b/Documentation/devicetree/bindings/power/poweroff.txt
new file mode 100644
index 0000000..845868b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/poweroff.txt
@@ -0,0 +1,18 @@
+* Generic Poweroff capability
+
+Power-management integrated circuits or miscellaneous harware components are
+sometimes able to control the system power. The device driver associated to these
+components might needs to define poweroff capability, which tells to the kernel
+how to switch off the system. The corresponding driver must have the standard
+property "poweroff-source" in its device node. This property marks the device as
+able to shutdown the system. In order to test if this property is found
+programmatically, use the helper function "of_system_has_poweroff_source" from
+of.h .
+
+Example:
+
+act8846: act8846 at 5 {
+	 compatible = "active-semi,act8846";
+	 status = "okay";
+	 poweroff-source;
+}

Even if for a small time frame, there will always be a commit where we
called "poweroff-source" a standard binding and, as such, as should
support it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/b90740a2/attachment.sig>

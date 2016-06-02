From: b-liu@ti.com (Bin Liu)
Date: Thu, 2 Jun 2016 13:16:48 -0500
Subject: [PATCH 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
In-Reply-To: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
References: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160602181648.GB28820@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 02, 2016 at 07:31:03PM +0200, Hans de Goede wrote:
> Some SoCs have a single phy-hw-block with multiple phys, this is
> modelled by a single phy dts node, so we end up with multiple
> controller nodes with a phys property pointing to the phy-node
> of the otg-phy.
> 
> Only one of these controllers typically is an otg controller, yet we

Is it guaranteed that only one of them will be otg? 

> were checking the first controller who uses a phy from the block and
> then end up looking for a dr_mode property in e.g. the ehci controller.
> 
> Instead of looking for nodes with a phy property, look for nodes
> with a dr_mode property, so that we actually access the dr_mode property
> in a node which has it.

Quote from Documentation/devicetree/bindings/usb/generic.txt:
"- dr_mode: ...
		In case this attribute isn't
		passed via DT, USB DRD controllers should default to
		OTG."

So it is not mandatory to define dr_mode in DT, then you wouldn't be
able to find the controller in such case.

Regards,
-Bin.

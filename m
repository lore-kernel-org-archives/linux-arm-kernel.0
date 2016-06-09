From: b-liu@ti.com (Bin Liu)
Date: Thu, 9 Jun 2016 09:30:04 -0500
Subject: [PATCH v3 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared
 phy block
In-Reply-To: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
References: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160609143004.GA2167@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 05, 2016 at 04:59:33PM +0200, Hans de Goede wrote:
> Some SoCs have a single phy-hw-block with multiple phys, this is
> modelled by a single phy dts node, so we end up with multiple
> controller nodes with a phys property pointing to the phy-node
> of the otg-phy.
> 
> Only one of these controllers typically is an otg controller, yet we
> were checking the first controller who uses a phy from the block and
> then end up looking for a dr_mode property in e.g. the ehci controller.
> 
> This commit fixes this by adding an arg0 parameter to
> of_usb_get_dr_mode_by_phy and make of_usb_get_dr_mode_by_phy
> check that this matches the phandle args[0] value when looking for
> the otg controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add a args0 parameter instead of looking for nodes with a dr_mode property
> Changes in v3:
> -No changes
> ---
>  drivers/usb/common/common.c  | 31 ++++++++++++++++++-------------
>  drivers/usb/phy/phy-am335x.c |  2 +-
>  include/linux/usb/of.h       |  4 ++--
>  3 files changed, 21 insertions(+), 16 deletions(-)

This breaks am335x.

[   17.433166] /ocp/usb at 47400000/usb at 47401000: could not get #phy-cells
for /ocp/usb at 47400000/usb-phy at 47401300
[   17.443627] /ocp/usb at 47400000/usb at 47401800: could not get #phy-cells
for /ocp/usb at 47400000/usb-phy at 47401b00
[   17.454005] am335x-phy-driver 47401300.usb-phy: dr_mode 0
[   17.460518] 47401300.usb-phy supply vcc not found, using dummy
regulator
[   17.469685] /ocp/usb at 47400000/usb at 47401000: could not get #phy-cells
for /ocp/usb at 47400000/usb-phy at 47401300
[   17.479998] /ocp/usb at 47400000/usb at 47401800: could not get #phy-cells
for /ocp/usb at 47400000/usb-phy at 47401b00
[   17.490342] am335x-phy-driver 47401b00.usb-phy: dr_mode 0

Regards,
-Bin.

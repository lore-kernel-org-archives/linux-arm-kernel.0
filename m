From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Oct 2013 13:07:23 -0500
Subject: [PATCH 2/5] usb: gadget: s3c-hsotg: support configurable UTMI
 PHY width
In-Reply-To: <A2CA0424C0A6F04399FB9E1CD98E030458E16893@US01WEMBX2.internal.synopsys.com>
References: <1381140752-312-1-git-send-email-matt.porter@linaro.org>
 <1381140752-312-3-git-send-email-matt.porter@linaro.org>
 <20131010152922.GF28375@radagast> <5256DBD0.8030008@linaro.org>
 <20131010174620.GC19802@radagast>
 <A2CA0424C0A6F04399FB9E1CD98E030458E16893@US01WEMBX2.internal.synopsys.com>
Message-ID: <20131010180723.GF19802@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 10, 2013 at 05:57:54PM +0000, Paul Zimmerman wrote:
> > From: Felipe Balbi [mailto:balbi at ti.com]
> > Sent: Thursday, October 10, 2013 10:46 AM
> > 
> > On Thu, Oct 10, 2013 at 12:54:40PM -0400, Matt Porter wrote:
> > > On 10/10/2013 11:29 AM, Felipe Balbi wrote:
> > > >On Mon, Oct 07, 2013 at 06:12:29AM -0400, Matt Porter wrote:
> > > >>Extend dwc2 binding with an optional utmi phy width property.
> > > >>Enable the s3c-hsotg.c driver to use standard dwc2 binding
> > > >>and enable configuration of the UTMI phy width based on the
> > > >>property.
> > > >>
> > > >>Signed-off-by: Matt Porter <matt.porter@linaro.org>
> > > >>Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > > >>Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> > > >>---
> > > >>  Documentation/devicetree/bindings/staging/dwc2.txt |  4 ++++
> > > >>  drivers/usb/gadget/s3c-hsotg.c                     | 18 +++++++++++++++++-
> > > >>  drivers/usb/gadget/s3c-hsotg.h                     |  1 +
> > > >>  3 files changed, 22 insertions(+), 1 deletion(-)
> > > >>
> > > >>diff --git a/Documentation/devicetree/bindings/staging/dwc2.txt
> > b/Documentation/devicetree/bindings/staging/dwc2.txt
> > > >>index 1a1b7cf..fb6b8ee 100644
> > > >>--- a/Documentation/devicetree/bindings/staging/dwc2.txt
> > > >>+++ b/Documentation/devicetree/bindings/staging/dwc2.txt
> > > >>@@ -6,10 +6,14 @@ Required properties:
> > > >>  - reg : Should contain 1 register range (address and length)
> > > >>  - interrupts : Should contain 1 interrupt
> > > >>
> > > >>+Optional properties:
> > > >>+- snps,phy-utmi-width: Must contain the UTMI data width (either 8 or 16)
> > > >
> > > >isn't this available in any of the configuration registers ?
> > >
> > > Yes and no. HWCFG4 has a UTMI data width field. However, it has 3
> > > valid states, "8", "16", or "8 or 16". The BCM281xx implementation is
> > > set to the latter and the attached phy is 8-bit.
> > >
> > > Looking at dwc2 prior to Matthijs Kooijman's patch [1] which starts
> > > validating the value of phy_utmi_width in that driver, the pci.c
> > > dwc2_module_params .phy_utmi_width field there even had the comment,
> > > "/* 16 bits - NOT DETECTABLE */". The autodetect code in
> > > dwc2_set_param_phy_utmi_width() will fail if HWCFG4 has the "8 or 16"
> > > option as it just decides to default to a phy width of 16 if nothing
> > > is configured by the platform glue. This property would also allow
> > > this issue to be addressed in that driver.
> > 
> > fair enough, but I'd really like to hear from DT folks if your suggested
> > binding is acceptable. It seems like we can equally argue that it's a SW
> > configuration or HW description.
> 
> It's definitely a HW description - the width of the UTMI data connection.

right, but that description should be passed to the PHY, right ? DWC2
works with both widths (8 or 16).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/6207ef25/attachment.sig>

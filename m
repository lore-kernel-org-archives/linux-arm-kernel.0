From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Sep 2014 13:29:21 -0500
Subject: [Patch v9 1/3] usb: dwc3: qcom: Add device tree binding
In-Reply-To: <20140916181543.GA19101@usblab-sd-06.qualcomm.com>
References: <1410550088-8754-1-git-send-email-agross@codeaurora.org>
 <1410550088-8754-2-git-send-email-agross@codeaurora.org>
 <20140916181543.GA19101@usblab-sd-06.qualcomm.com>
Message-ID: <20140916182920.GF19010@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 16, 2014 at 11:15:43AM -0700, Jack Pham wrote:
> Hi Andy,
> 
> On Fri, Sep 12, 2014 at 02:28:06PM -0500, Andy Gross wrote:
> > +Example device nodes:
> > +
> > +		hs_phy: phy at 100f8800 {
> > +			compatible = "qcom,dwc3-hs-usb-phy";
> > +			reg = <0x100f8800 0x30>;
> 
> Just wanted to point out that in our downstream code, the glue
> device/driver, i.e. "qcom,dwc3", does claim an entire register region
> that encompasses the same registers used by these PHYs. I noticed you're
> not adding a reg resource to the glue node below in this patchset. In
> order to allow multiple devices to use the overlapping regions, we avoid
> calling devm_ioremap_resource() and instead call devm_ioremap_nocache()
> directly which bypasses the request_mem_region() call, which I don't
> think is an entirely correct thing to do.
> 
> On the other hand I'm trying to think of use cases on our other SOCs
> (MSM8974, APQ8084) where the glue actually would need access to the same
> or adjacent IO registers that couldn't just be handled directly by these
> PHY drivers. Should we accommodate for the potential of overlapping
> regions or should we just hold the line here and maybe only expose with
> finer granularity the registers that will actually be needed by the PHYs
> & glue respectively?

I prefer to keep things separated. Glue only needs to access whatever
belongs to glue. If a register related to PHY settings, it should be in
the PHY address space.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/b45ffe5a/attachment.sig>

From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 16 Aug 2013 14:23:26 +0100
Subject: [PATCH v3 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <520D500C.5070901@wwwdotorg.org>
References: <1376360992-1508-1-git-send-email-acourbot@nvidia.com>
 <1376360992-1508-2-git-send-email-acourbot@nvidia.com>
 <20130815115227.GC2562@localhost.localdomain>
 <520D500C.5070901@wwwdotorg.org>
Message-ID: <20130816132326.GC2909@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 04:02:52PM -0600, Stephen Warren wrote:
> On 08/15/2013 05:52 AM, Dave Martin wrote:
> > On Tue, Aug 13, 2013 at 11:29:48AM +0900, Alexandre Courbot wrote:
> >> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> >> can be invoked  using a consistent smc-based API on all supported
> >> platforms. This patch adds initial basic support for Trusted
> >> Foundations using the ARM firmware API. Current features are limited
> >> to the ability to boot secondary processors.
> 
> >> diff --git a/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> 
> >> +Required properties:
> >> +- compatible : "tl,trusted-foundations"
> >> +- version : Must contain the version number string of the Trusted Foundation
> >> +	firmware.
> > 
> > Are you sure there is no low-level way to probe vendor and version info?
> > If there is, then the DT should describe nothing except the fact that
> > the probe interface exists.
> > 
> > I also worry that two integrations on different SoCs might have the
> > same version number, yet still be different due to vendor-specific
> > features and options.
> 
> I would expect HW-specific compatible values also to be present in a DT.
> For example, perhaps:
> 
> compatible = "tl,trusted-foundations-nvidia-shield",
> "tl,trusted-foundations";
> 
> (nvidia vendor, shield board/implementation)
> 
> This would allow matching on the specific value
> "tl,trusted-foundations-nvidia-shield" in the future if some quirking
> was needed, but if this wasn't needed, drivers could just bind to the
> generic "tl,trusted-foundations".

That seems reasonable *unless* there is a reliable way to obtain
a vendor ID from the SMC ABI directly, in which case we should just
use that.

One could debate whether the extra compatible string should have
"nvidia," or "tl," but the fact that "nvidia" is in the name at all
pretty much narrows it down.

> 
> >> +- version : Must contain the version number string of the Trusted Foundation
> >> +	firmware.
> > 
> > Are you sure there is no low-level way to probe vendor and version info?
> > If there is, then the DT should describe nothing except the fact that
> > the probe interface exists.
> > 
> > I also worry that two integrations on different SoCs might have the
> > same version number, yet still be different due to vendor-specific
> > features and options.
> 
> Talking of the version - if we do need to represent this in the DT, how
> about 2 separate cells for major/minor version rather than encoding it
> into a string? Then, no parsing would be required.

I think the key thing here is to match whatever TF's native notion of
version is.

If it's truly a string with specific comparison rules, we should leave it
a string and write code to examine it.  If it's a simple <major minor>
pair, then putting it in the DT in this form makes sense.

And, as you previosly suggested, if there's a reliable ABI for getting
the firmware to tell you its version number, we should just use that and
not describe the version number in the DT at all.

I'm not in a position to answer that one.

If we really have no idea, we'll have to go with a best guess, and
change the compatible string later if necessary.  But it would be better
to get it right if we can.


If TF has version/vendor probe interfaces but those might be missing/
broken/wrong, we could still specify "vendor" and "version" properties
which allow the probed values to be overridden.

Cheers
---Dave

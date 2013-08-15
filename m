From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Aug 2013 16:02:52 -0600
Subject: [PATCH v3 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <20130815115227.GC2562@localhost.localdomain>
References: <1376360992-1508-1-git-send-email-acourbot@nvidia.com>
 <1376360992-1508-2-git-send-email-acourbot@nvidia.com>
 <20130815115227.GC2562@localhost.localdomain>
Message-ID: <520D500C.5070901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 05:52 AM, Dave Martin wrote:
> On Tue, Aug 13, 2013 at 11:29:48AM +0900, Alexandre Courbot wrote:
>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
>> can be invoked  using a consistent smc-based API on all supported
>> platforms. This patch adds initial basic support for Trusted
>> Foundations using the ARM firmware API. Current features are limited
>> to the ability to boot secondary processors.

>> diff --git a/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt

>> +Required properties:
>> +- compatible : "tl,trusted-foundations"
>> +- version : Must contain the version number string of the Trusted Foundation
>> +	firmware.
> 
> Are you sure there is no low-level way to probe vendor and version info?
> If there is, then the DT should describe nothing except the fact that
> the probe interface exists.
> 
> I also worry that two integrations on different SoCs might have the
> same version number, yet still be different due to vendor-specific
> features and options.

I would expect HW-specific compatible values also to be present in a DT.
For example, perhaps:

compatible = "tl,trusted-foundations-nvidia-shield",
"tl,trusted-foundations";

(nvidia vendor, shield board/implementation)

This would allow matching on the specific value
"tl,trusted-foundations-nvidia-shield" in the future if some quirking
was needed, but if this wasn't needed, drivers could just bind to the
generic "tl,trusted-foundations".

>> +- version : Must contain the version number string of the Trusted Foundation
>> +	firmware.
> 
> Are you sure there is no low-level way to probe vendor and version info?
> If there is, then the DT should describe nothing except the fact that
> the probe interface exists.
> 
> I also worry that two integrations on different SoCs might have the
> same version number, yet still be different due to vendor-specific
> features and options.

Talking of the version - if we do need to represent this in the DT, how
about 2 separate cells for major/minor version rather than encoding it
into a string? Then, no parsing would be required.

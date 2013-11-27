From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Nov 2013 09:49:11 +0000
Subject: [PATCH] Documentation: devicetree: arm: add lpae property to
 cpus/cpu bindings
In-Reply-To: <1385517172-803-1-git-send-email-olof@lixom.net>
References: <1385517172-803-1-git-send-email-olof@lixom.net>
Message-ID: <20131127094911.GE5402@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Nov 27, 2013 at 01:52:52AM +0000, Olof Johansson wrote:
> While the LPAE capability is determined by the kernel today, it is still
> useful to be able to specify the feature in the device tree. There is
> precedence from other architectures for this.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> My personal motive for this is to be able to tell which boards are
> work even trying to boot an LPAE kernel on, since we don't disable the
> platforms that are based on A8/A9 when LPAE is turned on. I'll add dtsi
> patches for A7/A15-based platforms once the binding is settled.

It would be nice to have this description of why you want to add this in
the commit message proper.

I don't see much point in this. If we're going to add this to the DTSIs
for all platforms that have CPUs with LPAE support, why not just check
if a given DT contains one of those CPUs to find out if it has LPAE
support?

The information this flag describes is at best redundant, but could also
be missing or present erroneously. 

It's also of no use to any OS actually running on the hardware, as it's
easier for an OS to check ID_MMFR0[3:0] than to parse a DTB. Likewise
for bootloaders.

> 
> I don't think it's worth trying to add those dependencies in Kconfig,
> by the way -- it'd be pretty verbose and churny.

I think if we want an early warning that a particular platform is not
going to support LPAE, this would be a better place to put it.

It's a shame we don't have a standard header in the Linux Image. If we
did, we could add a "uses LPAE" flag to the Linux Image that bootloaders
could check and refuse to run the Image or print a warning if the HW had
no LPAE support.

Thanks,
Mark.

> 
>  Documentation/devicetree/bindings/arm/cpus.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 91304353eea4..632015f8314f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -191,6 +191,14 @@ nodes to be present and contain the properties described below.
>  			  property identifying a 64-bit zero-initialised
>  			  memory location.
>  
> +	- lpae
> +		Usage: Indicates that the CPU can use the LPAE extensions to
> +		       address more than 32 bit physical memory.
> +		Value type: <empty>
> +		Definition:
> +			# On ARMv7 systems this boolean property is used
> +			  to indicate LPAE feature capability.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>  
>  	cpus {
> -- 
> 1.8.4.1.601.g02b3b1d
> 
> 

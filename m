From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jan 2014 10:54:39 +0000
Subject: [PATCH v4 4/6] devicetree: bindings: Document Krait L1/L2 EDAC
In-Reply-To: <1388434457-4194-5-git-send-email-sboyd@codeaurora.org>
References: <1388434457-4194-1-git-send-email-sboyd@codeaurora.org>
 <1388434457-4194-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140107105439.GC5906@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 08:14:15PM +0000, Stephen Boyd wrote:
> The Krait L1/L2 error reporting device is made up of two
> interrupts, one per-CPU interrupt for the L1 caches and one
> interrupt for the L2 cache.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 72 ++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 9130435..54de94b 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -191,6 +191,35 @@ nodes to be present and contain the properties described below.
>  			  property identifying a 64-bit zero-initialised
>  			  memory location.
>  
> +	- interrupts
> +		Usage: required for cpus with compatible string "qcom,krait".
> +		Value type: <prop-encoded-array>
> +		Definition: L1/CPU error interrupt
> +
> +	- next-level-cache
> +		Usage: optional
> +		Value type: <phandle>
> +		Definition: phandle pointing to the next level cache
> +
> +- cache node

Not sure this binding (cache node) belongs in cpus.txt

I am working on defining cache bindings for ARM within the C-state
standardization effort:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/215543.html

> +
> +	Description: Describes a cache in an ARM based system
> +
> +	- compatible
> +		Usage: required
> +		Value type: <string>
> +		Definition: shall contain at least "cache"

It is a bit vague, can't we just follow the ePAPR compatible definition ?
See posting above.

> +
> +	- cache-level
> +		Usage: required
> +		Value type: <u32>
> +		Definition: level in the cache heirachy

"hierarchy". I have a problem with the cache level definition, and in
particular the numbering, ie what the level number represents. If we
mean the cache level seen through the CLIDR and co., it is hard to use
it for shared caches since the level seen by different CPUs can actually
be different, or put it differently the level number might not be unique for
a shared cache. I need to think about a proper way to sort this out.

Lorenzo

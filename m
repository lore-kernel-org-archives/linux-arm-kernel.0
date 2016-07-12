From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Jul 2016 11:07:45 +0100
Subject: [PATCH v22 8/8] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20160712050514.22307-9-takahiro.akashi@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-9-takahiro.akashi@linaro.org>
Message-ID: <20160712100745.GA21909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Apologies for the delay on this.

On Tue, Jul 12, 2016 at 02:05:14PM +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for
> 	linux,crashkernel-base and crashkernel-size,
> 	linux,usable-memory-range, and
> 	linux,elfcorehdr
> used by arm64 kexec/kdump to decribe the kdump reserved area, and
> the elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [takahiro.akashi at linaro.org:
>     renamed "usable-memory" to "usable-memory-range",
>     added "linux,crashkernel-base" and "-size" ]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 6ae9d82..d7a3a86 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
>  book3e) by some versions of kexec-tools to tell the new kernel that it
>  is being booted by kexec, as the booting environment may differ (e.g.
>  a different secondary CPU release mechanism)
> +
> +linux,crashkernel-base
> +linux,crashkernel-size
> +----------------------
> +These properties are set (on PowerPC and arm64) during kdump to tell
> +use-space tools, like kexec-tools, the base address of the crash-dump
> +kernel's reserved area of memory and the size. e.g.

No need to mention what consumes this. Just state what it describes,
e.g.

	These properties describe the base and size of the crash-dump
	kernel's reserved area of memory. Valid for PowerPC and arm64.

> +
> +/ {
> +	chosen {
> +		linux,crashkernel-base = <0x9 0xf0000000>;
> +		linux,crashkernel-size = <0x0 0x10000000>;
> +	};
> +};
> +
> +linux,usable-memory-range
> +-------------------------
> +
> +This property is set (currently only on arm64) during kdump to tell
> +the crash-dump kernel the base address of its reserved area of memory,
> +and the size. e.g.

The description sounds like this duplicates linux,crashkernel-*. What is
the difference between the two?

On powerpc it looks like there's a linux,usable-memory property (without
the -range suffix). How do these differ?

> +
> +/ {
> +	chosen {
> +		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> +	};
> +};
> +
> +Please note that, if this property is present, any memory regions under
> +"memory" nodes will be ignored.

What exactly do you mean by "ignored"?

Do we truly ignore this property, or do we map that memory at some
point, even if not used for general allocation?

> +
> +linux,elfcorehdr
> +----------------
> +
> +This property is set (currently only on arm64) during kdump to tell
> +the crash-dump kernel the address and size of the elfcorehdr that describes
> +the old kernel's memory as an elf file. This memory must reside within
> +the area described by 'linux,usable-memory-range'. e.g.


As with the linux,crashkernel-* properties, just state what this
describes, e.g.

	This property describes the base and size of the ELF core
	header, which describes the old kernel's memory as an ELF file.
	This memory must reside within the range described by
	linux,usable-memory-range.

That said, this falling within usable-memory feels very odd, because
it's not actually usable for general purposes. Why can the kernel not
memremap this, such that it need not be in usable-memory?

Thanks,
Mark.

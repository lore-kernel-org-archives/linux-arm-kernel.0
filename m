From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 10:51:15 +0000
Subject: [PATCH v2 12/16] ARM: Xen: Document UEFI support on Xen ARM
 virtual platforms
In-Reply-To: <1452840929-19612-13-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-13-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160118105115.GD21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:55:25PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a "uefi" node under /hypervisor node in FDT, then Linux kernel could
> scan this to get the UEFI information.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index 0f7b9c2..fbc17ae 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -15,6 +15,36 @@ the following properties:
>  - interrupts: the interrupt used by Xen to inject event notifications.
>    A GIC node is also required.
>  
> +To support UEFI on Xen ARM virtual platforms, Xen pupulates the FDT "uefi" node
> +under /hypervisor with following parameters:

s/pupulates/populates/

> +
> +________________________________________________________________________________
> +Name                      | Size   | Description
> +================================================================================
> +xen,uefi-system-table     | 64-bit | Guest physical address of the UEFI System
> +			  |	   | Table.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-start       | 64-bit | Guest physical address of the UEFI memory
> +			  |	   | map.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-size        | 32-bit | Size in bytes of the UEFI memory map
> +                          |        | pointed to in previous entry.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-desc-size   | 32-bit | Size in bytes of each entry in the UEFI
> +                          |        | memory map.
> +--------------------------------------------------------------------------------
> +xen,uefi-mmap-desc-ver    | 32-bit | Version of the mmap descriptor format.
> +--------------------------------------------------------------------------------
> +
> +Below is the format of the mmap descriptor.
> +typedef struct {
> +	u32 type;
> +	u32 pad;
> +	u64 phys_addr;
> +	u64 virt_addr;
> +	u64 num_pages;
> +	u64 attribute;
> +} efi_memory_desc_t;

I don't think we should describe this here, as it duplicates the UEFI
spec, and is techincally incorrect the above is only guaranteed to be
the prefix of each memory descriptor -- that's why the
uefi-mmap-desc-size property exists.

We don't do this in Documentation/arm/uefi.txt, and I don't see why we
should do so here.

Does Xen handle arbitrary size memory map descriptors? I'm not sure what
new information might be passed in future additions to the descriptor
format, and I'm not sure what should happen in the Dom0 case.

>  Example (assuming #address-cells = <2> and #size-cells = <2>):
>  
> @@ -22,4 +52,16 @@ hypervisor {
>  	compatible = "xen,xen-4.3", "xen,xen";
>  	reg = <0 0xb0000000 0 0x20000>;
>  	interrupts = <1 15 0xf08>;
> +	uefi {
> +		xen,uefi-system-table = <0xXXXXXXXX>;
> +		xen,uefi-mmap-start = <0xXXXXXXXX>;
> +		xen,uefi-mmap-size = <0xXXXXXXXX>;
> +		xen,uefi-mmap-desc-size = <0xXXXXXXXX>;
> +		xen,uefi-mmap-desc-ver = <0xXXXXXXXX>;
> +        };
>  };
> +
> +These "xen,uefi-*" parameters are similar to those in Documentation/arm/uefi.txt
> +which are used by normal UEFI. But to Xen ARM virtual platforms, it needs to
> +introduce a Xen specific UEFI and it doesn't want to mix with normal UEFI.
> +Therefore, it defines these parameters under /hypervisor node.

Could we please describe what that actual difference is?

I know that the OS must handle a system table differently under Xen, but
this doesn't describe what it should do.

I assume that the OS can handle the memory map in an identical fashion
to when it is native. Is that true?

Mark.

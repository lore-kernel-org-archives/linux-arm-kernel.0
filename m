From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jun 2017 14:31:13 +0100
Subject: [PATCH] arm64: use readq() instead of readl() to read 64bit
 entry_point
In-Reply-To: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
References: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170626133113.GB28086@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending as I bungled modifying the Cc list]

On Mon, Jun 26, 2017 at 03:16:25PM +0200, Luc Van Oostenryck wrote:
> Here the entrypoint, declared as a 64 bit integer, is read from
> a pointer to 64bit integer but the read is done via readl_relaxed()
> which is for 32bit quantities.
> 
> All the high bits will thus be lost which change the meaning
> of the test against zero done later.
> 
> Fix this by using readq_relaxed() instead as it should be for
> 64bit quantities.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This looks right per my reading of the spec. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

It would be good if someone could test this on HW implementing the
parking protocol. I've Cc'd those who've given Tested-by in the past.

Thanks,
Mark.

> 
> ---
> 
> !!! Warning !!!
>    I don't have the HW to test this, nor have I read the ACPI specs.
>    This is only compile tested.
> ---
>  arch/arm64/kernel/acpi_parking_protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index 1f5655cd9..f35e80aad 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -125,7 +125,7 @@ static void acpi_parking_protocol_cpu_postboot(void)
>  	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
>  	__le64 entry_point;
>  
> -	entry_point = readl_relaxed(&mailbox->entry_point);
> +	entry_point = readq_relaxed(&mailbox->entry_point);
>  	/*
>  	 * Check if firmware has cleared the entry_point as expected
>  	 * by the protocol specification.
> -- 
> 2.13.0
> 

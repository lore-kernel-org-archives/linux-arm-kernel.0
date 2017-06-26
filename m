From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jun 2017 14:31:00 +0100
Subject: [PATCH] arm64: use readq() instead of readl() to read 64bit
 entry_point
In-Reply-To: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
References: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170626133059.GK1691@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
> 
> ---
> 
> !!! Warning !!!
>    I don't have the HW to test this, nor have I read the ACPI specs.
>    This is only compile tested.

This looks correct to me, but I'd like an Ack from Lorenzo before I take
it because it's not clear to me what issues can arise if firmware only
writes zero to the bottom 32 bits of the jump address and leaves the upper
bits intact. If firmware does this, then this patch will result in a
WARN, but I can't figure out what this part of the spec is trying to
achieve.

Will

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

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 17:34:00 +0000
Subject: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
In-Reply-To: <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
Message-ID: <20110114173400.GB22505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
> Is the name 'omap_sram_push' wrong then?
> What about the following?
> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
> 
>        omap_sram_ceil -= size;
>        omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
>  -     memcpy((void *)omap_sram_ceil, start, size);
>  -     flush_icache_range((unsigned long)omap_sram_ceil,
>  -             (unsigned long)(omap_sram_ceil + size));
> 
>  -     return (void *)omap_sram_ceil;
>  +    return fncpy((void *)omap_sram_ceil, start, size);

It's more correct, but still missing out on the type safety which we've
tried to provide with fncpy.  Note also the other issue with Dave Martin
has raised though - this isn't ready for merging yet.

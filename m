From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 24 Jul 2011 15:56:17 -0400 (EDT)
Subject: [PATCH] ARM: Set proper TEXT_OFFSET for newer MSMs
In-Reply-To: <1311529149-20213-1-git-send-email-sboyd@codeaurora.org>
References: <1311529149-20213-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1107241548170.1762@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Jul 2011, Stephen Boyd wrote:

> MSMs post 8x50 have 2Mb at the beginning of RAM reserved for
> shared memory. Since the kernel hasn't typically been told this
> RAM exists, PHYS_OFFSET has been set to 0xN0200000 and the memory
> atags passed to the kernel have matched. This doesn't play nicely
> with things such as AUTO_ZRELADDR, which doesn't work at all, and
> dynamic phys to virt, which requires an MSM specific workaround.
> 
> Work around these issues by telling the kernel RAM starts at
> 0xN0000000 (it actually does) and fixup the atags from the
> bootloader (if necessary) to say the same. In addition, make sure
> to set TEXT_OFFSET at least 2Mb beyond the start of RAM so that
> the kernel doesn't end up being decompressed into shared memory.
> 
> After doing this, AUTO_ZRELADDR should work on MSM with no
> problems and ARM_PATCH_PHYS_VIRT_16BIT should no longer be
> necessary.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>

[..]

> +static void __init msm7x30_fixup(struct machine_desc *desc, struct tag *tag,
> +			 char **cmdline, struct meminfo *mi)
> +{
> +	for (; tag->hdr.size; tag = tag_next(tag))
> +		if (tag->hdr.tag == ATAG_MEM && tag->u.mem.start == 0x200000)
> +			tag->u.mem.start = 0;
> +}

Don't you need to also increase tag->u.mem.size  by 2MB ?

Other than that:

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas

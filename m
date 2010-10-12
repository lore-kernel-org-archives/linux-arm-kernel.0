From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 12 Oct 2010 12:49:32 +0900
Subject: [patch 2/2] ARM: mach-shmobile: Add zboot support for SuperH
	Mobile ARM
In-Reply-To: <20101008075917.137584753@vergenet.net>
References: <20101008075726.236142425@vergenet.net>
	<20101008075917.137584753@vergenet.net>
Message-ID: <AANLkTimhAMpYHSjcrEQEfaDrZ=vGj+S00aYet-_bFhQv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 8, 2010 at 4:57 PM, Simon Horman <horms@verge.net.au> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> When COFNIG_ZBOOT_ROM is selected, the resulting zImage file will be small
> boot loader and may be burned to rom or flash.
>
> This is the board-specific portion of this patch-set.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Hey Simon,

Thanks for your work on this!

> +static void __init
> +fixup_ap4evb(struct machine_desc *desc, struct tag *tag,
> + ? ? ? ? ? ?char **cmdline, struct meminfo *mi)
> +{
> +#ifdef CONFIG_ZBOOT_ROM
> + ? ? ? /*
> + ? ? ? ?* below settings are needed when zboot
> + ? ? ? ?*/
> + ? ? ? tag->hdr.tag ? ? ? ? ? ?= ATAG_CORE;
> + ? ? ? tag->hdr.size ? ? ? ? ? = tag_size(tag_core);
> + ? ? ? tag->u.core.flags ? ? ? = 0;
> + ? ? ? tag->u.core.pagesize ? ?= 0;
> + ? ? ? tag->u.core.rootdev ? ? = 0;
> +
> + ? ? ? tag ? ? ? ? ? ? ? ? ? ? = tag_next(tag);
> + ? ? ? tag->hdr.tag ? ? ? ? ? ?= ATAG_MEM;
> + ? ? ? tag->hdr.size ? ? ? ? ? = tag_size(tag_mem32);
> + ? ? ? tag->u.mem.size ? ? ? ? = CONFIG_MEMORY_SIZE;
> + ? ? ? tag->u.mem.start ? ? ? ?= CONFIG_MEMORY_START;
> +
> + ? ? ? tag ? ? ? ? ? ? ? ? ? ? = tag_next(tag);
> + ? ? ? tag->hdr.tag ? ? ? ? ? ?= ATAG_NONE;
> + ? ? ? tag->hdr.size ? ? ? ? ? = 0;
> +#endif

Hm, I wonder if this part can be rearranged. Perhaps I'm
misunderstanding, but I would really really prefer if the memory
information could be passed from the romImage header instead of adding
fixups in the board specific code. This code looks like a workaround
for not passing information properly. We probably want to pass other
parameters anyway, so it shouldn't be any big issue.

Cheers,

/ magnus

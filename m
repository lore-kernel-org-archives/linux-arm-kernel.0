From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Tue, 23 Nov 2010 16:17:53 -0200
Subject: 'perf test' failed on ARM
In-Reply-To: <20101123163106.GA25677@debian>
References: <AANLkTik4QDCD0rAZ=04Ph23ApZ822BBoOWEiPEp7GBNr@mail.gmail.com>
	<20101123163106.GA25677@debian>
Message-ID: <20101123181753.GC11101@ghostprotocols.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Nov 23, 2010 at 10:08:18PM +0530, Rabin Vincent escreveu:
> On Tue, Nov 23, 2010 at 04:07:39PM +0800, Ming Lei wrote:
> > 'perf test' is failed on linux 2.6.37-rc2/rc3, follows log info:
> > 
> > root at beagleboard:/mnt/omap/linux-2.6-omap/tools/perf# ./perf test -v 3
> >  1: vmlinux symtab matches kallsyms:
> > --- start ---
> > dso__find_symbol_by_name ---- end ----
> > vmlinux symtab matches kallsyms: FAILED!
> > 
> > Any suggestions?
> 
> There seems to be a problem with the symbol handling code.  Patch below.
> With this patch the command executes further, but the test fails because
> of other reasons:
> 
>    1: vmlinux symtab matches kallsyms:
>   --- start ---
>   map_groups__set_modules_path_dir: cannot open /lib/modules/2.6.37-rc3-next-20101122+/kernel dir
>   Problems creating module maps, continuing anyway...
>   map_groups__set_modules_path_dir: cannot open /lib/modules/2.6.37-rc3-next-20101122+/kernel dir
>   Problems creating module maps, continuing anyway...
>   Looking at the vmlinux_path (6 entries long)
>   Using vmlinux for symbols
>   0xc011ab68: diff end addr for __kprobes_text_start v: 0xc012b87f k: 0xc011b353
>   0xc012b880: kallsyms_addresses not on kallsyms
>   0xc0138c90: kallsyms_num_syms not on kallsyms
>   0xc0138ca0: kallsyms_names not on kallsyms
>   0xc015c010: kallsyms_markers not on kallsyms
>   0xc015c0f0: kallsyms_token_table not on kallsyms
>   0xc015c490: kallsyms_token_index not on kallsyms
>   Maps only in vmlinux:
>    c0014c5c-ffffffff 0 [kernel].init
>   Maps in vmlinux with a different name in kallsyms:
>   Maps only in kallsyms:
>   ---- end ----
>   vmlinux symtab matches kallsyms: FAILED!
> 
> >From e48b8a0dc149e3b8f249f46dc6e9c25e2cc58601 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Tue, 23 Nov 2010 21:35:56 +0530
> Subject: [PATCH] perf symbols: remove incorrect open-coded container_of()
> 
> At least on ARM, padding is inserted between rb_node and sym in struct
> symbol_name_rb_node, causing "((void *)sym) - sizeof(struct rb_node)" to
> point inside rb_node rather than to the symbol_name_rb_node.  Fix this
> by converting the code to use container_of().
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Ouch, thanks for the patch, container_of is much cleaner.

- Arnaldo

>  tools/perf/util/symbol.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index b39f499..0500895 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -295,7 +295,9 @@ static void symbols__insert_by_name(struct rb_root *self, struct symbol *sym)
>  {
>  	struct rb_node **p = &self->rb_node;
>  	struct rb_node *parent = NULL;
> -	struct symbol_name_rb_node *symn = ((void *)sym) - sizeof(*parent), *s;
> +	struct symbol_name_rb_node *symn, *s;
> +
> +	symn = container_of(sym, struct symbol_name_rb_node, sym);
>  
>  	while (*p != NULL) {
>  		parent = *p;
> -- 
> 1.7.2.3

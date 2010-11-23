From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Nov 2010 22:08:18 +0530
Subject: 'perf test' failed on ARM
In-Reply-To: <AANLkTik4QDCD0rAZ=04Ph23ApZ822BBoOWEiPEp7GBNr@mail.gmail.com>
References: <AANLkTik4QDCD0rAZ=04Ph23ApZ822BBoOWEiPEp7GBNr@mail.gmail.com>
Message-ID: <20101123163106.GA25677@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 04:07:39PM +0800, Ming Lei wrote:
> 'perf test' is failed on linux 2.6.37-rc2/rc3, follows log info:
> 
> root at beagleboard:/mnt/omap/linux-2.6-omap/tools/perf# ./perf test -v 3
>  1: vmlinux symtab matches kallsyms:
> --- start ---
> dso__find_symbol_by_name ---- end ----
> vmlinux symtab matches kallsyms: FAILED!
> 
> Any suggestions?

There seems to be a problem with the symbol handling code.  Patch below.
With this patch the command executes further, but the test fails because
of other reasons:

   1: vmlinux symtab matches kallsyms:
  --- start ---
  map_groups__set_modules_path_dir: cannot open /lib/modules/2.6.37-rc3-next-20101122+/kernel dir
  Problems creating module maps, continuing anyway...
  map_groups__set_modules_path_dir: cannot open /lib/modules/2.6.37-rc3-next-20101122+/kernel dir
  Problems creating module maps, continuing anyway...
  Looking at the vmlinux_path (6 entries long)
  Using vmlinux for symbols
  0xc011ab68: diff end addr for __kprobes_text_start v: 0xc012b87f k: 0xc011b353
  0xc012b880: kallsyms_addresses not on kallsyms
  0xc0138c90: kallsyms_num_syms not on kallsyms
  0xc0138ca0: kallsyms_names not on kallsyms
  0xc015c010: kallsyms_markers not on kallsyms
  0xc015c0f0: kallsyms_token_table not on kallsyms
  0xc015c490: kallsyms_token_index not on kallsyms
  Maps only in vmlinux:
   c0014c5c-ffffffff 0 [kernel].init
  Maps in vmlinux with a different name in kallsyms:
  Maps only in kallsyms:
  ---- end ----
  vmlinux symtab matches kallsyms: FAILED!

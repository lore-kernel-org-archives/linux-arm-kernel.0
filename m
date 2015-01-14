From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 11:22:10 +0000
Subject: [PATCH 1/2] perf symbols: Ignore mapping symbols on aarch64
In-Reply-To: <1421168344-5363-1-git-send-email-victor.kamensky@linaro.org>
References: <1421168344-5363-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20150114112210.GF4050@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 04:59:03PM +0000, Victor Kamensky wrote:
> Aarch64 ELF files use mapping symbols with special names $x, $d
> to identify regions of Aarch64 code (see Aarch64 ELF ABI - "ARM
> IHI 0056B", section "4.5.4 Mapping symbols").
> 
> The patch filters out these symbols at load time, similar to
> "696b97a perf symbols: Ignore mapping symbols on ARM" changes
> done for ARM before V8.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Avi Kivity <avi@cloudius-systems.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> ---
>  tools/perf/util/symbol-elf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 06fcd1b..1e188dd 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -862,6 +862,14 @@ int dso__load_sym(struct dso *dso, struct map *map,
>  			    !strcmp(elf_name, "$t"))
>  				continue;
>  		}
> +		/* Reject Aarch64 ELF "mapping symbols": these aren't unique and
> +		 * don't identify functions, so will confuse the profile
> +		 * output: */
> +		if (ehdr.e_machine == EM_AARCH64) {
> +			if (!strcmp(elf_name, "$x") ||
> +			    !strcmp(elf_name, "$d"))
> +				continue;
> +		}

Do we need to skip $x.* and $d.* too? I doubt GCC generates them, but they
are permitted by the ELF ABI.

Will

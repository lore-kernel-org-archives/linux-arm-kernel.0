From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 21 Jan 2011 20:17:18 +0300
Subject: [PATCH] fix perf Annotation of Thumb code
In-Reply-To: <20110121163922.GA31398@davesworkthinkpad>
References: <20110121163922.GA31398@davesworkthinkpad>
Message-ID: <4D39BF9E.3030007@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Dr. David Alan Gilbert wrote:

>   In ARM's Thumb mode the bottom bit of the symbol address is set to mark
> the function as Thumb; the instructions are in reality 2 or 4 byte on 2
> byte alignments, and when the +1 address is used in annotate it causes
> objdump to disassemble invalid instructions.  

>   The patch removes that bottom bit during symbol loading.
>   This patch is against current linus's git, (2b1caf.....).
>   Many thinks to Dave Martin for comments on an initial version of the patch.


> Dave

> (For reference this corresponds to this bug
> https://bugs.launchpad.net/linux-linaro/+bug/677547 )

>         Signed-off-by: Dr. David Alan Gilbert <david.gilbert@linaro.org>

    Hm, I think there should be no spaces/tabs before signoff...

> ---

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 15ccfba..36e76c1 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1161,6 +1161,13 @@ static int dso__load_sym(struct dso *self, struct map *map, const char *name,
>  
>  		section_name = elf_sec__name(&shdr, secstrs);
>  
> +		/* On ARM, symbols for thumb functions have 1 added to
> +		 * the symbol address as a flag - remove it */
> +		if ((ehdr.e_machine == EM_ARM) &&
> +			(map->type == MAP__FUNCTION) &&
> +			(sym.st_value & 1))
> +			sym.st_value-=1;

   The coding style used suggests spaces around -=.

WBR, Sergei

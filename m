From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Nov 2013 13:58:54 +0000
Subject: [RFC PATCH V2 1/2] dtc: add 'compat' output option,
 prints board string
In-Reply-To: <728deb9bbeab491a728da077aa5e47c0e01bccf8.1384798508.git.jason@lakedaemon.n
 et>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <cover.
 1384798508.git.jason@lakedaemon.net> <
 728deb9bbeab491a728da077aa5e47c0e01bccf8.1384798508.git.jason@lakedaemon.
 net>
Message-ID: <20131119135854.6A40EC4079D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 18:38:14 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> Consumers of the Linux kernel's build products are beginning to hardcode
> the filenames of the dtbs generated.  Since the dtb filenames are
> currently the dts filename s/dts/dtb/, this prevents the kernel
> community from renaming dts files as needed.
> 
> Let's provide a consistent naming structure for consumers to script
> against.  Or at least, as consistent as the dts properties themselves.
> 
> With this patch, adding the '-O compat' option to the dtc commandline
> will cause dtc to parse the provided file, and print out the board
> compatible string to stdout.

Can you use the fdtget tool here instead? It will parse and return
property values for a given .dtb.

It certainly makes sense to post this here for the purpose of review,
but any changes to dtc need to be against the upstream dtc repository.

g.


> This will facilitate an 'installdtbs.sh' script in the kernel for naming
> dtb files by their compatible string, eg:
> 
> $ dtc -I dtb -O compat arch/arm/boot/dts/armada-370-mirabox.dtb
> globalscale,mirabox
> 
> This change will also simplify distribution install scripts that need to
> search through many dtbs to find the right one for a target board.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> changes since v1:
>  - made patch against in-tree dtc code to facilitate testing
>  - dtc prints compatible string to stdout now, instead of creating symlink
>     - should be more flexible for end-users
> 
>  scripts/dtc/dtc.c      | 3 +++
>  scripts/dtc/dtc.h      | 1 +
>  scripts/dtc/flattree.c | 9 +++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
> index a375683c1534..89264bb0a3dd 100644
> --- a/scripts/dtc/dtc.c
> +++ b/scripts/dtc/dtc.c
> @@ -68,6 +68,7 @@ static void  __attribute__ ((noreturn)) usage(void)
>  	fprintf(stderr, "\t\tOutput formats are:\n");
>  	fprintf(stderr, "\t\t\tdts - device tree source text\n");
>  	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
> +	fprintf(stderr, "\t\t\tcompat - print board compatible string\n");
>  	fprintf(stderr, "\t\t\tasm - assembler source\n");
>  	fprintf(stderr, "\t-V <output version>\n");
>  	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", DEFAULT_FDT_VERSION);
> @@ -250,6 +251,8 @@ int main(int argc, char *argv[])
>  		dt_to_blob(outf, bi, outversion);
>  	} else if (streq(outform, "asm")) {
>  		dt_to_asm(outf, bi, outversion);
> +	} else if (streq(outform, "compat")) {
> +		dt_to_compat(bi);
>  	} else if (streq(outform, "null")) {
>  		/* do nothing */
>  	} else {
> diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
> index 3e42a071070e..d4e47c697c2f 100644
> --- a/scripts/dtc/dtc.h
> +++ b/scripts/dtc/dtc.h
> @@ -255,6 +255,7 @@ void process_checks(int force, struct boot_info *bi);
>  
>  void dt_to_blob(FILE *f, struct boot_info *bi, int version);
>  void dt_to_asm(FILE *f, struct boot_info *bi, int version);
> +void dt_to_compat(struct boot_info *bi);
>  
>  struct boot_info *dt_from_blob(const char *fname);
>  
> diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
> index 665dad7bb465..bdbd3d7e8964 100644
> --- a/scripts/dtc/flattree.c
> +++ b/scripts/dtc/flattree.c
> @@ -577,6 +577,15 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version)
>  	data_free(strbuf);
>  }
>  
> +void dt_to_compat(struct boot_info *bi)
> +{
> +	struct property *prop;
> +
> +	prop = get_property(bi->dt, "compatible");
> +
> +	printf("%s\n", prop->val.val);
> +}
> +
>  struct inbuf {
>  	char *base, *limit, *ptr;
>  };
> -- 
> 1.8.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: rostedt@goodmis.org (Steven Rostedt)
Date: Sat, 13 Mar 2010 12:41:07 -0500
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <1268462987-8271-8-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
Message-ID: <1268502067.3366.9.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-03-13 at 12:19 +0530, Rabin Vincent wrote:
> On ARM, we have two ABIs, and the ABI used is controlled via a config
> option.  Object files built with one ABI can't be merged with object
> files built with the other ABI.  So, record_mcount.pl needs to use the
> same compiler flags as the kernel when generating the object file with
> the mcount locations.  Ensure this by passing CFLAGS to the script.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  scripts/Makefile.build |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 0b94d2f..2535c11 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -209,7 +209,8 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>  	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
>  	"$(if $(CONFIG_64BIT),64,32)" \
> -	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> +	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
> +	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \

Again, I'll have to test this on other archs, just to make sure its does
not cause any side effects. Oh, I forgot I now have a MIPS board I can
test on too. I'll probably do this on Monday.

Thanks,

-- Steve

>  	"$(if $(part-of-module),1,0)" "$(@)";
>  endif
>  

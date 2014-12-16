From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 16 Dec 2014 12:15:54 +0100
Subject: [PATCH] arm/rpc: avoid static keyword removal via define
In-Reply-To: <1418633287-5019-2-git-send-email-borntraeger@de.ibm.com>
References: <1418633287-5019-1-git-send-email-borntraeger@de.ibm.com>
 <1418633287-5019-2-git-send-email-borntraeger@de.ibm.com>
Message-ID: <5490146A.3000408@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.12.2014 um 09:48 schrieb Christian Borntraeger:
> commit 4486b86368d7 ("[ARM] riscpc: fix decompressor font file handling")
> introduced Makefile magic to avoid building a file two times. Using
> -Dstatic= does break some assumptions on compiler.h that were introduced
> for READ_ONCE.
> 
> Lets just use sed on the copy instead of using a define.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

This fixed the linux-next build http://kisskb.ellerman.id.au/kisskb/target/1508/
Unless anybody complains, I will send the pull request for the access_once tree tomorrow and I have this patch applied on top.

Christian


> ---
>  arch/arm/boot/compressed/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 3ea230a..198f12a 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -196,10 +196,11 @@ $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
> 
>  $(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y) FORCE
> 
> -CFLAGS_font.o := -Dstatic=
> -
> +# use the font from lib/fonts/. We have to make the font global,
> +# for the decompressor so lets remove the static declaration
>  $(obj)/font.c: $(FONTC)
>  	$(call cmd,shipped)
> +	sed -i s/static//g $@
> 
>  $(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
>  	$(call cmd,shipped)
> 

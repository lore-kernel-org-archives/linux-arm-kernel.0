From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 19 Dec 2011 10:27:28 +0200
Subject: [PATCH] ARM: Fix cross compilation broken by failing size command
In-Reply-To: <1324032146-723-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <Message-ID: <20111214215815.GP32251@atomide.com>
 <1324032146-723-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <4EEEF570.2040502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

On 12/16/11 12:42, Janusz Krzysztofik wrote:
> Since commit 5ffb04f6690d71fab241b3562ebf52b893ac4ff1, "ARM: zImage:
> make sure appended DTB doesn't get overwritten by kernel .bss", the
> native 'size' command, which is now always used for calculation of the
> kernel bss size, may break in selected cross compilation environments
> with error messages like:
> 
> size: arch/arm/boot/compressed/../../../../vmlinux: File format is ambiguous
> size: Matching formats: elf32-littlearm elf32-littlearm-symbian elf32-littlearm-vxworks
> 
> As a consequence, the KBSS_SZ variable extracted from the size output is
> empty, and the the final linker command, provided with incorrectly
> formatted arguments, also fails:
> 
>   LD      arch/arm/boot/compressed/vmlinux
>   arm-angstrom-linux-uclibcgnueabi-ld:--defsym _kernel_bss_size=: syntax error
> 
> Don't append the '_kernel_bss_size=$(KBSS_SZ)' argument to the linker
> command line if that variable is empty because of the failing size
> command. Moreover, use $(CROSS_COMPILE)size if available instead of
> native size.
> 
> Created and tested against linux-3.2-rc5.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---

Tested-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks for the patch, it fixes the build for me, so you are
not the only one having this issue...
I currently, use CodeSourcery 2010q1, but have multiple
cross tool chains installed.


-- 
Regards,
Igor.

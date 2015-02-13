From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Feb 2015 17:32:44 +0000
Subject: [RFC PATCH v2 14/26] early kprobes: ARM: introduce early kprobes
 related code area.
In-Reply-To: <1423743635-12629-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
 <1423743635-12629-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20150213173244.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 08:20:35PM +0800, Wang Nan wrote:
> In arm's vmlinux.lds, introduces code area inside text section.
> Executable area used by early kprobes will be allocated from there.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  arch/arm/include/asm/kprobes.h | 31 +++++++++++++++++++++++++++++--
>  arch/arm/kernel/vmlinux.lds.S  |  2 ++
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> index 3ea9be5..0a4421e 100644
> --- a/arch/arm/include/asm/kprobes.h
> +++ b/arch/arm/include/asm/kprobes.h
> @@ -17,16 +17,42 @@
>  #define _ARM_KPROBES_H
>  
>  #include <linux/types.h>
> -#include <linux/ptrace.h>
> -#include <linux/notifier.h>
>  
>  #define __ARCH_WANT_KPROBES_INSN_SLOT
>  #define MAX_INSN_SIZE			2
>  
> +#ifdef __ASSEMBLY__
> +
> +#define KPROBE_OPCODE_SIZE	4
> +#define MAX_OPTINSN_SIZE (optprobe_template_end - optprobe_template_entry)
> +
> +#ifdef CONFIG_EARLY_KPROBES
> +#define EARLY_KPROBES_CODES_AREA					\
> +	. = ALIGN(8);							\
> +	VMLINUX_SYMBOL(__early_kprobes_start) = .;			\
> +	VMLINUX_SYMBOL(__early_kprobes_code_area_start) = .;		\
> +	. = . + MAX_OPTINSN_SIZE * CONFIG_NR_EARLY_KPROBES_SLOTS;	\
> +	VMLINUX_SYMBOL(__early_kprobes_code_area_end) = .;		\
> +	. = ALIGN(8);							\
> +	VMLINUX_SYMBOL(__early_kprobes_insn_slot_start) = .;		\
> +	. = . + MAX_INSN_SIZE * KPROBE_OPCODE_SIZE * CONFIG_NR_EARLY_KPROBES_SLOTS;\
> +	VMLINUX_SYMBOL(__early_kprobes_insn_slot_end) = .;		\
> +	VMLINUX_SYMBOL(__early_kprobes_end) = .;
> +
> +#else
> +#define EARLY_KPROBES_CODES_AREA
> +#endif

Please don't spread vmlinux specific stuff around the kernel include files.
Let's try to keep it contained to a minimal set of files.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

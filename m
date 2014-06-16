From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 14:38:49 +0100
Subject: [RESEND PATCH] ARM: kdump: Add vmcore_elf64_check_arch
In-Reply-To: <5395B4D0.6040302@huawei.com>
References: <1399124686-63299-1-git-send-email-sdu.liu@huawei.com>
 <20140506121558.GB30234@arm.com> <5395B4D0.6040302@huawei.com>
Message-ID: <20140616133849.GG16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 09, 2014 at 02:21:20PM +0100, Liu hua wrote:
> ? 2014/5/6 20:15, Will Deacon ??:
> > On Sat, May 03, 2014 at 02:44:46PM +0100, Liu Hua wrote:
> Sorry to reply you so late. These days I am working on kdump feature for LPAE enabled
> kernel. And now I think this patch is not good.
> 
> > This function looks identical to elf_check_arch. Why do we need to duplicate
> > that code? You could use some pre-processor magic to make the core part of
> > the functions agnostic to header type.
> 
> At the begging I think I should add elf_check_arch_64 just as elf_check_arch to
> do complicated check.
> 
> But for ARM32, elf_check_arch_64 would not be used except for kdump. No programs
> with elf64 header can be loaded into 32bit ARM kernel. So I think I can just check
> the "e_machine", just as what other platform does. I think other checks is useless
> for kdump.
> 
> > In fact, if elf_check_arch could handle both header types then the generic
> > definition of vmcore_elf64_check_arch in include/linux/crash_dump.h would
> > work out of the box.
> 
> As I mentioned, I afraid this will make the code hard to understand.( Sorry
> for my former incorrect patch).
> 
> How about this patch?
> 
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index f4b46d3..9424542 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -97,7 +97,7 @@ struct elf32_hdr;
>  extern int elf_check_arch(const struct elf32_hdr *);
>  #define elf_check_arch elf_check_arch
> 
> -#define vmcore_elf64_check_arch(x) (0)
> +#define vmcore_elf64_check_arch(x) ((x)->e_machine == EM_ARM)

Is there no way we can get away with using the generic version here? What
goes wrong if you let vmcore_elf64_check_arch fallback to elf_check_arch?

Will

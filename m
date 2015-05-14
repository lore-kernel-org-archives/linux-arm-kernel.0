From: labbott@redhat.com (Laura Abbott)
Date: Thu, 14 May 2015 14:23:21 -0700
Subject: [PATCH] ARM: module: Add ".ref.text" to arm unwind tables
In-Reply-To: <1431530457-19909-1-git-send-email-vigneshr@codeaurora.org>
References: <1431530457-19909-1-git-send-email-vigneshr@codeaurora.org>
Message-ID: <55551249.6020904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 08:20 AM, Vignesh Radhakrishnan wrote:
> Functions inside kernel modules that use __ref
> will end up being placed in .ARM.exidx.ref.text
> section by gcc.
>
> Currently we don't consider adding these functions
> to arm unwind tables.
>
> Hence, if we turn slub debug on by default we end up
> with the messages of this sort:
>
> 	unwind: Index not found bf0011e0
>
> This is because slub debug saves stack trace of
> allocation's and free's. Therefore, we end up seeing
> a flood of these messages in dmesg since its not
> able to locate these functions.
>
> Fix this by adding .ref.text section to arm unwind tables.
>

With this patch, I go from

  ------------[ cut here ]------------
WARNING: CPU: 0 PID: 63 at drivers/misc/test.c:12 that_function+0x10/0x2c [test]()
Modules linked in: test(P+)
CPU: 0 PID: 63 Comm: insmod Tainted: P                4.1.0-rc2+ #28
Hardware name: ARM-Versatile PB
[<c001a590>] (unwind_backtrace) from [<c0017b84>] (show_stack+0x10/0x14)
[<c0017b84>] (show_stack) from [<c0022370>] (warn_slowpath_common+0x78/0xb0)
[<c0022370>] (warn_slowpath_common) from [<c0022444>] (warn_slowpath_null+0x1c/0x24)
[<c0022444>] (warn_slowpath_null) from [<bf000048>] (that_function+0x10/0x2c [test])
unwind: Index not found bf000048
---[ end trace 3e24f8edd90f3b27 ]---

to

------------[ cut here ]------------
WARNING: CPU: 0 PID: 63 at drivers/misc/test.c:12 that_function+0x10/0x2c [test]()
Modules linked in: test(P+)
CPU: 0 PID: 63 Comm: insmod Tainted: P                4.1.0-rc2+ #30
Hardware name: ARM-Versatile PB
[<c001a5d0>] (unwind_backtrace) from [<c0017b84>] (show_stack+0x10/0x14)
[<c0017b84>] (show_stack) from [<c0022770>] (warn_slowpath_common+0x78/0xb0)
[<c0022770>] (warn_slowpath_common) from [<c0022844>] (warn_slowpath_null+0x1c/0x24)
[<c0022844>] (warn_slowpath_null) from [<bf000048>] (that_function+0x10/0x2c [test])
[<bf000048>] (that_function [test]) from [<bf002010>] (awesome_module+0x10/0x1c [test])
[<bf002010>] (awesome_module [test]) from [<c0009710>] (do_one_initcall+0x80/0x1dc)
[<c0009710>] (do_one_initcall) from [<c02d14e0>] (do_init_module+0x58/0x1a8)
[<c02d14e0>] (do_init_module) from [<c0063940>] (load_module+0x170c/0x1c38)
[<c0063940>] (load_module) from [<c0063f38>] (SyS_init_module+0xcc/0x124)
[<c0063f38>] (SyS_init_module) from [<c0014900>] (ret_fast_syscall+0x0/0x30)
---[ end trace 554c9ff461eb2505 ]---

Tested-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Vignesh Radhakrishnan <vigneshr@codeaurora.org>
> ---
>   arch/arm/include/asm/module.h | 1 +
>   arch/arm/kernel/module.c      | 4 ++++
>   2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index ed690c4..17640c9 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -14,6 +14,7 @@ enum {
>   	ARM_SEC_DEVEXIT,
>   	ARM_SEC_HOT,
>   	ARM_SEC_UNLIKELY,
> +	ARM_SEC_REF,
>   	ARM_SEC_MAX,
>   };
>
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 2e11961..846b888 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -308,6 +308,8 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>   			maps[ARM_SEC_UNLIKELY].unw_sec = s;
>   		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
>   			maps[ARM_SEC_HOT].unw_sec = s;
> +		else if (strcmp(".ARM.exidx.ref.text", secname) == 0)
> +			maps[ARM_SEC_REF].unw_sec = s;
>   		else if (strcmp(".init.text", secname) == 0)
>   			maps[ARM_SEC_INIT].txt_sec = s;
>   		else if (strcmp(".text", secname) == 0)
> @@ -318,6 +320,8 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>   			maps[ARM_SEC_UNLIKELY].txt_sec = s;
>   		else if (strcmp(".text.hot", secname) == 0)
>   			maps[ARM_SEC_HOT].txt_sec = s;
> +		else if (strcmp(".ref.text", secname) == 0)
> +			maps[ARM_SEC_REF].txt_sec = s;
>   	}
>
>   	for (i = 0; i < ARM_SEC_MAX; i++)
>

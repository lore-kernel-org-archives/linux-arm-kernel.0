From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 07 Aug 2014 13:43:55 -0700
Subject: [PATCH v2 0/8] arm: support CONFIG_RODATA
In-Reply-To: <1407423713-4160-1-git-send-email-keescook@chromium.org>
References: <1407423713-4160-1-git-send-email-keescook@chromium.org>
Message-ID: <53E3E50B.7050105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/2014 8:01 AM, Kees Cook wrote:
> This is a series of patches to support CONFIG_RODATA on ARM, so that
> the kernel text is RO, and non-text sections default to NX. To support
> on-the-fly kernel text patching (via ftrace, kprobes, etc), fixmap
> support has been finalized based on several versions of various patches
> that are floating around on the mailing list. This series attempts to
> include the least intrusive version, so that others can build on it for
> future fixmap work.
> 
> The series has been heavily tested, and appears to be working correctly:
> 
> With CONFIG_ARM_PTDUMP, expected page table permissions are seen in
> /sys/kernel/debug/kernel_page_tables.
> 
> Using CONFIG_LKDTM, the kernel now correctly detects bad accesses for
> for the following lkdtm tests via /sys/kernel/debug/provoke-crash/DIRECT:
>         EXEC_DATA
>         WRITE_RO
>         WRITE_KERN
> 
> ftrace works:
>         CONFIG_FTRACE_STARTUP_TEST passes
>         Enabling tracing works:
>                 echo function > /sys/kernel/debug/tracing/current_tracer
> 
> kprobes works:
>         CONFIG_ARM_KPROBES_TEST passes
> 
> kexec works:
>         kexec will load and start a new kernel
> 
> Thanks to everyone who has been testing this series and working on its
> various pieces!
> 
> -Kees
> 
> v2:
> - fix typo in kexec merge (buildbot)
> - flip index order for highmem pte access (lauraa)
> - added kgdb updates (dianders)
> 

At least twice I managed to boot a build with CONFIG_DEBUG_RODATA where
both  cat /sys/kernel/debug/kernel_page_table and JTAG were showing no
sections marked as read only. I haven't been able to reproduce it though
so I'm tempted to account for it as incorrect testing on my part. I'll
play around with it some more but if you haven't heard anything more
you can add

Tested-by: Laura Abbott <lauraa@codeaurora.org>

For boot up test, kernel_page_table/JTAG page table verification and
simple kprobes test. 

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 13 Aug 2014 13:38:24 -0400 (EDT)
Subject: [PATCH v4 0/8] arm: support CONFIG_RODATA
In-Reply-To: <1407949593-16121-1-git-send-email-keescook@chromium.org>
References: <1407949593-16121-1-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LFD.2.11.1408131337360.1133@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Aug 2014, Kees Cook wrote:

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
> Built with and without CONFIG_HIGHMEM, CONFIG_HIGHMEM_DEBUG, and
> CONFIG_NR_CPUS=32.
> 
> Thanks to everyone who has been testing this series and working on its
> various pieces!

For the whole series:

Acked-by: Nicolas Pitre <nico@linaro.org>



> 
> -Kees
> 
> v4:
> - expanded fixmap to 3MB to support 32 CPUs (robh)
> - corrected pmd-finding via vaddr instead of FIXMAP_START (robh)
> - switched structure size test to BUILD_BUG_ON (sboyd)
> - added locking annotations to keep sparse happy (sboyd)
> - adding missing "static" declarations noticed by sparse
> - reorganized fixmap portion of patches
> 
> v3:
> - more cleanups in switch to generic fixmap (lauraa, robh)
> - fixed kexec merge hunk glitch (will.deacon)
> - added tested-by tags where appropriate from v2 testing
> 
> v2:
> - fix typo in kexec merge (buildbot)
> - flip index order for highmem pte access (lauraa)
> - added kgdb updates (dianders)
> 
> 

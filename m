From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 30 May 2016 22:53:21 +0100
Subject: [PATCH v2] arm64:efi fix the format of debug message from efi
In-Reply-To: <1464341244-14152-1-git-send-email-dennis.chen@arm.com>
References: <1464341244-14152-1-git-send-email-dennis.chen@arm.com>
Message-ID: <20160530215321.GI2984@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 May, at 05:27:24PM, Dennis Chen wrote:
> When enable debug of efi and memblock with 'efi=debug memblock=debug' appended
> to the kernel command line, the debug message output for earyly_con looks like:
> 
> [    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
> [    0.000000] *
> ...
> 
> This patch is trying to fix the above output messed up by memblock_add(), so we can get below debug mesg looks
> more formally after applied:
> 
> [    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> [    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
> ...
> 
> Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: linux-efi at vger.kernel.org
> 
> Since v1[1]:
>  According to the suggestion from Mark Rutland, v2 folds the pr_cont("\n") into pr_info.
>  [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/431233.html
> ---
>  drivers/firmware/efi/arm-init.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Thanks, applied.

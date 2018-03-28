From: sstabellini@kernel.org (Stefano Stabellini)
Date: Tue, 27 Mar 2018 17:23:47 -0700 (PDT)
Subject: Fix compile failures due to arm64 includes in stable kernels
In-Reply-To: <20180325073255.GA2923@hotdamn.lan>
References: <20180325073255.GA2923@hotdamn.lan>
Message-ID: <alpine.DEB.2.10.1803271714560.12360@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Mar 2018, Sebastian Kemper wrote:
> Hello all,
> 
> Some older stable kernels provide some arm64 headers like opcodes.h,
> that include their non-64bit equivalents. For example:
> 
> arch/arm64/include/asm/opcodes.h
> 
> tries to include
> 
> <../../arm/include/asm/opcodes.h>
> 
> It's obvious that there is one hierarchy level missing. This causes
> build failures:
> 
>     CC [M]  /build/lede-snapshots/aarch64_cortex-a53/build/sdk/build_dir/target-aarch64_cortex-a53_musl/linux-brcm2708_bcm2710/dahdi-linux-2.11.1-20180111/drivers/dahdi/dahdi-base.o
>   In file included from ./arch/arm64/include/asm/sysreg.h:25:0,
>                    from ./arch/arm64/include/asm/cputype.h:94,
>                    from ./arch/arm64/include/asm/cachetype.h:19,
>                    from ./arch/arm64/include/asm/cache.h:19,
>                    from ./include/linux/cache.h:5,
>                    from ./include/linux/printk.h:8,
>                    from ./include/linux/kernel.h:13,
>                    from /build/lede-snapshots/aarch64_cortex-a53/build/sdk/build_dir/target-aarch64_cortex-a53_musl/linux-brcm2708_bcm2710/dahdi-linux-2.11.1-20180111/drivers/dahdi/dahdi-base.c:38:
>   ./arch/arm64/include/asm/opcodes.h:5:10: fatal error: ../../arm/include/asm/opcodes.h: No such file or directory
>    #include <../../arm/include/asm/opcodes.h>
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
> 
> Some example packages that fail to build are dahdi-linux and
> cryptodev-linux.
> 
> linux-3.16.56:
>   - does not have opcodes.h, but the xen headers
> 
>       hypercall.h
>       interface.h
>       hypervisor.h
>       page.h
>       
>     have the wrong include lines.
>     
> linux-4.1.50:
>   - affected (needs a small change in the patch for opcodes.h due to slightly different layout)
>   
> linux-4.4.123:
>   - affected
>   
> linux-4.9.89:
>   - affected
> 
> The attached patch fixes the includes.
> 
> I understand that to get a patch accepted into the stable series one
> needs to provide a commit to master. But in this case that doesn't seem
> possible as these headers do not exist anymore in newer kernels.
> 
> What do you think? Does the above make sense to you to backport to the
> stable kernels?

It is not actually a bug: the path was correct given the way the
Makefiles were written -- if you build a regular arm64 kernel with the
default config and CONFIG_XEN enabled, it will work fine.

I am guessing you see these issues with out-of-tree modules, right?

Fortunately, on newer kernels the whole thing has been reworked, and
should solve the problem for you. The commit you are looking for is
2fbadc3002c5f172d20aa2e7e48920c5f14ed11f:

commit 7465c84a9380779235af42146dae6798b89b1d12
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri Dec 2 14:19:35 2016 +0000

    arm/arm64: xen: Move shared architecture headers to include/xen/arm
    
    ARM and arm64 Xen ports share a number of headers, leading to
    packaging issues when these headers needs to be exported, as it
    breaks the reasonable requirement that an architecture port
    has self-contained headers.
    
    Fix the issue by moving the 5 header files to include/xen/arm,
    and keep local placeholders to include the relevant files.
    
    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
    Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I am CC'ing the original author.

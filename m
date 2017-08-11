From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Aug 2017 10:22:14 +0100
Subject: New assembler warnings with binutils 2.29
In-Reply-To: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
References: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
Message-ID: <20170811092213.mdmzqtm2lp6ltlxt@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 01:13:22PM -0700, Laura Abbott wrote:
> Fedora rawhide recently upgraded to binutils 2.29 and this seems
> to produce new warnings:
> 
> ./arch/arm64/include/asm/assembler.h: Assembler messages:
> ./arch/arm64/include/asm/assembler.h:125: Warning: ignoring attempt to redefine built-in register 'lr'
> 
> This is
> 
> /*
>  * Register aliases.
>  */
> lr      .req    x30             // link register

Strange, does gas now think 'lr' is a general purpose register (aliased
to x30)? It never was and IIRC the toolchain people many years ago
refused to add it, hence the alias above in the kernel. I wonder if they
added 'fp' as well...

We could remove the alias and replace all 'lr' instances with 'x30'
throughout the kernel (no too many) or we add some #ifdef around the
above based on the binutils version.

-- 
Catalin

From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 18:21:57 +0100
Subject: [PATCH] arm64: make flatmem depend on !NUMA
In-Reply-To: <20180710151639.2184213-1-arnd@arndb.de>
References: <20180710151639.2184213-1-arnd@arndb.de>
Message-ID: <20180710172157.GB10177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 05:16:27PM +0200, Arnd Bergmann wrote:
> Building without NUMA but with FLATMEM results in a link error
> because mem_map[] is not available:
> 
> aarch64-linux-ld -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a --end-group
> init/do_mounts.o: In function `mount_block_root':
> do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
> arch/arm64/kernel/vdso.o: In function `vdso_init':
> vdso.c:(.init.text+0xb4): undefined reference to `mem_map'
> 
> This uses the same trick as the other architectures, making flatmem
> depend on !NUMA to avoid the broken configuration.
> 
> Fixes: e7d4bac428ed ("arm64: add ARM64-specific support for flatmem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Arnd. I've picked this one up.

Will

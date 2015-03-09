From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 19:09:47 +0000
Subject: [PATCH roundup 2/4] ARM: KVM: avoid "HYP init code too big" error
In-Reply-To: <1425652482-31411-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1425652482-31411-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425652482-31411-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150309190947.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 03:34:40PM +0100, Ard Biesheuvel wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building large kernels, the linker will emit lots of veneers
> into the .hyp.idmap.text section, which causes it to grow beyond
> one page, and that triggers the build error.
> 
> This moves the section into .rodata instead, which avoids the
> veneers and is safe because the code is not executed directly
> but remapped by the hypervisor into its own executable address
> space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ardb: move the ALIGN() to .rodata as well, update log s/copied/remapped/]
> Tested-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kernel/vmlinux.lds.S | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b31aa73e8076..2787eb8d3616 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -22,11 +22,15 @@
>  	ALIGN_FUNCTION();						\
>  	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
>  	*(.idmap.text)							\
> -	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> +	VMLINUX_SYMBOL(__idmap_text_end) = .;
> +
> +#define IDMAP_RODATA							\
> +	.rodata : {							\

We already have a .rodata section defined by RO_DATA().  Quite how this
interacts with the existing .rodata section, I don't know, but it
probably won't be right.  Have you checked what effect this has?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

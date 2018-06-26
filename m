From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jun 2018 10:24:54 +0100
Subject: [RFC v2 1/4] arm: Store address of thread_info in sp^
In-Reply-To: <20180618153053.186224-2-zsm@chromium.org>
References: <20180618153053.186224-1-zsm@chromium.org>
 <20180618153053.186224-2-zsm@chromium.org>
Message-ID: <20180626092454.GF17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 08:30:50AM -0700, Zubin Mithra wrote:
> There is a need to store thread_info in a register so that subsequent
> patches can move thread_info into task_struct. This would also
> facilitate having separate IRQ stacks.
> 
> Banked register sp is an unused scratch register in EL1 context. We can
> utilize this register for stashing the current thread_info.
> 
> The macro save_ti_sp_usr is used to stash the address of thread_info
> into sp^. The macro get_thread_info is modified to retrieve thread_info
> from sp^. Additionally, upon context switch, sp^ is set to current's
> thread_info by using set_sp_usr.
> 
> Signed-off-by: Zubin Mithra <zsm@chromium.org>
> ---
>  arch/arm/include/asm/assembler.h   | 27 ++++++++++++++++++++++-----
>  arch/arm/include/asm/switch_to.h   | 11 +++++++++++
>  arch/arm/include/asm/thread_info.h | 14 ++++++++++++--
>  arch/arm/kernel/entry-armv.S       |  5 ++++-
>  arch/arm/kernel/entry-common.S     |  2 ++
>  arch/arm/kernel/head-common.S      |  2 ++
>  arch/arm/kernel/head.S             |  1 +
>  7 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 0cd4dccbae78..be18a364f590 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -205,11 +205,28 @@
>  /*
>   * Get current thread_info.
>   */
> -	.macro	get_thread_info, rd
> - ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
> - THUMB(	mov	\rd, sp			)
> - THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
> -	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
> +	.macro get_thread_info, rd
> +	sub sp, #4
> +	stm sp, {sp}^

What isn't mentioned in the ARM ARM is that you need at least one
instruction here that does not access any of the banked registers.
Ditto for ldm rn, {...}^ form.

Have you done performance analysis of this patch?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

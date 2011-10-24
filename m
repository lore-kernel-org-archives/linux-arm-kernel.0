From: tim.bird@am.sony.com (Tim Bird)
Date: Mon, 24 Oct 2011 07:33:15 -0700
Subject: [PATCH] Shrink thread_info a bit
In-Reply-To: <20111024124818.GA17693@n2100.arm.linux.org.uk>
References: <20111024124818.GA17693@n2100.arm.linux.org.uk>
Message-ID: <4EA5772B.1060205@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2011 5:48 AM, Russell King - ARM Linux wrote:
> Thread info comes in on Versatile Express at 752 bytes in size, which
> is quite large.  Of this, the crunch state is 184 bytes, which is only
> used on Cirrus Logic devices.
>
> It is wasteful to have this in every kernel when Cirrus Logic CPUs
> are not that widely used.  So make this conditional.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/include/asm/thread_info.h |    2 ++
>   arch/arm/kernel/asm-offsets.c      |    2 ++
>   2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 7b5cc8d..a030be7 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -59,7 +59,9 @@ struct thread_info {
>   	__u32			syscall;	/* syscall number */
>   	__u8			used_cp[16];	/* thread used copro */
>   	unsigned long		tp_value;
> +#ifdef CONFIG_CRUNCH
>   	struct crunch_state	crunchstate;
> +#endif
>   	union fp_state		fpstate __attribute__((aligned(8)));
>   	union vfp_state		vfpstate;
>   #ifdef CONFIG_ARM_THUMBEE
>
>
Since the asm-offsets.h code already has the offset definitions under
#ifdef CONFIG_CRUNCH, this qualifies as a code consistency cleanup,
as well as a memory savings.

I looked at this, and can find no code outside of #ifdef CONFIG_CRUNCH
that references this - so FWIW
Reviewed-by Tim Bird <tim.bird@am.sony.com>

  -- Tim

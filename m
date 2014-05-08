From: dianders@google.com (Doug Anderson)
Date: Thu, 8 May 2014 09:57:03 -0700
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
In-Reply-To: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
References: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
Message-ID: <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arjun,

Thanks for sending this.

On Wed, May 7, 2014 at 10:55 PM, Arjun.K.V <arjun.kv@samsung.com> wrote:
> From: "Arjun.K.V" <arjun.kv@samsung.com>
>
> Three processor exclusive access livelock.
> In a system with three or more coherent masters that all use
> the ldrex/strex synchronization primitives to access a semaphore
> in coherent cacheable memory, there is a possibility of a
> livelock condition where two masters continuously attempt
> and fail to get the lock while the third master
> continuously reads the lock.
>
> Workaround is to set the "Snoop-delayed exclusive handling"
> bit in the Auxiliary Control Register, ACTLR[31] to 1.
> This hardware is installed in each processor to detect
> that the load/store exclusive livelock scenario may be occurring
> and delay snoops for a period of time to allow the load
> exclusive/store exclusive loop to complete and make
> forward progress.
>
> Change-Id: Idcf066e25ea6571a0f5da6f3a770318c1a9d6fff
> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
> ---
>  arch/arm/Kconfig      |   13 +++++++++++++
>  arch/arm/mm/proc-v7.S |   43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db3c541..80b8562 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1464,6 +1464,19 @@ source "drivers/pci/pcie/Kconfig"
>
>  source "drivers/pcmcia/Kconfig"
>
> +config ARM_ERRATA_763126
> +       bool "ARM errata: Three processor exclusive access livelock"
> +       depends on CPU_V7 && SMP
> +       help
> +         This enables the workaround got ARM Erratum 763126.
> +         In a system with three or more coherent masters that all use the
> +         ldrex/strex synchronization primitives to access a semaphore in
> +         coherent cacheable memory, there is a possibility of a livelock
> +         condition where two masters continuously attempt and fail to get
> +         the lock while the third master continuously reads the lock.
> +         Workaround is to set the "Snoop-delayed exclusive handling" bit
> +         in the Auxiliary Control Register, ACTLR[31] to 1.
> +
>  endmenu
>
>  menu "Kernel Features"
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 195731d..e6d22c7 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -136,6 +136,29 @@ ENTRY(cpu_v7_do_resume)
>         mcr     p15, 0, r7, c2, c0, 1   @ TTB 1
>  #endif
>         mcr     p15, 0, r11, c2, c0, 2  @ TTB control register
> +
> +#ifdef CONFIG_ARM_ERRATA_763126
> +       mrc     p15, 0, r0, c0, c0, 0   @ Check if we are A15s
> +       ubfx    r1, r0, #4, #12
> +       ldr     r2, =0x00000c0f
> +       teq     r1, r2
> +       bne     6f
> +       and     r1, r0, #0x00f00000
> +       and     r2, r0, #0x0000000f
> +       orr     r2, r2, r1, lsr #20-4
> +       cmp     r2, #0x20               @ Is the revision < r2p0

As I mentioned locally, I think this affects all A15s equally.
Specifically, I see that:

* this affects r0p4
* this affects r2p0, r2p1, r2p2, r2p3, r2p4
* this affects r3p0, r3p1, r3p2, r3p3
* this affects r4p0

Just get rid of the revision test and assume that on all A15s (w/ 3 or
more processors) you need this.

-Doug

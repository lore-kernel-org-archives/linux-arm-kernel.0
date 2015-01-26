From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 19:16:20 +0000
Subject: [PATCH 5/8] arm64/kexec: Add core kexec support
In-Reply-To: <a5c232448c1d8fa1da73a9005fa9f3927c635578.1421449714.git.geoff@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <a5c232448c1d8fa1da73a9005fa9f3927c635578.1421449714.git.geoff@infradead.org>
Message-ID: <20150126191620.GP23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/Kconfig                  |   9 ++
>  arch/arm64/include/asm/kexec.h      |  47 +++++++++++
>  arch/arm64/kernel/Makefile          |   1 +
>  arch/arm64/kernel/machine_kexec.c   | 155 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/relocate_kernel.S | 160 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kexec.h          |   1 +
>  6 files changed, 373 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kexec.h
>  create mode 100644 arch/arm64/kernel/machine_kexec.c
>  create mode 100644 arch/arm64/kernel/relocate_kernel.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1f9a20..d9eb9cd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -474,6 +474,15 @@ config SECCOMP
>           and the task is only allowed to execute a few safe syscalls
>           defined by each seccomp mode.
> 
> +config KEXEC
> +       depends on (!SMP || PM_SLEEP_SMP)
> +       bool "kexec system call"
> +       ---help---
> +         kexec is a system call that implements the ability to shutdown your
> +         current kernel, and to start another kernel.  It is like a reboot
> +         but it is independent of the system firmware.   And like a reboot
> +         you can start any kernel with it, not just Linux.
> +

[...]

> +/**
> + * kexec_is_dtb - Helper routine to check the device tree header signature.
> + */
> +static bool kexec_is_dtb(const void *dtb)
> +{
> +       __be32 magic;
> +
> +       return get_user(magic, (__be32 *)dtb) ? false :
> +               (be32_to_cpu(magic) == OF_DT_HEADER);
> +}
> +
> +/**
> + * kexec_find_dtb_seg - Helper routine to find the dtb segment.
> + */
> +static const struct kexec_segment *kexec_find_dtb_seg(
> +       const struct kimage *image)
> +{
> +       int i;
> +
> +       for (i = 0; i < image->nr_segments; i++) {
> +               if (kexec_is_dtb(image->segment[i].buf))
> +                       return &image->segment[i];
> +       }
> +
> +       return NULL;
> +}

As mentioned before, _please_ move the dtb handling to the
userspace-provided purgatory. It would be far better to get userspace to
handle setting up the dtb pointer explicitly. That avoids fragility
w.r.t. policy here as userspace will get exactly what it asked for,
nothing more, nothing less.

The fact that this is done on 32-bit arm does not mean that we must do
it here.

[...]

> +       /* Start new image. */
> +       ldr     x4, arm64_kexec_kimage_start
> +       ldr     x0, arm64_kexec_dtb_addr
> +       mov     x1, xzr
> +       mov     x2, xzr
> +       mov     x3, xzr
> +       br      x4

Likewise, this should be part of the userspace-provided purgatory code.
If we're staying true to "like a reboot you can start any kernel with
it, not just Linux", we shouldn't embed the Linux boot protocol here.

Mark.

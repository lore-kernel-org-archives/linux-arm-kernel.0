From: james.morse@arm.com (James Morse)
Date: Tue, 1 May 2018 18:46:06 +0100
Subject: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
In-Reply-To: <20180425062629.29404-4-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
Message-ID: <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> On arm64, purugatory would do almosty nothing. So just invoke secondary
> kernel directy by jumping into its entry code.

(Nits: purgatory, almost, directly)


> While, in this case, cpu_soft_restart() must be called with dtb address
> in the fifth argument, the behavior still stays compatible with kexec_load
> case as long as the argument is null.


> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index 8021b46c9743..391df91328ac 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -24,9 +24,9 @@
>   *
>   * @el2_switch: Flag to indicate a swich to EL2 is needed.

(Nit: switch)

>   * @entry: Location to jump to for soft reset.
> - * arg0: First argument passed to @entry.
> - * arg1: Second argument passed to @entry.
> - * arg2: Third argument passed to @entry.
> + * arg0: First argument passed to @entry. (relocation list)
> + * arg1: Second argument passed to @entry.(physcal kernel entry)

(Nit: physical)


> + * arg2: Third argument passed to @entry. (physical dtb address)
>   *
>   * Put the CPU into the same state as it would be if it had been reset, and
>   * branch to what would be the reset vector. It must be executed with the
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f76ea92dff91..f7dbba00be10 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
>  	 * uses physical addressing to relocate the new image to its final
>  	 * position and transfers control to the image entry point when the
>  	 * relocation is complete.
> +	 * In case of kexec_file_load syscall, we directly start the kernel,
> +	 * skipping purgatory.

We're not really skipping purgatory, purgatory doesn't exist! For regular kexec
the image/payload we run is up to kexec-tools. For kexec_file_load its a
kernel-image. Purgatory is a kexec-tools-ism.


>  	cpu_soft_restart(kimage != kexec_crash_image,
> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> +		reboot_code_buffer_phys, kimage->head, kimage->start,
> +#ifdef CONFIG_KEXEC_FILE
> +				kimage->purgatory_info.purgatory_buf ?
> +						0 : kimage->arch.dtb_mem);
> +#else
> +				0);
> +#endif

Where does kimage->arch.dtb_mem come from? This patch won't build until patch 8
adds the config option, which is going to make bisecting any kexec side-effects
tricky.

purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
kexec_load_purgatory(), which we don't use. How does this get a value?

Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
regular kexec (as we can't know where the dtb is)? (image_arg may then be a
better name).


Thanks,

James

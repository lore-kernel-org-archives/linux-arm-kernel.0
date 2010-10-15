From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 15 Oct 2010 00:15:44 -0400 (EDT)
Subject: iwmmxt signal frame handling
In-Reply-To: <201010141609.10889.arnd@arndb.de>
References: <201010141609.10889.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1010142357500.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Oct 2010, Arnd Bergmann wrote:

> Peter Maydell noticed during code review that the signal frame might
> be written incorrectly for kernels with CONFIG_IWMMXT set running
> processes without TIF_USING_IWMMXT, where the magic/size values
> for the iwmmxt section of the frame are left uninitialized.
> Instead of skipping this part of the frame, we should instead
> write a valid header with zero data.
> 
> This patch is compile-tested only since the problem was only
> found in review and neither Peter nor myself have access to
> IWMMXT capable hardware to test this on.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>



> 
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -154,7 +154,10 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe *frame)
>  	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
>  	kframe->magic = IWMMXT_MAGIC;
>  	kframe->size = IWMMXT_STORAGE_SIZE;
> -	iwmmxt_task_copy(current_thread_info(), &kframe->storage);
> +	if (test_thread_flag(TIF_USING_IWMMXT))
> +		iwmmxt_task_copy(current_thread_info(), &kframe->storage);
> +	else
> +		memset(&kframe->storage, 0, sizeof(kframe->storage));
>  	return __copy_to_user(frame, kframe, sizeof(*frame));
>  }
>  
> @@ -429,7 +432,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
>  		err |= preserve_crunch_context(&aux->crunch);
>  #endif
>  #ifdef CONFIG_IWMMXT
> -	if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
> +	if (err == 0)
>  		err |= preserve_iwmmxt_context(&aux->iwmmxt);
>  #endif
>  #ifdef CONFIG_VFP
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

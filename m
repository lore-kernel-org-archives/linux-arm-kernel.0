From: dirk.behme@gmail.com (Dirk Behme)
Date: Thu, 20 Dec 2012 08:15:47 +0100
Subject: [PATCH] missing ->mmap_sem around find_vma() in swp_emulate.c
In-Reply-To: <20121216002557.GY4939@ZenIV.linux.org.uk>
References: <20121216002557.GY4939@ZenIV.linux.org.uk>
Message-ID: <50D2BB23.5070105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.12.2012 01:25, schrieb Al Viro:
> find_vma() is *not* safe when somebody else is removing vmas.  Not just
> the return value might get bogus just as you are getting it (this instance
> doesn't try to dereference the resulting vma), the search itself can get
> buggered in rather spectacular ways.  IOW, ->mmap_sem really, really is
> not optional here.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index df74518..ab1017b 100644
> --- a/arch/arm/kernel/swp_emulate.c
> +++ b/arch/arm/kernel/swp_emulate.c
> @@ -109,10 +109,12 @@ static void set_segfault(struct pt_regs *regs, unsigned long addr)
>   {
>   	siginfo_t info;
>
> +	down_read(&current->mm->mmap_sem);
>   	if (find_vma(current->mm, addr) == NULL)
>   		info.si_code = SEGV_MAPERR;
>   	else
>   		info.si_code = SEGV_ACCERR;
> +	up_read(&current->mm->mmap_sem);
>
>   	info.si_signo = SIGSEGV;
>   	info.si_errno = 0;

Any comment on this?

Thanks

Dirk

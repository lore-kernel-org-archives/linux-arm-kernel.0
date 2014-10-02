From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Oct 2014 15:13:29 +0100
Subject: [PATCH 19/24] ptrace: Allow compat to use the native siginfo
In-Reply-To: <1409779158-30963-20-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-20-git-send-email-apinski@cavium.com>
Message-ID: <20141002141328.GE32147@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:13PM +0100, Andrew Pinski wrote:
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 54e7522..40ae023 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -657,7 +657,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>  			break;
>  
>  #ifdef CONFIG_COMPAT
> -		if (unlikely(is_compat_task())) {
> +		if (unlikely(is_compat_task() && !COMPAT_USE_NATIVE_SIGINFO)) {
>  			compat_siginfo_t __user *uinfo = compat_ptr(data);
>  
>  			if (copy_siginfo_to_user32(uinfo, &info) ||
> @@ -1126,16 +1126,27 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
>  
>  	case PTRACE_GETSIGINFO:
>  		ret = ptrace_getsiginfo(child, &siginfo);
> -		if (!ret)
> -			ret = copy_siginfo_to_user32(
> -				(struct compat_siginfo __user *) datap,
> -				&siginfo);
> +		if (!ret) {
> +			if (COMPAT_USE_NATIVE_SIGINFO)
> +				ret = copy_siginfo_to_user(
> +					(struct siginfo __user *) datap,
> +					&siginfo);
> +			else
> +				ret = copy_siginfo_to_user32(
> +					(struct compat_siginfo __user *) datap,
> +					&siginfo);
> +		}

I haven't read the subsequent patch yet but couldn't you call
ptrace_request directly from the arm64 code for ILP32 tasks instead of
compat_ptrace_request()? Is the ILP32 ptrace support the same with the
LP64 one?

-- 
Catalin

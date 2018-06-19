From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:45:41 +0100
Subject: [PATCHv3 13/19] kernel: add ksys_personality()
In-Reply-To: <20180618120310.39527-14-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-14-mark.rutland@arm.com>
Message-ID: <20180619154541.7uugqiquxzkcpfwj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:04PM +0100, Mark Rutland wrote:
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 73810808cdf2..14312d334345 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -80,6 +80,7 @@ union bpf_attr;
>  #include <linux/unistd.h>
>  #include <linux/quota.h>
>  #include <linux/key.h>
> +#include <linux/personality.h>
>  #include <trace/syscall.h>
>  
>  #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
> @@ -1277,4 +1278,14 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
>  	return do_sys_truncate(pathname, length);
>  }
>  
> +static inline unsigned int ksys_personality(unsigned int personality)
> +{
> +	unsigned int old = current->personality;
> +
> +	if (personality != 0xffffffff)
> +		set_personality(personality);
> +
> +	return old;
> +}
> +
>  #endif

It looks like this is identical to sys_personality() in
kernel/exec_domain.c. Should you call ksys_personality() from there
directly (a few lines saved)?

-- 
Catalin

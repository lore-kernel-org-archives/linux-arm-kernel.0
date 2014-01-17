From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 16:46:11 +0000
Subject: [PATCH v2 4/6] arm64: audit: Add 32-bit (compat) syscall support
In-Reply-To: <1389946399-4525-5-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-5-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140117164610.GQ16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Fri, Jan 17, 2014 at 08:13:17AM +0000, AKASHI Takahiro wrote:
> Generic audit code also support compat system calls now.
> This patch adds a small piece of architecture dependent code.

[...]

>  static inline int syscall_get_nr(struct task_struct *task,
> @@ -109,6 +110,15 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  static inline int syscall_get_arch(struct task_struct *task,
>  				   struct pt_regs *regs)
>  {
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_thread(task_thread_info(task)))

You can call is_compat_thread even when !CONFIG_COMPAT, so you don't need
that #ifdef.

> +#ifdef __AARCH64EB__
> +		return AUDIT_ARCH_ARMEB; /* only BE on BE */

Well, actually, we only support userspace to be the same endianness as the
kernel, so you that comment is slightly misleading. You could probably avoid
these repeated ifdefs by defining things like ARM64_AUDIT_ARCH and
ARM64_COMPAT_AUDIT_ARCH once depending on endianness.

Will

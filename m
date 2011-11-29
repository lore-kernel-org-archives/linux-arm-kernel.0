From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 17:46:04 +0000
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
Message-ID: <20111129174604.GL9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 11:28:15AM -0500, Steven Walter wrote:
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 2c04ed5..1f23923 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -403,6 +403,8 @@
>  #define __NR_sendmmsg			(__NR_SYSCALL_BASE+374)
>  #define __NR_setns			(__NR_SYSCALL_BASE+375)
>  
> +#define NR_syscalls (__NR_setns+1)

NAK.  This is a recipe for it being forgotten to be updated, and for it
to become unsynchronized with what is the _real_ number of syscalls,
which is what is in the assembly code.

You're also exporting it to userspace.  It has no business being in
userspace.

Lastly, it's wrong.  __NR_SYSCALL_BASE may be 0 or 0x90000 depending on
the ABI selected.  If it's 0x90000, will tracepoint stuff work or will it
explode because of a stupidly large table somewhere?

kernel/trace/trace_syscalls.c:      for (i = 0; i < NR_syscalls; i++) {

and

kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_enter_syscalls, NR_syscalls);
kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_exit_syscalls,NR_syscalls);

all point@this being very wrong.

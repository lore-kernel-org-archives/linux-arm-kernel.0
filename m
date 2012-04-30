From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Apr 2012 20:00:15 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <20120430100746.GA11080@mudshark.cambridge.arm.com>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
Message-ID: <20120430190015.GV24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 11:07:46AM +0100, Will Deacon wrote:
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 80abafb..bfcadc0 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -916,14 +916,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
>  {
>         unsigned long ip;
>  
> -       /*
> -        * Save IP.  IP is used to denote syscall entry/exit:
> -        *  IP = 0 -> entry, = 1 -> exit
> -        */
> -       ip = regs->ARM_ip;
> -       regs->ARM_ip = why;
> -
> -       if (!ip)
> +       if (why)

Umm yes, that original code is complete crap, because the old IP value
has no meaning what so ever.  The replacement looks much better here.

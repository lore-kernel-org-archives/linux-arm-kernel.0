From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Dec 2013 11:16:55 +0000
Subject: [PATCH] arm64 ptrace.c
In-Reply-To: <CAAXgzBO1TF=_EdkUieuyf1fbUYx9FVWExqGSi3CcUip7eboMAw@mail.gmail.com>
References: <CAAXgzBO1TF=_EdkUieuyf1fbUYx9FVWExqGSi3CcUip7eboMAw@mail.gmail.com>
Message-ID: <20131210111445.GF2338@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 06:12:24AM +0000, ??? wrote:
> Hi all,

Hello,

> In these dayes, I use gdb to debug my program on ARM foundation model and
> fast model with Linux 3.12.0-4.12 from ubuntu.  The gdb reports errors
> about setting hardware debug register when stepping pthread_create().
> After investigating gdb 7.6.1 source and Linux 3.12 source, I prepare a
> patch for arch/arm64/kernel/ptrace.c.  Although the patch could solve gdb
> error, I am not sure it has no side effects.  May somebody help to give
> suggestions?  Thank you.
> 
> Ref. to https://bugs.launchpad.net/gdb-linaro/+bug/1205391
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 6777a21..981f961 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -214,9 +214,16 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>  {
>   int err, len, type, disabled = !ctrl.enabled;
> 
> + /*
> + * Does not change type and len in disabled case because it will
> + * break the assertion that only 2 types (TYPE_DATA and TYPE_INST) in
> + * the event linked list in ./kernel/events/hw_breakpoint.c
> + */
>   if (disabled) {
> - len = 0;
> - type = HW_BREAKPOINT_EMPTY;
> + /*
> + * len = 0;
> + * type = HW_BREAKPOINT_EMPTY;
> + */
>   } else {
>   err = arch_bp_generic_fields(ctrl, &len, &type);
>   if (err)
> @@ -234,10 +241,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
>   default:
>   return -EINVAL;
>   }
> + attr->bp_len = len;
> + attr->bp_type = type;
>   }
> 
> - attr->bp_len = len;
> - attr->bp_type = type;
>   attr->disabled = disabled;
> 
>   return 0;

I don't understand what this achieves. Do you have a better description of
the problem and/or strace logs showing all the hw_breakpoint ptrace requests
issued by GDB up until the first failure please?

That should help to figure out what the problem is.

Cheers,

Will

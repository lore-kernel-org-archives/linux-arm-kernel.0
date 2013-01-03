From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 03 Jan 2013 08:36:05 -0500
Subject: [PATCH 2/2] arm: make return_address available for ARM_UNWIND
In-Reply-To: <CA+KhAHbmjD7zTw+wcw84Abg3V1dD=0Ea4kUpYdGENQf1UOWphw@mail.gmail.com>
References: <1357207949-3349-1-git-send-email-kpark3469@gmail.com>
 <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
 <20130103103815.GL2631@n2100.arm.linux.org.uk>
 <CA+KhAHbmjD7zTw+wcw84Abg3V1dD=0Ea4kUpYdGENQf1UOWphw@mail.gmail.com>
Message-ID: <1357220165.10284.30.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-03 at 20:36 +0900, Keun-O Park wrote:

>         
>         So what have you done about the issue referred in this
>         comment?  Or do you
>         believe that fixing warnings (even if they are explicit
>         #warning statements)
>         is far more important than code being functionally correct?
> 
> I admit that I missed to add notrace to unwind.c.
> Do you think there's more to add?

I think Russell wants a better change log. What was written sounds like
the fix was to remove a warning. It wasn't very clear to how the warning
is no longer relevant because of the new changes.

The old change log:

---
This fixes a warning saying:

    warning: #warning "TODO: return_address should use unwind tables"

And, this enables return_address using unwind information. If ARM_UNWIND is
selected, unwind_frame in unwind.c will be called in walk_stackframe.
---


Maybe you wanted to say something like:

---
Now that the return_address code can safely use unwind tables, fix up
the #ifdef statements to reflect this.
---

Or something similar, if that's what was done.

-- Steve


> 
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 00df012..52ff2d4 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -327,7 +327,7 @@ static int unwind_exec_insn(struct
> unwind_ctrl_block *ctrl)
>   * Unwind a single frame starting with *sp for the symbol at *pc. It
>   * updates the *pc and *sp with the new values.
>   */
> -int unwind_frame(struct stackframe *frame)
> +int notrace unwind_frame(struct stackframe *frame)
>  {
>         unsigned long high, low;
>         const struct unwind_idx *idx;
> 

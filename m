From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:30:11 +0100
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <CAKv+Gu8Nji0Jspk2cMCwVGKeODsiOb0NFUFWucm3rAbNdb_bTQ@mail.gmail.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
 <20140826131339.GO23445@arm.com>
 <CAKv+Gu8Nji0Jspk2cMCwVGKeODsiOb0NFUFWucm3rAbNdb_bTQ@mail.gmail.com>
Message-ID: <20140826143011.GV23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:21:09PM +0100, Ard Biesheuvel wrote:
> On 26 August 2014 15:13, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Aug 26, 2014 at 11:28:47AM +0100, Punit Agrawal wrote:
> >> Add support to register hooks for undefined instructions. The handlers
> >> will be called when the undefined instruction and the processor state
> >> (as contained in pstate) match criteria used at registration.
> >>
> >> Note: The patch only deals with ARM instruction encodings and needs
> >> fixing to handle thumb instructions as well.
> >
> > [...]
> >
> >> +static int call_undef_hook(struct pt_regs *regs)
> >> +{
> >> +     struct undef_hook *hook;
> >> +     unsigned long flags;
> >> +     u32 instr;
> >> +     int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
> >> +     void __user *pc = (void __user *)instruction_pointer(regs);
> >> +
> >> +     /*
> >> +      * Currently, undefined instruction patching is only supported
> >> +      * for user mode. Also, as we're not emulating any thumb
> >> +      * instructions lets not add thumb instruction decoding until
> >> +      * it is needed.
> >> +      */
> >> +     if (!compat_user_mode(regs) || compat_thumb_mode(regs))
> >> +             return 1;
> >
> > What do you mean by `undefined instruction patching'? I don't see anything
> > in the mechanism that means this can't be reused for kernel code, then we
> > just register the SWP emulation hook for userspace only using the mode (like
> > we do for kgdb).
> >
> 
> You need this patch in order to be able to return from an undef
> exception taken in EL1:
> 
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -287,7 +287,9 @@ el1_undef:
>          */
>         enable_dbg
>         mov     x0, sp
> -       b       do_undefinstr
> +       bl      do_undefinstr
> +
> +       kernel_exit 1
>  el1_dbg:
>         /*
>          * Debug exception handling

Hmm, I'm surprised we don't already need something like this for KGDB...

Will

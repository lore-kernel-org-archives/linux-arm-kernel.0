From: zhizhou.zh@gmail.com (Zhi-zhou)
Date: Fri, 19 Feb 2016 10:30:09 +0800
Subject: [PATCH] arm64: add architecture specified current_pt_regs
In-Reply-To: <20160218115824.GA2538@e104818-lin.cambridge.arm.com>
References: <1455796115-7844-1-git-send-email-zhizhou.zh@gmail.com>
 <20160218115824.GA2538@e104818-lin.cambridge.arm.com>
Message-ID: <CAN1e=SF4iAVZzvs=+rJxmUX_z7KNSwegxWaor3gDfXD-=MAQ4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 7:58 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Feb 18, 2016 at 07:48:35PM +0800, Zhi-zhou Zhang wrote:
> > From: zhizhou <zhizhou.zh@gmail.com>
> >
> > This patch is based on the implementation of arm. The generic
> > current_pt_regs is implemented with current->stack. It need to access
> > memory that would be too expensive.
>
> Do you have any performance numbers?

I'm using QEMU, so no. Actually this macro isn't heavily used. I just
think using the generic
implementation is not very nice. It get task_struct from sp_el0, then
get stack(which is
equal to sp_el0) from task_struct. There are two unnecessary memory accesses.
>
>
> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index e9e5467..1865d54 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -185,5 +185,9 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
> >
> >  extern unsigned long profile_pc(struct pt_regs *regs);
> >
> > +#define current_pt_regs(void) ({ (struct pt_regs *)                  \
> > +     ((current_stack_pointer | (THREAD_SIZE - 1)) - 0xf) - 1;        \
> > +})
>
> I don't think this works well with the separate IRQ stack that we merged
> in 4.5-rc1. current_thread_info() explicitly uses "sp_el0" while
> current_stack_pointer is just "sp" (though I don't think we ever use
> current_pt_regs in interrupt context).
>
Thank you, that's a problem. So how about write it like this?

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e9e5467..b68e01c 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -185,5 +185,10 @@ static inline int valid_user_regs(struct
user_pt_regs *regs)

 extern unsigned long profile_pc(struct pt_regs *regs);

+#define current_pt_regs(void) ({ (struct pt_regs *)            \
+               (((unsigned long)current_thread_info() |        \
+               (THREAD_SIZE - 1)) - 0xf) - 1;                  \
+})
+
 #endif /* __ASSEMBLY__ */
 #endif

> --
> Catalin




-- 
Regards,
Zhi-zhou

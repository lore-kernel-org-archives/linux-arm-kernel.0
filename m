From: kpark3469@gmail.com (Keun-O Park)
Date: Thu, 3 Jan 2013 20:36:35 +0900
Subject: [PATCH 2/2] arm: make return_address available for ARM_UNWIND
In-Reply-To: <20130103103815.GL2631@n2100.arm.linux.org.uk>
References: <1357207949-3349-1-git-send-email-kpark3469@gmail.com>
 <1357207949-3349-2-git-send-email-kpark3469@gmail.com>
 <20130103103815.GL2631@n2100.arm.linux.org.uk>
Message-ID: <CA+KhAHbmjD7zTw+wcw84Abg3V1dD=0Ea4kUpYdGENQf1UOWphw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 3, 2013 at 7:38 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Thu, Jan 03, 2013 at 07:12:29PM +0900, kpark3469 at gmail.com wrote:
> > -#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
> > +#if defined(CONFIG_FRAME_POINTER) || defined(CONFIG_ARM_UNWIND)
> >  /*
> >   * return_address uses walk_stackframe to do it's work.  If both
> >   * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses
> unwind
> > - * information.  For this to work in the function tracer many functions
> would
> > - * have to be marked with __notrace.  So for now just depend on
> > - * !CONFIG_ARM_UNWIND.
>
> So what have you done about the issue referred in this comment?  Or do you
> believe that fixing warnings (even if they are explicit #warning
> statements)
> is far more important than code being functionally correct?
>

I admit that I missed to add notrace to unwind.c.
Do you think there's more to add?

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..52ff2d4 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -327,7 +327,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block
*ctrl)
  * Unwind a single frame starting with *sp for the symbol at *pc. It
  * updates the *pc and *sp with the new values.
  */
-int unwind_frame(struct stackframe *frame)
+int notrace unwind_frame(struct stackframe *frame)
 {
        unsigned long high, low;
        const struct unwind_idx *idx;
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/a7a24f1d/attachment-0001.html>

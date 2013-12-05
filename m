From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Thu, 05 Dec 2013 17:10:08 +0400
Subject: [PATCH 2/2] ARM: fix framepointer check in unwind_frame
In-Reply-To: <CAFrcx1kCAjoMxBeqaO+iS2CGzX6omuW1reL636Lyj=bg5DB1Rg@mail.gmail.com>
References: <20131205083424.32632.51618.stgit@buzz>
 <20131205083430.32632.11103.stgit@buzz>
 <CAFrcx1kCAjoMxBeqaO+iS2CGzX6omuW1reL636Lyj=bg5DB1Rg@mail.gmail.com>
Message-ID: <1386249008.17844.48.camel@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-05 at 13:45 +0100, Jean Pihet wrote:
> On 5 December 2013 09:34, Konstantin Khlebnikov
> <k.khlebnikov@samsung.com> wrote:
> > This patch fixes corner case when (fp + 4) overflows unsigned long,
> > for example: fp = 0xFFFFFFFF -> fp + 4 == 3.
> >
> > Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> > ---
> >  arch/arm/kernel/stacktrace.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> > index 00f79e5..af4e8c8 100644
> > --- a/arch/arm/kernel/stacktrace.c
> > +++ b/arch/arm/kernel/stacktrace.c
> > @@ -31,7 +31,7 @@ int notrace unwind_frame(struct stackframe *frame)
> >         high = ALIGN(low, THREAD_SIZE);
> >
> >         /* check current frame pointer is within bounds */
> > -       if (fp < (low + 12) || fp + 4 >= high)
> > +       if (fp < low + 12 || fp > high - 4)
> Shouldn't that use the '>=' comparison?

nope, fp == high-4 is fine:

-------------------+ 
... -5 -4 -3 -2 -1 | -0
-------------------+
        ^             ^
        +---- fp      +----- high
 
stack frame contains four 'unsigned long' values: {fp, sp, lr, pc}.
'fp' points to 'pc', so totally there are 16 bytes: fp-12..fp+3

> 
> Jean
> >                 return -EINVAL;
> >
> >         /* restore the registers from the stack frame */
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

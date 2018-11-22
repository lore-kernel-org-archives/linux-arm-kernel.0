From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 13:11:43 +0100
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <bf872be5-4a56-017b-83b6-544f8d8f528e@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <bf872be5-4a56-017b-83b6-544f8d8f528e@arm.com>
Message-ID: <CAKv+Gu9o_2-u6MJf1QLLSbdWfPvq0vqr61K0Nawr-Nob6hsepg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 at 12:49, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Hi,
>
> On 26/09/18 14:56, Julien Thierry wrote:
> > Hi,
> >
> > Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
> > using it to access memory. When taking an exception, it is possible that
> > the context during which the exception occured had SP mis-aligned. The
> > entry code needs to make sure that the stack is aligned before using it to
> > save the context.
> >
>
> So, as discussed in this thread:
> https://www.spinics.net/lists/arm-kernel/msg688342.html
>
> We might have the compiler provide the guarantee that SP is kept at
> multiples of 16-bytes throughout C functions. If this is accepted, it
> avoids the complexity of this series.
>

Yes, but we still want the build time sizeof(pt_regs) check and
perhaps other pieces of this series.

> There is just one case remaining, which is less important as it is
> mostly a debug concern. If we take an SP alignment fault from EL1 (due
> to bad implementation) we take recursive exceptions:
>
> - Without CONFIG_VMAP_STACK, kernel just freezes always taking SP
> alignment faults
> - With CONFIG_VMAP_STACK after taking a number of exceptions, we
> overflow the stack and the kernel switches to the overflow stack where
> it finally manages to display a kernel panic message
>
> So the question is, do we care about doing something for the above case?
>

So in the latter case, it is obvious from the debug output that the
stack pointer was misaligned? I'd expect so, given that each
recursively taken exception has the same cause, and so it would be
clear what happened.

So I'm leaning towards just relying on that, given that
CONFIG_VMAP_STACK is the default, although it is unfortunate that
KASAN still disables it.

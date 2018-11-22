From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Nov 2018 15:12:17 +0000
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <CAKv+Gu9o_2-u6MJf1QLLSbdWfPvq0vqr61K0Nawr-Nob6hsepg@mail.gmail.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <bf872be5-4a56-017b-83b6-544f8d8f528e@arm.com>
 <CAKv+Gu9o_2-u6MJf1QLLSbdWfPvq0vqr61K0Nawr-Nob6hsepg@mail.gmail.com>
Message-ID: <20181122151217.GB13896@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 01:11:43PM +0100, Ard Biesheuvel wrote:
> On Thu, 22 Nov 2018 at 12:49, Julien Thierry <julien.thierry@arm.com> wrote:
> > On 26/09/18 14:56, Julien Thierry wrote:
> > There is just one case remaining, which is less important as it is
> > mostly a debug concern. If we take an SP alignment fault from EL1 (due
> > to bad implementation) we take recursive exceptions:
> >
> > - Without CONFIG_VMAP_STACK, kernel just freezes always taking SP
> > alignment faults
> > - With CONFIG_VMAP_STACK after taking a number of exceptions, we
> > overflow the stack and the kernel switches to the overflow stack where
> > it finally manages to display a kernel panic message
> >
> > So the question is, do we care about doing something for the above case?
> >
> 
> So in the latter case, it is obvious from the debug output that the
> stack pointer was misaligned? I'd expect so, given that each
> recursively taken exception has the same cause, and so it would be
> clear what happened.
> 
> So I'm leaning towards just relying on that, given that
> CONFIG_VMAP_STACK is the default, although it is unfortunate that
> KASAN still disables it.

Whilst it's unfortunate, I don't think it's the end of the world as long
as KASAN remains a debug-only feature. In that case, you'd only enable it
if you were debugging a suspected use-after-free, and I think the splat
you'd see from the overflow is clear enough that it's not one of those.

However, I really would like a written confirmation (i.e. in some
documentation) from GCC that they won't misalign the SP in generated
code before we drop the meat of this series.

Will

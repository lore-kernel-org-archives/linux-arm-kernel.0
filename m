From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 22:10:02 +0100
Subject: [PATCH] ARM: move __fixup_smp out of init section
In-Reply-To: <CAL_Jsq+8p+p0wuRf9z01EKDcnGA95CmLvrDwDZzVETLe+SqpGg@mail.gmail.com>
References: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
 <22591791.dKqiiVNNOv@wuerfel>
 <CAL_Jsq+8p+p0wuRf9z01EKDcnGA95CmLvrDwDZzVETLe+SqpGg@mail.gmail.com>
Message-ID: <5546770.Bku2iJMdOj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 15:05:01 Rob Herring wrote:
> On Tue, Feb 25, 2014 at 12:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 25 February 2014 12:16:33 Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> With large kernel builds such as allyesconfig exceeding maximum relative
> >> branch offsets, the init section will be too far away to branch to
> >> directly. This causes veneers to be added by the compiler, but veneers
> >> don't work before the MMU is enabled. Fix this by moving __fixup_smp to
> >> the .head.text section as it is not very big.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This looks good to me, but I have some related questions:
> >
> > * I needed to use -mlong-calls for large kernels. Did you manage without?
> 
> Yes, but I started with allyesconfig and then disabled things until it
> would link. This was mainly PCI, various debug, and filesystems. This
> particular failure you don't see until you try to boot.
> 
> I also saw intermittent inconsistent kallsym errors which
> KALLSYMS_EXTRA_PASS=1 did not fix.

Yes, I saw those too. With XIP_KERNEL enabled, I've seen a randconfig case
that needed 12 extra passes before converging. Without that option,
it's much better but there are still cases that need more than 3 passes
and I haven't gotten to the bottom of that. It seems to be the same
configuration that refuses to link at all with ld.gold.

> > * Do you (or anyone) know how to force the use of a veneer? I see a problem
> >   with some driver calling __do_div_asm from IIRC an init section, and that
> >   creates a link error when the kernel gets too big
> 
> That is surprising given that I saw veneers be inserted for some asm
> to asm calls. Maybe it is something I turned off or something to do
> with the types of sections.
> 
> > * If FUNCTION_TRACER is enabled, we get calls from every function using
> >  'bl __gnu_mcount_nc'. Do you think it's possible to fix those?
> 
> Put it in the middle of the image? ;)
> 
> > * Same thing but simpler for svc_preempt calling preempt_schedule_irq
> >   and lookup_processor_type calling __lookup_processor_type. In those
> >   cases I guess we should be able to trivially rewrite the assembly
> >   to jump through an extra register.
> 
> I did see that lookup_processor_type had a veneer in my build.

Strange. Could it be that -mlong-calls turns off veneers?

Which gcc and binutils version do you use?

	Arnd

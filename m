From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 Feb 2012 11:02:39 -0600
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <20120221132536.GM22562@n2100.arm.linux.org.uk>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
 <20120218231849.GA1269@n2100.arm.linux.org.uk> <4F41136F.3060708@gmail.com>
 <20120221132536.GM22562@n2100.arm.linux.org.uk>
Message-ID: <4F43CE2F.8040604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 02/21/2012 07:25 AM, Russell King - ARM Linux wrote:
> On Sun, Feb 19, 2012 at 09:21:19AM -0600, Rob Herring wrote:
>> On 02/18/2012 05:18 PM, Russell King - ARM Linux wrote:
>>> On Thu, Feb 16, 2012 at 09:32:11PM -0600, Rob Herring wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> SA1100 was converted to sparse irq in parallel with include of mach/irqs.h
>>>> being removed from asm/irq.h when sparse irq is enabled, resulting in lots
>>>> of compile errors.
>>>
>>> Can this be applied before the change to enable sparse IRQ for sa11x0
>>> platforms without breaking them?
>>
>> All but the rename of NR_IRQS to SA1100_NR_IRQS should be fine, but I
>> can change it to leave NR_IRQS.
> 
> This isn't going to work.
> 
> If we update stuff to include mach/irqs.h, then we end up with mach/irqs.h
> trying to override NR_IRQS in asm/irq.h:
> 
> #ifndef CONFIG_SPARSE_IRQ
> #include <mach/irqs.h>
> #else
> #define NR_IRQS NR_IRQS_LEGACY
> #endif
> 
> which spits out a lovely warning:
> 
> In file included from arch/arm/mach-sa1100/irq.c:20:
> arch/arm/mach-sa1100/include/mach/irqs.h:86:1: warning: "NR_IRQS" redefined
> In file included from arch/arm/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:7,
>                  from include/linux/interrupt.h:12,
>                  from arch/arm/mach-sa1100/irq.c:14:
> arch/arm/include/asm/irq.h:9:1: warning: this is the location of the previous definition
> 

But this only occurs after you converted to SPARSE_IRQ, right? If you
add an "#ifndef NR_IRQS" to mach/irqs.h in your conversion, then
everything should be okay. Then after everything is merged, NR_IRQS can
be removed.

> There's three solutions I can think to this:
> 
> 1. you need to decouple the SPARSE IRQ conversion from the removal of
>    mach/irqs.h, so that there's a clean way to transition
> 2. I rebase the 100 odd otherwise unrelated sa11x0 patches on top of your
>    stuff, which isn't going to be a nice experience.

But the SPARSE_IRQ conversion commit is the last one on your sa11x0
branch. I'm assuming you are okay with rebasing that commit.

> 3. I drop the final commit for this merge window to convert sa11x0 to
>    sparse IRQ and the sparse IRQ conversion patch becomes quite large
>    (basically meaning that all the includes have to be changed in unison
>    with enabling sparse IRQ.)
> 
> (1) I think is the right solution, because it means that there's a nice
> easy transition path for everyone in the future without requiring (3)
> to happen every time.

Can you take a look at my branch sa11x0-sparse-irq I just pushed out.
It's based on your sa11x0 branch with just your sparse irq conversion
commit rebased. I've built it with and without the sparse irq conversion
and also merged my sparse_irq branch in without conflict and built that.

Rob

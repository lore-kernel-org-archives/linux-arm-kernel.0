From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Feb 2014 14:56:31 -0600
Subject: [PATCH] ARM: move __fixup_smp out of init section
In-Reply-To: <20140226122426.GX21483@n2100.arm.linux.org.uk>
References: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
 <20140226122426.GX21483@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+_2J7a0sB9UXmWLt4hX2oo1yUS5vbSQumCFA=yqacdSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 6:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 25, 2014 at 12:16:33PM -0600, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> With large kernel builds such as allyesconfig exceeding maximum relative
>> branch offsets, the init section will be too far away to branch to
>> directly. This causes veneers to be added by the compiler, but veneers
>
> Don't you mean the linker?  The compiler isn't involved here.  Can
> you show the disassembly of the veneer please?

Here is the call to fixup_smp:

c0008054:       eb000058        bl      c00081bc <__vet_atags>
c0008058:       eb00006a        bl      c0008208 <____fixup_smp_veneer>
c000805c:       eb000042        bl      c000816c <__fixup_pv_table>
c0008060:       eb000007        bl      c0008084 <__create_page_tables>

Here's the veneer:

c0008208 <____fixup_smp_veneer>:
c0008208:       e51ff004        ldr     pc, [pc, #-4]   ; c000820c
<____fixup_smp_veneer+0x4>
c000820c:       c2659260        .word   0xc2659260

>
> I'm confused why the linker would add a veneer for this, but not for
> the stuff built by the compiler.

There are 1413 other symbols with veneer in my image. So it is not
that the linker can't create them, but why it cannot for some as the
image gets bigger. Does "text" in a section name have any functional
impact on the linker? It seems veneers between .head.text and and
init.text are created, but between *.text and .fixup, .proc.info, etc.
they don't get created.

Rob

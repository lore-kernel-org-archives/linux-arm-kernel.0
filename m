From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 28 Nov 2011 14:02:27 +0000
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <20111128115324.GH9581@n2100.arm.linux.org.uk>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
 <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
 <20111125154157.GP12047@mudshark.cambridge.arm.com>
 <20111126220834.GB9581@n2100.arm.linux.org.uk>
 <20111127130016.GB26042@mudshark.cambridge.arm.com>
 <20111128113800.GD26946@mudshark.cambridge.arm.com>
 <20111128115324.GH9581@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk5YxCxSAvd4pjRL3Lbj8RzZrsLv304yafPxeORZoj_ZAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2011 11:53, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 28, 2011 at 11:38:00AM +0000, Will Deacon wrote:
>> On Sun, Nov 27, 2011 at 01:00:16PM +0000, Will Deacon wrote:
>> > On Sat, Nov 26, 2011 at 10:08:34PM +0000, Russell King - ARM Linux wrote:
>> > > I've merged this into my fixes branch, but when I re-merge this with
>> > > Marc's irqchip consolidation, I get conflicts. ?I think I've fixed it
>> > > correctly, but please check the result, which you'll find in my for-next
>> > > branch.
>> >
>> > Thanks for merging this. I've just had a quick look and the resolution looks
>> > functionally correct to me (I'll try booting your for-next branch tomorrow).
>>
>> I've tested on 1176, A8 and A9 platforms and your for-next branch seems to
>> be ok. I do get these compilation warnings on the UP CPUs:
>>
>> arch/arm/mm/ioremap.c: In function ?unmap_area_sections?:
>> arch/arm/mm/ioremap.c:80:3: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
>> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?
>> arch/arm/mm/ioremap.c: In function ?remap_area_sections?:
>> arch/arm/mm/ioremap.c:130:3: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
>> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?
>> arch/arm/mm/ioremap.c: In function ?remap_area_supersections?:
>> arch/arm/mm/ioremap.c:167:4: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
>> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?
>
> Welcome to those warnings.
>
> This is something that I've been complaining about for the last year, and
> is one of the reasons I've not been all that eager to merge the LPAE
> patches until it's properly resolved.
>
> The problem is caused by my "ARM: pgtable: switch to use pgtable-nopud.h"
> commit, which fixes up everywhere we access a small page table to use
> the standard pgd-pud-pmd-pte stuff. ?However, section support makes the
> conversion completely awful.

I've had a fix around for a while (and I agree, there are many other
ways to solve this but that's the least intrusive):

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=commitdiff;h=0473666c7954040b0f72e2ef5f8b9fa3272440e0

-- 
Catalin

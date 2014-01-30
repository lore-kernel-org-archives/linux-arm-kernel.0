From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 30 Jan 2014 16:42:29 -0500 (EST)
Subject: [PATCH V2] arm64: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <20140130180706.GO7575@mudshark.cambridge.arm.com>
References: <1390892813-30407-1-git-send-email-vkale@apm.com>
 <20140128161402.GI2885@mudshark.cambridge.arm.com>
 <CAPrCYkfpGJD+GQBmxqNZ8NM+9LhRvf5HiJrpMxHQzjrmPRhonA@mail.gmail.com>
 <20140130180706.GO7575@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1401301640500.1652@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jan 2014, Will Deacon wrote:

> On Thu, Jan 30, 2014 at 06:04:43AM +0000, Vinayak Kale wrote:
> > On Tue, Jan 28, 2014 at 9:44 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Tue, Jan 28, 2014 at 07:06:53AM +0000, Vinayak Kale wrote:
> > >> V2: - Add more desciption in the commit message as suggested by Catalin & Will
> > >>     - Use 'memory' clobber for flush instruction as suggested by Will
> > >
> > > Please can you check and fix other occurrences of this bug too, as I asked
> > > in v1? For example, a 2 second grep shows problems with data-cache
> > > maintenance in kvm. I can also see the same problem for system register
> > > writes followed up with isb.
> > Can you please elaborate whether you are referring to lack of memory
> > clobber or missing barriers?
> 
> The clobbers. For example:
> 
> arch/arm64/kvm/sys_regs.c:
> 
>         /* Make sure noone else changes CSSELR during this! */
>         local_irq_disable();
>         /* Put value into CSSELR */
>         asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
>         isb();
>         /* Read result out of CCSIDR */
>         asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
>         local_irq_enable();
> 
> Just about everything can be re-ordered in that block, because the asm
> volatile statements don't have "memory" clobbers.

I don't think they would be reordered at all with the 
volatile qualifiers.


Nicolas

From: ignatov.a@samsung.com (Alexey Ignatov)
Date: Fri, 22 Nov 2013 13:47:09 +0400
Subject: [PATCH 5/5] arm: Enable IRQs before attempting to read user	space
 in __und_usr
In-Reply-To: <20131121102923.GV16735@n2100.arm.linux.org.uk>
References: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
 <1377689664-27614-6-git-send-email-catalin.marinas@arm.com>
 <loom.20131121T102616-386@post.gmane.org>
 <20131121102923.GV16735@n2100.arm.linux.org.uk>
Message-ID: <20131122094709.GA23067@lexs-sg.rnd.samsung.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:29 Thu 21 Nov     , Russell King - ARM Linux wrote:
> On Thu, Nov 21, 2013 at 09:35:34AM +0000, Alexey Ignatov wrote:
> > Catalin Marinas <catalin.marinas <at> arm.com> writes:
> > 
> > > The Undef abort handler in the kernel reads the undefined instruction
> > > from user space. If the page table was modified from another CPU, the
> > > user access could fail and do_page_fault() will be executed with
> > > interrupts disabled. This can potentially deadlock on ARM11MPCore or on
> > > Cortex-A15 with erratum 798181 workaround enabled (both implying IPI for
> > > TLB maintenance with page table lock held).
> > > 
> > > This patch enables the IRQs in __und_usr before attempting to read the
> > > instruction from user space.
> > 
> > This patch moves enable_irq call from do_fpe directly to __und_usr handler,
> > but __und_svc handler also calls do_fpe (via call_fpe), so now this codepath
> > runs with disabled irqs. This behavior change doesn't look good for me.
> 
> However, you're not executing FPA instructions in the kernel as a general
> rule, so it doesn't matter.

Theoretically, ok.

It seems that we cought this deadlock on Cortex-A15 and this patch fixes things
(testing in progress). Is there any plans to mainline?

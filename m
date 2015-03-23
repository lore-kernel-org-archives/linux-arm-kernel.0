From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Mar 2015 18:00:16 +0000
Subject: [PATCH] arm64: efi: don't restore TTBR0 if active_mm points at
 init_mm
In-Reply-To: <20150323175055.GD12757@e104818-lin.cambridge.arm.com>
References: <1426779780-4706-1-git-send-email-will.deacon@arm.com>
 <1427116945.2693.10.camel@linaro.org>
 <20150323154458.GC12757@e104818-lin.cambridge.arm.com>
 <1427131377.2693.25.camel@linaro.org>
 <20150323175055.GD12757@e104818-lin.cambridge.arm.com>
Message-ID: <20150323180016.GE1556@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 05:50:55PM +0000, Catalin Marinas wrote:
> On Mon, Mar 23, 2015 at 05:22:57PM +0000, Jon Medhurst (Tixy) wrote:
> > On Mon, 2015-03-23 at 15:44 +0000, Catalin Marinas wrote:
> > > From 5d9e3540b6480558528612dd3672543fa8ab3528 Mon Sep 17 00:00:00 2001
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > Date: Mon, 23 Mar 2015 15:06:50 +0000
> > > Subject: [PATCH] arm64: Use the reserved TTBR0 if context switching to the
> > >  init_mm
> > > 
> > > The idle_task_exit() function may call switch_mm() with next ==
> > > &init_mm. On arm64, init_mm.pgd cannot be used for user mappings, so
> > > this patch simply sets the reserved TTBR0.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Jon Medhurst (Tixy) <tixy@linaro.org>
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > That unsurprising fixes the BUG_ON I was seeing on Juno, so...
> > Tested-by: Jon Medhurst (Tixy) <tixy@linaro.org>
> 
> Thanks.
> 
> > One question, is bypassing setting the mm_cpumask and context.id for
> > init_mm OK? I'm not familiar with the code but had a quick look, and it
> > looks like they are just used for ASID management, in which case I
> > assume everything is OK - ASIDs only being relevant for user mappings in
> > ttbr0?
> 
> That's my thinking as well. Will asked me the same question, so I'll let
> him confirm if he's seeing anything wrong.

I can't seem to break it. The ASID state should all be up to date with the
previous mm, so this should be harmless...

Will

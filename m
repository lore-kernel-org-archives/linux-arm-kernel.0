From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Nov 2014 15:14:51 +0000
Subject: [PATCH] Correct the race condition in
 aarch64_insn_patch_text_sync()
In-Reply-To: <20141111175132.GI16265@arm.com>
References: <1415637362-30754-1-git-send-email-wcohen@redhat.com>
 <20141110170846.GH23942@arm.com> <546113F4.1050304@redhat.com>
 <20141111112844.GC16265@arm.com> <546221BD.8000207@redhat.com>
 <20141111175132.GI16265@arm.com>
Message-ID: <20141113151451.GA22361@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 05:51:33PM +0000, Will Deacon wrote:
> On Tue, Nov 11, 2014 at 02:48:29PM +0000, William Cohen wrote:
> > From 41c728aeee2185fd30ec6a8ba223a2caec875f47 Mon Sep 17 00:00:00 2001
> > From: William Cohen <wcohen@redhat.com>
> > Date: Tue, 11 Nov 2014 09:41:27 -0500
> > Subject: [PATCH] Correct the race condition in aarch64_insn_patch_text_sync()
> > 
> > When experimenting with patches to provide kprobes support for aarch64
> > smp machines would hang when inserting breakpoints into kernel code.
> > The hangs were caused by a race condition in the code called by
> > aarch64_insn_patch_text_sync().  The first processor in the
> > aarch64_insn_patch_text_cb() function would patch the code while other
> > processors were still entering the function and incrementing the
> > cpu_count field.  This resulted in some processors never observing the
> > exit condition and exiting the function.  Thus, processors in the
> > system hung.
> > 
> > The first processor to enter the patching function performs the
> > patching and signals that the patching is complete with an increment
> > of the cpu_count field. When all the processors have incremented the
> > cpu_count field the cpu_count will be num_cpus_online()+1 and they
> > will return to normal execution.
> > 
> > Signed-off-by: William Cohen <wcohen@redhat.com>
> > ---
> >  arch/arm64/kernel/insn.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Catalin -- can you pick this into the fixes branch please?

Applied (and added Fixes and Cc stable lines). Thanks.

-- 
Catalin

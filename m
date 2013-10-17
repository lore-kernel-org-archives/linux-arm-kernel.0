From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Oct 2013 10:43:19 +0100
Subject: [PATCH v3 1/7] arm64: introduce basic aarch64 instruction
 decoding helpers
In-Reply-To: <525EC98A.6090802@gmail.com>
References: <1381893492-7135-1-git-send-email-liuj97@gmail.com>
 <1381893492-7135-2-git-send-email-liuj97@gmail.com>
 <20131016105142.GD5403@mudshark.cambridge.arm.com>
 <525EB279.9050504@gmail.com> <525EC98A.6090802@gmail.com>
Message-ID: <20131017094318.GC18765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 06:14:50PM +0100, Jiang Liu wrote:
> On 10/16/2013 11:36 PM, Jiang Liu wrote:
> > On 10/16/2013 06:51 PM, Will Deacon wrote:
> >> Take care here:
> >>
> >> 	- This doesn't guarantee that CPUs exclusively see new_insn (they
> >> 	  may see old_insn, even after patching)
> > Good point. Still need some synchronization mechanism lighter than
> > stop_machine(). How about kick_all_cpus_sync(), which should be lighter
> > than stop_machine()?
> For jump label, x86 uses three smp_call_function() to replace a
> stop_machine(). Seems it's valuable for us to use just one
> kick_all_cpus_sync() to avoid a stop_machine().

Yes, the exception return after handling the IPI from kick_all_cpus_sync
should be enough to synchronise the pipeline, providing that all cache
maintenance by the CPU writing the new instructions has completed (if you're
using flush_icache_range then you're fine).

Will

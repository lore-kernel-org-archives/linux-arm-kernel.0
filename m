From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Jul 2013 14:55:00 -0400 (EDT)
Subject: [PATCH 01/13] ARM: suspend: use hash of cpu_logical_map value
 to index into save array
In-Reply-To: <20130724164717.GA4610@localhost.localdomain>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-2-git-send-email-nicolas.pitre@linaro.org>
 <20130724164717.GA4610@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1307241437460.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Dave Martin wrote:

> On Mon, Jul 22, 2013 at 11:31:17PM -0400, Nicolas Pitre wrote:
> > Currently we hash the MPIDR of the CPU being suspended to determine which
> > entry in the sleep_save_sp array to use. In some situations, such as when
> > we want to resume on another physical CPU, the MPIDR of another CPU should
> > be used instead.
> > 
> > So let's use the value of cpu_logical_map(smp_processor_id()) in place
> > of the MPIDR in the suspend path.  This will result in the same index
> > being used as with the previous code unless the caller has modified
> > cpu_logical_map() beforehand.
> 
> This only works because we happen to swap MPIDRs in cpu_logical_map
> before we get here, so that cpu_logical_map(smp_processor_id())
> described the post-resume situation for this logical CPU, not the
> current situation.

Yes, that's more or less what I said above.  Maybe that should be 
clarified further?

> We have to swizzle cpu_logical_map() somewhere, and the suspend path is
> just as good as the resume path for that.

Not quite.  On the resume path, we have to get to the context save array 
while having no mmu active and no stack.  There is no way we could take 
over another CPU's context in those conditions without making it 
extremely painful on ourselves.  It is therefore way easier to swizzle 
cpu_logical_map() on the suspend path and keep the suspend/resume logic 
unmodified.

> But this patch commits us to requiring that on the suspend path 
> specifically -- I think that ought to be mentioned somewhere. A 
> comment in the preamble for __cpu_suspend would be enough, I think.

What comment would you suggest?  I want to make sure the possible 
confusion you see is properly addressed.

> Looks like the patch should work though, and it does remove the need to
> read the MPIDR, which is slightly nicer for the non-switcher case.

This patch works fine here, and I'd expect rather catastrophic results 
if it didn't.  ;-)


Nicolas

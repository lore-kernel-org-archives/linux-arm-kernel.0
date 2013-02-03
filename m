From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 3 Feb 2013 15:37:09 +0530
Subject: [PATCH v3 13/15] ARM: CCI: ensure powerdown-time data is flushed
 from cache
In-Reply-To: <alpine.LFD.2.02.1302021708460.6300@xanadu.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-14-git-send-email-nicolas.pitre@linaro.org>
 <510B5CF7.5080902@ti.com> <alpine.LFD.2.02.1302021708460.6300@xanadu.home>
Message-ID: <510E36CD.9000005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 February 2013 03:53 AM, Nicolas Pitre wrote:
> On Fri, 1 Feb 2013, Santosh Shilimkar wrote:
>
>> On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
>>> From: Dave Martin <dave.martin@linaro.org>
>>>
>>> Non-local variables used by the CCI management function called after
>>> disabling the cache must be flushed out to main memory in advance,
>>> otherwise incoherency of those values may occur if they are sitting
>>> in the cache of some other CPU when cci_disable() executes.
>>>
>> Any CPU calling cci_disable() would have already cleaned its local
>> cache and the snoop unit should take care of syncing the shared data
>> before hand from other CPU local caches for shared accesses.
>> May be I am unable to visualize the issue here or missing some key
>> point.
>
> Let's suppose CPU0 initializes the CCI.  Without this patch, the CCI
> base address might be sitting in CPU0's cache.
>
> The last CPU in a cluster to shut itself down is responsible for calling
> cci_disable().  And being the last, it is also responsible for flushing
> out its L1 and L2 caches before doing that.  If CPU0 went down before
> that, it did flush its L1 already. So the base address will be flushed
> to RAM in that case.
>
Yes. This is valid case. Thanks for description.

> But if it is a CPU in _another_ cluster which is shutting down and
> becoming the last man _there_.  It will flush its L1 and L2 cache
> before calling cci_disable().  And
> because the cache is disabled at that point, that CPU won't
> send any snoop request across to the other cluster where CPU0 holds the
> base address in its L1 or even L2 cache.
>
> This is why we must push out that value out to RAM before cci_disable()
> is used.
>
>>> This patch adds the appropriate flushing to the CCI driver to ensure
>>> that the relevant data is available in RAM ahead of time.
>>>
>>> Because this creates a dependency on arch-specific cacheflushing
>>> functions, this patch also makes ARM_CCI depend on ARM.
>>>
>> You should do that otherwise to avoid other arch building this
>> driver for random builds and breaking their builds.
>
> Before this patch the driver was buildable on any architecture.  That's
> why this dependency is added only in this patch.
>
I was just trying to counter the reasoning in the changelog which says
dependency is added because of arch specific cache flushing function.
Meaning even without that ARM dependency should be in place to avoid
driver getting build for other archs.

Regards,
Santosh

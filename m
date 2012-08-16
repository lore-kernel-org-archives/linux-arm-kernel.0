From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 16 Aug 2012 08:56:06 -0500
Subject: [PATCH 1/9] ARM: PMU: Add runtime PM Support
In-Reply-To: <20120813104006.GA20537@mudshark.cambridge.arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-2-git-send-email-will.deacon@arm.com>
 <CACVXFVMg5Acx4_KGT5jn1JgO3JsXAjZzU8virR=B3+pBrT4o_A@mail.gmail.com>
 <20120813104006.GA20537@mudshark.cambridge.arm.com>
Message-ID: <502CFBF6.7050404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/13/2012 05:40 AM, Will Deacon wrote:
> On Sat, Aug 11, 2012 at 04:09:51PM +0100, Ming Lei wrote:
>> On Sat, Aug 11, 2012 at 1:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>>> +       pm_runtime_put_sync(&pmu_device->dev);
>>
>> One question, each pmu is just inside one cpu core and should be
>> suspended individually, but looks the above don't support it, do it?
> 
> I'll let Jon elaborate, but I'm not sure that suspending the individual PMUs
> makes much sense if one of them is being used (other than taking the whole
> CPU offline). Given that tasks can migrate and perf-events can be across
> multiple CPUs, it makes it a lot easier to treat them as a single entity. It
> also allows us to implement mutual exclusion using the same hooks and to
> manage any common IP (e.g. CTI) at the same time, without having to keep
> track of things like the last man standing.
> 
> So, unless Jon has some ideas here, it's not something that I consider to be
> a real problem.

So from an OMAP3/4 perspective (which is the only device so far using
these runtime PM callbacks that I know of), it does not add any value to
suspend each PMU individually. For OMAP3/4, if one or more PMU is active
then we need to power up additional power domains and we need to keep
them powered until all PMUs are no longer in use.

For OMAP5 (which I have started testing) does not need other power
domains apart from the CPU power domain. So this could make more sense,
but I have not tried this yet. For now I think it is ok to keep as is
and then we can always change later to optimise for newer devices or
architectures if we think that they would benefit from this.

Cheers
Jon

From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 30 Mar 2015 16:39:29 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150330150552.GK24899@n2100.arm.linux.org.uk>
References: <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk> <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk> <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk> <55084D99.7050004@arm.com>
 <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk> <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk>
Message-ID: <55196E31.80803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/03/15 16:05, Russell King - ARM Linux wrote:
> On Mon, Mar 30, 2015 at 03:48:08PM +0100, Sudeep Holla wrote:
>> Though <2 2 1> works fine most of the time, I did try testing continuous
>> reboot overnight and it failed. I kept increasing the latencies and
>> found out that even max latency of <8 8 8> could not survive continuous
>> overnight reboot test and it fails with exact same issue.
>>
>> So I am not sure if we can consider it as a fix. However if we are OK to
>> have *mostly reliable*, then we can push that change.
>
> Okay, the issue I have is this.
>
> Versatile Express used to boot reliably in the nightly build tests prior
> to DT.  In that mode, we never configured the latency values.
>

I have never run in legacy mode as I am relatively new to vexpress
platform and started using with DT from first. Just to understand better
I had a look at the commit commit 81cc3f868d30("ARM: vexpress: Remove
non-DT code") and I see the below function in
arch/arm/mach-vexpress/ct-ca9x4.c So I assume we were programming one
cycle for all the latencies just like DT.

static void __init ca9x4_l2_init(void)
{
#ifdef CONFIG_CACHE_L2X0
	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);

	if (l2x0_base) {
		/* set RAM latencies to 1 cycle for this core tile. */
		writel(0, l2x0_base + L310_TAG_LATENCY_CTRL);
		writel(0, l2x0_base + L310_DATA_LATENCY_CTRL);

		l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
	} else {
		pr_err("L2C: unable to map L2 cache controller\n");
	}
#endif
}

> Then the legacy code was removed, and I had to switch over to DT booting,
> and shortly after I noticed that the platform was now randomly failing
> its nightly boot tests.
>
> Maybe we should revert the commit removing the superior legacy code,
> because that seems to be the only thing that was reliable?  Maybe it was
> premature to remove it until DT had proven itself?
>
> On the other hand, if the legacy code hadn't been removed, I probably
> would never have tested it - but then, from what I hear, this was a
> *known* issue prior to the removal of the legacy code.  Given that the
> legacy code worked totally fine, it's utterly idiotic to me to have
> removed the working legacy code when DT is soo unstable.
>
> Whatever way I look at this, this problem _is_ a _regression_, and we
> can't sit around and hope it magically vanishes by some means.
>

I agree, last time I tested it was fine with v3.18. However I have not
run the continuous overnight reboot test on that. I will first started
looking at that, just to see if it's issue related to DT vs legacy boot.

> I think given what you've said, it suggests that there is something else
> going on.  So, what we need to do is to revert the removal of the legacy
> code and investigate what the differences are between the apparently
> broken DT code and the working legacy code.
>

Agreed, I will see if DT boot was ever stable before before and
including v3.18

> I have not _once_ seen this behaviour with the legacy code.
>

OK

Regards,
Sudeep

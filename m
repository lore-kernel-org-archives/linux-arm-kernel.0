From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 16:23:01 +0000
Subject: [PATCH] arm64: percpu: Make this_cpu accessors pre-empt safe
In-Reply-To: <CAPvkgC2ntPrTVKi_WxHcMHqV2Rt9KZR9u-oUqVHNH8+1=nnnDg@mail.gmail.com>
References: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
 <20150319154435.GC25967@leverpostej>
 <CAPvkgC2ntPrTVKi_WxHcMHqV2Rt9KZR9u-oUqVHNH8+1=nnnDg@mail.gmail.com>
Message-ID: <20150319162300.GF25967@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It's a shame there don't seem to be any this_cpu_* self-tests; I've
> > booted a kernel with this applied, but I didn't have anything that
> > exploded without this, so I'd feel uneasy giving a Tested-by.
> 
> There is the percpu_test module, I ran this and it appeared to pass.
> Also, I ran the traditional hackbench tests.

I haan't spotted the percpu_test module, but looking at it, it seems to
be effectively useless. The body of the test is:

static int __init percpu_test_init(void)
{
	pr_info("percpu test start\n");
	preempt_disable();

	...
	/*
	 * test each this_cpu operation in turn
	 */
	...

	preempt_enable();
	pr_info("percpu test done\n");

	return -EAGAIN;
}

Which doesn't stress the this_cpu operations at all, unless you consider
the hard part to be the maths ;)

To test this patch thoroughly we need something that has a few threads
which perform some common use patterns (while getting migrated),
checking that they end up with consistent and the system doesn't lockup
or explode.

Mark.

From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 16:37:20 +0100
Subject: [PATCHv2] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <498b2e16-538a-d5ea-7843-2ebbff2007df@arm.com>
References: <1494514878-26878-1-git-send-email-mark.rutland@arm.com>
 <498b2e16-538a-d5ea-7843-2ebbff2007df@arm.com>
Message-ID: <20170511153719.GB19626@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 04:15:38PM +0100, Suzuki K Poulose wrote:
> On 11/05/17 16:01, Mark Rutland wrote:
> >+static inline bool cpus_have_const_cap(int num)
> >+{
> >+	if (static_branch_likely(&arm64_const_caps_ready))
> >+		return __cpus_have_const_cap(num);
> >+	else
> >+		return cpus_have_cap(num);
> 
> We use cpus_have_const_cap() from hyp code, via has_vhe() and we could potentially
> try to access unmapped kernel data from hyp if we fallback to cpus_have_cap().
> However, it looks like we have already set arm64_const_caps_ready, so should not
> hit it in practise. May be we could add a stricter version of the helper ?
> 
> static inline cpus_have_const_cap_strict(int num)
> {
> 	BUG_ON(!static_branch_likely(&arm64_const_caps_ready);
> 	return __cpus_have_const_cap(num);
> }

Just to check, is that the only user of cpus_have_const_cap() at hyp?

If so, I can do something like the above, patching <asm/virt.h> to use
it for has_vhe().

We don't have a BUG handler at hyp, but that should trigger a hyp panic,
which I guess is good enough.

Marc, thoughts?

Thanks,
Mark.

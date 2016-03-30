From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 30 Mar 2016 11:36:52 +0100
Subject: [PATCH 1/2] ARM: cpuidle: fix !cpuidle_ops[cpu].init case during
 init
In-Reply-To: <56FB89A8.90209@linaro.org>
References: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
 <1458796269-6158-2-git-send-email-jszhang@marvell.com>
 <56F52502.3060308@linaro.org> <20160330151629.0b338365@xhacker>
 <56FB89A8.90209@linaro.org>
Message-ID: <20160330103652.GC1219@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:09:12AM +0200, Daniel Lezcano wrote:
> On 03/30/2016 09:16 AM, Jisheng Zhang wrote:
> >Hi Daniel,
> 
> [ ... ]
> 
> Added Lorenzo and Catalin.
> 
> >>Hi Jisheng,
> >>
> >>this should be handled in the arm_cpuidle_read_ops function.
> >>
> >
> >Thanks for reviewing. After some consideration, I think this patch isn't correct
> >There may be platforms which doesn't need the init member at all, although
> >currently I don't see such platforms in mainline, So I'll drop this patch
> >and send out one v2 only does the optimization.
> 
> There is an inconsistency between ARM and ARM64. The 'cpu_get_ops',
> the arm_cpuidle_read_ops from the ARM64 side, returns -EOPNOTSUPP
> when the init function is not there for cpuidle.
> 
> I don't think it is a problem, but as ARM/ARM64 are sharing the same
> cpuidle-arm.c driver it would make sense to unify the behavior
> between both archs.

I agree and I think it makes sense to have an arm back-end that fails
if there is no cpuidle_ops.init function registered, I doubt any
usage of the cpuidle_ops.suspend is reasonable if it was not
initialized by a corresponding cpuidle_ops.init at boot, at least
that's how I see it working, I am open to other point of views.

Thanks,
Lorenzo

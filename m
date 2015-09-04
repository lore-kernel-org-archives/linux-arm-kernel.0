From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 4 Sep 2015 22:52:40 +0300
Subject: [RFC PATCH] arm64: cpuinfo: reduce cache contention on
 update_{feature}_support
In-Reply-To: <55E9C999.1090503@arm.com>
References: <1441382651-12058-1-git-send-email-ynorov@caviumnetworks.com>
 <55E9C999.1090503@arm.com>
Message-ID: <20150904195240.GA14679@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 05:40:57PM +0100, Suzuki K. Poulose wrote:
> On 04/09/15 17:04, Yury Norov wrote:
> >This patch is on top of https://lkml.org/lkml/2015/9/2/413
> >
> >In master, there's only a single function -
> >	update_mixed_endian_el0_support
> >And similar function is on review mentioned above.
> >
> >The algorithm for them is like this:
> >  - there's system-wide boolean marker for the feature that is
> >    initially enabled;
> >  - there's also updater for the feature that may disable it
> >    system-widely if feature is not supported on current CPU.
> >  - updater is called for each CPU on bootup.
> >
> >The problem is the way updater does its work. On each CPU, it
> >unconditionally updates system-wide marker. For multi-core
> >system it makes CPU issue invalidate message for a cache
> >line containing marker. This invalidate increases cache
> >contention for nothing, because there's a single marker reset
> >that is really needed, and the others are useless.
> >
> >If the number of system-wide markers of this sort will grow,
> >it may become a trouble on large-scale SOCs. The fix is trivial,
> >though: do system-wide marker update conditionally, and preserve
> >corresponding cache line in shared state for all update() calls,
> >except, probably, one.
> 
> As I have mentioned already, this patch (and the per feature functions)
> won't be needed once we merge my series (which is waiting for the merge
> window to see the public lights)
> 

OK. Than waiting for your patchset.

BR,
Yury

> Cheers
> Suzuki

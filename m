From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 1 May 2017 16:10:19 +0000
Subject: [PATCH v2] arm64: perf: Use only exclude_kernel attribute when
 kernel is running in HYP
In-Reply-To: <20170428163823.GX13675@arm.com>
References: <20170424154530.GO12323@arm.com>
 <CAFpQJXWX=0GQ5hse4E_OSdnYhMOA7CvqeoHe9AdMsyoZJmrPQQ@mail.gmail.com>
 <20170425165259.GS24484@arm.com>
 <CA+7sy7D-ZB84xQ2pE-io1v7pmnAuWUszh1B=Zq+Ezup=sysQ2g@mail.gmail.com>
 <CY4PR07MB3415C0CEBB9D3DF0C249DC6793110@CY4PR07MB3415.namprd07.prod.outlook.com>
 <20170426101021.GF21744@arm.com> <20170426134141.GA6417@localhost>
 <20170427173758.GN1890@arm.com> <20170428134623.GA85316@localhost>
 <20170428163823.GX13675@arm.com>
Message-ID: <20170501161018.GA7112@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 05:38:23PM +0100, Will Deacon wrote:
> Hi guys,
> 
> On Fri, Apr 28, 2017 at 01:46:24PM +0000, Jayachandran C wrote:
> > On Thu, Apr 27, 2017 at 06:37:59PM +0100, Will Deacon wrote:
> > > > If my understanding is correct, the sysfs suggestion above is going to
> > > > add API complexity without solving the issue. Ignoring the exclude_hv if
> > > > it cannot be honored would be a better solution.
> > > 
> > > Better for HHVM, sure, but I don't think it's better in general. It means
> > > that we silently do the opposite of what the user has requested in some
> > > configurations.
> > 
> > If my understanding is correct, when is_kernel_in_hyp_mode() is true,
> > the kernel is in EL2 and there is no real hypervisor with hvc calls
> > from kernel. Ignoring the exclude_hv would be correct.
> > 
> > When kernel is in EL1, it would be correct to consider exclude_hv to
> > skip events in EL2 (reached with hvc).
> > 
> > I don't see the issue, can you please give more detail on the config
> > with unexpected behavior?
> 
> This got me thinking, so I tried to look at the history of exclude_hv. It
> turns out it was added in 0475f9ea8e2c ("perf_counters: allow users to
> count user, kernel and/or hypervisor events") for PowerPC, not x86 (where
> this doesn't seem to be supported).
> 
> Notably, it looks like it's always ignored for the x86 CPU PMU, and ignored
> on PowerPC when a hypervisor is not present. I think that backs up your
> suggestion that we should ignore it when is_kernel_in_hyp_mode() is true.
> 
> In which case, I withdraw my objection to ignoring exclude_hv when running
> in hyp mode, but please add a comment explaining the rationale!

Thanks, we will send out an updated patch with a commit message summarizing
this disucssion.

JC

From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 11:52:18 +0100
Subject: [PATCH ] arm64: cpuinfo: Add "model name" in /proc/cpuinfo for
 64bit tasks also
In-Reply-To: <6a6e87361e7c4a1fab9639cb83276765@BGMAIL104.nvidia.com>
References: <1472461345-28219-1-git-send-email-sumitg@nvidia.com>
 <20160830091935.GD5163@e104818-lin.cambridge.arm.com>
 <6a6e87361e7c4a1fab9639cb83276765@BGMAIL104.nvidia.com>
Message-ID: <20160830105218.GD1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 10:35:56AM +0000, Sumit Gupta wrote:
>  
> > On Mon, Aug 29, 2016 at 02:32:25PM +0530, Sumit Gupta wrote:
> > > Removed restriction of displaying model name for 32 bit tasks only.
> > > Because of this Processor details were not displayed in "System
> > > setting -> Details" in Ubuntu model name display is generic and can be
> > > printed for 64 bit also.
> > >
> > > model name : ARMv8 Processor rev X (v8l)
> > >
> > > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > 
> > You didn't give a reason why this is needed. For 32-bit tasks, we did it for
> > backwards compatibility with code checking for it.
> 
> Within Ubuntu Home Screen "System setting -> details", processor details were coming as null.
> It seems those details are retrieved from "model name" in /proc/cpuinfo and
> because of check for 32 bit tasks only, "model name" was not getting displayed.

It's worth noting that for arm64, we have never exposed a "model name"
field for AArch64 tasks. i.e. the code was looking for something which
did not exist to begin with.

> On removing this check for model name, processor details are getting
> displayed in Ubuntu Home Screen.
> I think model name field is general and can be displayed irrespective
> of compatibility.

The "model name" field is somewhat useless, given we cannot query a
usable string from the HW. We'd deliberately chosen to not expose it, to
not give the impression that we would support trying to generate a
string. We do expose the decoded MIDR_EL1 fields, which we can query
from the HW.

As above, this has never existed for arm64, and so 64-bit code relying
on this non-existent field has never worked. It would be better to fix
the code in question.

Thanks,
Mark.

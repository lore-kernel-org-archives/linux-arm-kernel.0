From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Jul 2014 13:52:31 +0100
Subject: [PATCH  0/4] ARM: perf: Support i.MX53
In-Reply-To: <20140729123256.13347.79778.stgit@localhost>
References: <20140729123256.13347.79778.stgit@localhost>
Message-ID: <20140729125231.GM9245@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Tue, Jul 29, 2014 at 01:32:56PM +0100, Martin Fuzzey wrote:
> This series enables hardware performance counters on the i.MX53 SoC
> 
> This requires setting registers at both the ARM V7 core level
> and the i.MX53 SoC level.

>From a quick look at the patches, it sounds like you're booting in secure
mode and are trying to use perf there. Whilst I understand that you may want
to do this, I don't think the code you currently have is quite right:

 - It accesses the SDER unconditionally, which is undefined for non-secure
   modes.

 - It adds yet more callbacks to arm_pmu_platdata

Instead, how about we add a new property on the PMU node that says it
requires secure access, then we use that to configuer SDER in the perf code.
Then you can do your SoC-specific magic as part of the runtime PM hooks we
already have (it looks like enabled/disabling a clock really).

Will

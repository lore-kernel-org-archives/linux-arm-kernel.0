From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Tue, 22 May 2018 09:56:19 +0300
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
 <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
Message-ID: <001201d3f19a$0130a860$0391f920$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Monday, May 21, 2018 16:05
> To: ilialin at codeaurora.org; mturquette at baylibre.com; sboyd at kernel.org;
> robh at kernel.org; mark.rutland at arm.com; viresh.kumar at linaro.org;
> nm at ti.com; lgirdwood at gmail.com; broonie at kernel.org;
> andy.gross at linaro.org; david.brown at linaro.org; catalin.marinas at arm.com;
> will.deacon at arm.com; rjw at rjwysocki.net; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-pm at vger.kernel.org; linux-arm-
> msm at vger.kernel.org; linux-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; rnayak at codeaurora.org;
> amit.kucheria at linaro.org; nicolas.dechesne at linaro.org;
> celster at codeaurora.org; tfinkel at codeaurora.org
> Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 21/05/18 13:57, ilialin at codeaurora.org wrote:
> >
> [...]
> 
> >>> +#include <linux/cpu.h>
> >>> +#include <linux/err.h>
> >>> +#include <linux/init.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/nvmem-consumer.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/pm_opp.h>
> >>> +#include <linux/slab.h>
> >>> +#include <linux/soc/qcom/smem.h>
> >>> +
> >>> +#define MSM_ID_SMEM	137
> >>> +#define SILVER_LEAD	0
> >>> +#define GOLD_LEAD	2
> >>> +
> >>
> >> So I gather form other emails, that these are physical cpu number(not
> >> even unique identifier like MPIDR). Will this work on parts or
> >> platforms that need to boot in GOLD LEAD cpus.
> >
> > The driver is for Kryo CPU, which (and AFAIK all multicore MSMs)
> > always boots on the CPU0.
> 
> 
> That may be true and I am not that bothered about it. But assuming physical
> ordering from the logical cpu number is *incorrect* and will break if kernel
> decides to change the allocation algorithm. Kernel provides no guarantee on
> that, so you need to depend on some physical ID or may be DT to achieve
> what your want. But the current code as it stands is wrong.

Got your point. In fact CPUs are numbered 0-3 and ordered into 2 clusters in the DT:

cpus {
	#address-cells = <2>;
	#size-cells = <0>;

	CPU0: cpu at 0 {
		...
		reg = <0x0 0x0>;
		...
	};

	CPU1: cpu at 1 {
		...
		reg = <0x0 0x1>;
		...
	};

	CPU2: cpu at 100 {
		...
		reg = <0x0 0x100>;
		...
	};

	CPU3: cpu at 101 {
		...
		reg = <0x0 0x101>;
		...
	};

	cpu-map {
		cluster0 {
			core0 {
				cpu = <&CPU0>;
			};

			core1 {
				cpu = <&CPU1>;
			};
		};

		cluster1 {
			core0 {
				cpu = <&CPU2>;
			};

			core1 {
				cpu = <&CPU3>;
			};
		};
	};
};

As far, as I understand, they are probed in the same order. However, to be certain that the physical CPU is the one I intend to configure, I have to fetch the device structure pointer for the cpu-map -> clusterX -> core0 -> cpu path. Could you suggest a kernel API to do that?



> 
> --
> Regards,
> Sudeep

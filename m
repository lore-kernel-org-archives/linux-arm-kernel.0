From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 21 Oct 2015 11:59:07 +0200
Subject: [PATCH v5] arm-soc: Add support for Sigma Designs Tango4 platforms
In-Reply-To: <56266D46.5080809@sigmadesigns.com>
References: <56250FAC.2010800@sigmadesigns.com>
 <56266D46.5080809@sigmadesigns.com>
Message-ID: <562761EB.3070009@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/2015 18:35, Marc Gonzalez wrote:
> Changes in v5
> drop mac-address property from eth0 node
> tentatively add pmu node (not looking good)
> hw perfevents: failed to probe PMU!
> hw perfevents: failed to register PMU devices!

<Taking a closer look>

armv7_a9_pmu_init() eventually calls generic_exec_single()
which fails this test:

	if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu))

because cpu = 4 and nr_cpu_ids = 2

  /* Any online will do: smp_call_function_single handles nr_cpu_ids. */
  cpu = cpumask_any_and(mask, cpu_online_mask);

nr_cpu_ids starts out as 4  (CONFIG_NR_CPUS=4) but setup_nr_cpu_ids()
drops it to 2 (the actual number of cores).

<confused> I thought NR_CPUS was just the maximum number of CPUs.
Is it expected that armv7_a9_pmu_init() would fail as it does for me?

Regards.

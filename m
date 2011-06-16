From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jun 2011 12:40:30 -0700
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
Message-ID: <4DFA5C2E.40507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2011 01:49 AM, Vincent Guittot wrote:
> +config SCHED_MC
> +	bool "Multi-core scheduler support"
> +	depends on SMP && ARM_CPU_TOPOLOGY
> +	default n
> +	help
> +	  Multi-core scheduler support improves the CPU scheduler's decision
> +	  making when dealing with multi-core CPU chips at a cost of slightly
> +	  increased overhead in some places. If unsure say N here.
> +
> +config SCHED_SMT
> +	bool "SMT scheduler support"
> +	depends on SMP && ARM_CPU_TOPOLOGY
> +	default n
> +	help
> +	  Improves the CPU scheduler's decision making when dealing with
> +	  MultiThreading at a cost of slightly increased overhead in some
> +	  places. If unsure say N here.
> +

The default is already n so you can drop those two lines.

> +		 * This is a multiprocessor system
> +		 * multiprocessor format & multiprocessor mode field are set
> +		 */
> +
> +		if (mpidr & (0x1 << 24)) {
> +			/* core performance interdependency */
> +			cpuid_topo->thread_id = (mpidr & 0x3);
> +			cpuid_topo->core_id =  ((mpidr >> 8) & 0xF);
> +			cpuid_topo->socket_id = ((mpidr >> 16) & 0xFF);
> +		} else {
> +			/* normal core interdependency */
> +			cpuid_topo->thread_id = -1;
> +			cpuid_topo->core_id = (mpidr & 0x3);
> +			cpuid_topo->socket_id = ((mpidr >> 8) & 0xF);
> +		}
> +

The ARM ARM says these fields are IMPLEMENTATION DEFINED meaning that
different vendors may attribute different meaning to these fields if
they wish. Does that mean this should be a platform_*() function?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

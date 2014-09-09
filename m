From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 13:02:55 -0400
Subject: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20140909165226.GD4948@e102568-lin.cambridge.arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <20140903172138.GG1824@e102568-lin.cambridge.arm.com>
 <5408854B.9010703@linaro.org>
 <20140909165226.GD4948@e102568-lin.cambridge.arm.com>
Message-ID: <540F32BF.3000308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 12:52 PM, Lorenzo Pieralisi wrote:
> On Thu, Sep 04, 2014 at 04:29:15PM +0100, Hanjun Guo wrote:

>>>> +
>>>> +	/* Get cpu_ops include the boot CPU */
>>>> +	cpu_ops[cpu] = cpu_get_ops("psci");
>>>> +	if (!cpu_ops[cpu])
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* CPU 0 was already initialized */
>>>> +	if (cpu) {
>>>> +		if (cpu_ops[cpu]->cpu_init(NULL, cpu))
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>> +		/* map the logical cpu id to cpu MPIDR */
>>>> +		cpu_logical_map(cpu) = mpidr;
>>>> +
>>>> +		set_cpu_possible(cpu, true);
>>>> +	}
>>>> +
>>>> +	enabled_cpus++;
>>> See above to me enabled_cpus and (num_possible_cpus() - 1)  are identical.
>>
>> I think I need to remove all the CPU hotplug related code and make this function
>> as simple as possible and introduce them when needed.
> 
> Yes that makes sense, even though a bit of foresight is always appreciated;
> I certainly do not want you to completely rewrite this code to support CPU
> hotplug to be 100% clear. "Disabled" CPUs is a concept that is not
> managed at the moment with DT (on ARM and ARM64), and we need to introduce it
> properly. Again, I was asking questions, to understand why you would need
> those variables.
> 
> Have a look at this discussion:
> 
> https://lkml.org/lkml/2013/6/6/470

There could also be other reasons to disable "CPUs". For example, in an
SMT system configured not to use SMT threads, you might (in one
instantiation) decide to simply mark such GICCs as not enabled.

Jon.

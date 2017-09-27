From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Sep 2017 12:33:56 +0100
Subject: [PATCH 1/3] arm64: cpuinfo: add MPIDR value to /proc/cpuinfo
In-Reply-To: <20170926222324.17409-2-ahs3@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170926222324.17409-2-ahs3@redhat.com>
Message-ID: <20170927113356.GE32150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 04:23:22PM -0600, Al Stone wrote:
> When displaying cpuinfo on an arm64 system, include the MPIDR register
> value which can be used to understand the CPU topology on a platform.
> This can serve as a cross-check to the information provided in sysfs,
> and has been useful in understanding CPU and NUMA allocation issues.

As mentioend in the cover letter, NAK to modifiying /proc/cpuinfo.

However, I do think that we could expose this elsewhere in a structured
way.

For debugging bringup issues, I think we can update our secondary
bringup messages in dmesg to log the MPIDR (as we do for the boot CPU).
I'll send a patch for that.

> @@ -159,6 +160,12 @@ static int c_show(struct seq_file *m, void *v)
>  		}
>  		seq_puts(m, "\n");
>  
> +		seq_printf(m, "CPU MPIDR\t: 0x%016llx ", mpidr);
> +		seq_printf(m, "(Aff3 %d Aff2 %d Aff1 %d Aff0 %d)\n",
> +			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 3),
> +			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 2),
> +			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 1),
> +			   (u8) MPIDR_AFFINITY_LEVEL(mpidr, 0));

Please don't decode the register like this. We're stuck doing it with
the MIDR for historical reasons, but we shouldn't do it for new
registers.

It's possible (and I suspect likely) that MPIDR will gain more fields in
future, and it creates futher ABI problems (e.g. adding them might break
applications).

If we're going to expose this, we should expose the raw value under
sysfs. Users who require this information will know how to decode it.

Thanks,
Mark.

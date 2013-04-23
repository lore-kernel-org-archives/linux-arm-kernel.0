From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 20:31:22 +0100
Subject: [PATCH v4 06/15] ARM: mcpm: generic SMP secondary bringup and
 hotplug support
In-Reply-To: <1360041732-17936-7-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-7-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423193122.GB5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:22:03AM -0500, Nicolas Pitre wrote:
> +static void mcpm_cpu_die(unsigned int cpu)
> +{
> +	unsigned int mpidr, pcpu, pcluster;
> +	mpidr = read_cpuid_mpidr();
> +	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +	mcpm_set_entry_vector(pcpu, pcluster, NULL);
> +	mcpm_cpu_power_down();

How are dirty caches handled here for the dying CPU?  Bear in mind at the
moment, all that is left to the smp platform implementation, but I don't
see anything in your patch set so far which handles this.

This is going to be especially important as we're moving that into the
generic CPU hotplug code out of the platform code.

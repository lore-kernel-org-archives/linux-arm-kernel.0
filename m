From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Mar 2017 15:34:21 +0000
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
Message-ID: <20170315153420.GC9404@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 04:14:57PM -0600, Jeremy Linton wrote:
> On 03/10/2017 05:04 AM, Mark Rutland wrote:
> >I've given this some testing on a Juno platform (using SPIs). To see that IRQs
> >are correctly associated, I've tested with the following:
> >
> >  $ taskset -c ${SOME_CPU_HERE} perf record \
> >    -e armv8_pmuv3_0/cpu_cycles/ \
> >    -e armv8_pmuv3_1/cpu_cycles/ \
> >    cat /proc/interrupts
> >
> >I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
> >association logic. This has also been tested in a VM using PPIs; I do not have
> >access to a host machine which itself uses PPIs.
> 
> I tried these patches on a m400 (which uses PPIs), and the kernel
> fails to come up enough to login via the network (which works with
> 4.11rc1 without these patches). So, I suspect there is something
> wrong with them. Although its quite possibly PEBCAK.

It looks like we've gotten to the bottom of the hang in the other
thread; I had a go with a hack to bodge around that (as I have not yet
upgraded the FW).

I had a go with the above taskset pattern (limited to a single PMU) on
an APM Mustang board. Everything seems happy, even when I booted with
maxcpus temporarily capped, where CPUs successfully associated
themselves with the PMU later on.

Thanks,
Mark.

From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Sun, 25 Oct 2015 13:36:00 +0530
Subject: [PATCH v3 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <562C8D68.9040008@reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 10:52 PM, Suzuki K. Poulose wrote:
> Apart from the selected feature registers, we expose MIDR_EL1 (Main
> ID Register). The user should be aware that, reading MIDR_EL1 can be
> tricky on a heterogeneous system (just like getcpu()). We export the
> value of the current CPU where 'MRS' is executed. REVIDR is not exposed
> via MRS, since we cannot guarantee atomic access to both MIDR and REVIDR
> (task migration). So they both are exposed via sysfs under :
> 
> 	/sys/devices/system/cpu/cpu$ID/identification/
> 							\- midr
> 							\- revidr
> 
> The ABI useful for the toolchains (e.g, gcc, dynamic linker, JIT) to make
> better runtime decisions based on what is available.

Thank you for doing this.  I'm prototyping glibc support to select
optimal functions by micro-architecture and I had a couple of concerns.

The midr emulation may not be sufficient for glibc to select optimal
routines because there could theoretically be sufficient variance
between cpus with only different revidr that vendors may write different
optimal routines.  Secondly, on a heterogeneous system, we won't be able
to select a routine reliably using just the emulated instruction since
we have no control where it runs and we would want to know what each of
the cpus looks like.

The sysfs API solves this problem, but it doesn't seem like an optimal
thing to do in an IFUNC resolver in glibc.  CPU information is scattered
in 2*N+1 files for N processor cores.  This means for every process, one
has to make 4*N+2 system calls to simply read in this information and
cache it for later decision making.  On a 64 core system, this would
mean making 258 additional system calls from within the IFUNC resolver,
which seems quite excessive.

Would you be able to consolidate all cpu identification into a single
file?  This would allow glibc to just map in the file and read in all of
the information in one go, greatly reducing the number of syscalls.

The other alternative I was thinking of was to have an additional hwcap
HWCAP_HETEROGENEOUS_CPU which is set if there are different kinds of
processor cores in the system, but that will force us to stick to
default routines for heterogeneous cores.

Siddhesh

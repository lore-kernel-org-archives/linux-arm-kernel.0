From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 16 Oct 2012 23:29:39 +0530
Subject: [RFC PATCH] ARM: kernel: update cpuinfo to print all online CPUs
 features
In-Reply-To: <1350404684-6883-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1350404684-6883-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <507DA08B.502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 October 2012 09:54 PM, Lorenzo Pieralisi wrote:
> Currently, reading /proc/cpuinfo provides userspace with CPU ID of
> the CPU carrying out the read from the file. This is fine as long as all
> CPUs in the system are the same. With the advent of big.LITTLE and
> heterogenous ARM systems this approach provides user space with incorrect
> bits of information since CPU ids in the system might differ from the one
> provided by the CPU reading the file.
>
> This patch updates the cpuinfo show function and some internal data
> structures so that a read from /proc/cpuinfo prints HW information for
> all online CPUs at once, mirroring x86 behaviour.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>
> Posting it as a way to get advice on the best way to improve /proc/cpuinfo for
> heterogenous multi-cluster systems and to provide proper information to
> userspace without breaking existing semantics, no more than that.
>
> Comments more than welcome.
>
> Thanks,
> Lorenzo
>
>   arch/arm/include/asm/cpu.h |  1 +
>   arch/arm/kernel/setup.c    | 66 +++++++++++++++++++++++-----------------------
>   arch/arm/kernel/smp.c      |  1 +
>   3 files changed, 35 insertions(+), 33 deletions(-)
>

[...]

> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 8707cff..bf7839d08 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -1054,13 +1054,15 @@ static const char *hwcap_str[] = {
>
>   static int c_show(struct seq_file *m, void *v)
>   {
> -	int i;
> +	int i, j;
> +	u32 cpuid;
>
> -	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> -		   cpu_name, read_cpuid_id() & 15, elf_platform);
> +	for_each_online_cpu(i) {
> +		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
> +		seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> +			   cpu_name, cpuid & 15, elf_platform);
>
Not exactly related to the $subject patch, but I remember doing a patch
to have cat /proc/cpuinfo spitting only online CPUs just like x86 using
for_each_online_cpu(i).
At that point Russell mentioned about a possibility of read() syscall
spreading over the hot-plug operation and hence the above may not
be safe.

is that right Russell ?

regards
Santosh

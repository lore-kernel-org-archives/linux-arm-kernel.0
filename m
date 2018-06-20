From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2018 15:42:58 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2A6218.3030201@hisilicon.com>
References: <5B2A6218.3030201@hisilicon.com>
Message-ID: <20180620144257.GB27776@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On Wed, Jun 20, 2018 at 10:18:00PM +0800, Wei Xu wrote:
> We have observed KVM guest sometimes failed to boot because of kernel stack
> overflow if KPTI is enabled on a hisilicon arm64 platform.
> 
> We also tested with different kernel version and found it is only
> happened if the KPTI and KVM(enable-kvm & cpu=host) are enabled on the
> guest.
> The detail result is as below table.
> 
> +---------+----------+--------+------------+-------------------+
>      |  host   |host KPTI | guest  | guest KPTI | kvm guest         |
>      |  kernel |enabled   | kernel | enabled    | booting result    |
> +---------+----------+--------+------------+-------------------+
>      |  4.17   |     Y    |  4.17  |     Y      |  stack overflow   |
> +---------+----------+--------+------------+-------------------+
>      |  4.17   |     Y    |  4.16  |     NA     | OK          |
> +---------+----------+--------+------------+-------------------+
>      |  4.16   |     NA   |  4.17  |     Y      |  stack overflow   |
> +---------+----------+--------+------------+-------------------+
>      |  4.16   |     NA   |  4.16  |     NA     | OK          |
> +---------+----------+--------+------------+-------------------+
> 
> A simple walk-around is adding this platform into the "kpti_safe_list".
> But it does not resolve the issue indeed.
> Could you please share any hint how to resolve this kind issue?
> Thanks!
> 
> Another issue we found is "kpti_install_ng_mappings" will be invoked
> even "kpti=off" has been added in the kernel command line. Is that expected?
> This is because "kpti" is not a *early* param that "init_cpu_features" will
> be invoked before parsing the param.

That sounds like a straightforward bug, which means we should use
early_param instead of __setup. I assume that doesn't fix your crash,
though?

> The command we are using to run the guest is as:
> 
>     ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3 -cpu
> host
>     -enable-kvm -smp 1 -m 1024 -kernel ./Image -initrd
> ../mini-rootfs-arm64.cpio.gz
>     -nographic -append "rdinit=init console=ttyAMA0
> earlycon=pl011,0x9000000"
> 
> The log is as below:
> 
>         [    0.000000] Booting Linux on physical CPU 0x0000000000
> [0x480fd010]
>         [    0.000000] Linux version 4.17.0-45864-g29dcea8-dirty
> (joyx at Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 SMP PREEMPT Fri Jun
> 15 21:39:52 CST 2018

^^^ This is reproducible with vanilla v4.17 and defconfig, right?

>         [    0.038859] SMP: Total of 1 processors activated.
>         [    0.039338] CPU features: detected: GIC system register CPU
> interface
>         [    0.039988] CPU features: detected: Privileged Access Never
>         [    0.040560] CPU features: detected: User Access Override
>         [    0.041093] CPU features: detected: RAS Extension Support
>         [    0.042947] Insufficient stack space to handle exception!
>         [    0.042949] ESR: 0x96000046 -- DABT (current EL)
>         [    0.043963] FAR: 0xffff0000093a80e0
>         [    0.045794] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
>         [    0.052181] IRQ stack: [0xffff000008000000..0xffff000008004000]
>         [    0.058572] Overflow stack:
> [0xffff80003efce2f0..0xffff80003efcf2f0]
>         [    0.065068] CPU: 0 PID: 12 Comm: migration/0 Not tainted
> 4.17.0-45864-g29dcea8-dirty #6
>         [    0.073138] Hardware name: linux,dummy-virt (DT)
>         [    0.077831] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>         [    0.082661] pc : el1_sync+0x0/0xb0
>         [    0.086152] lr : kpti_install_ng_mappings+0x120/0x214

Can you use scripts/faddr2line to find out which line of code the lr is
pointing at, please? It would be interesting to know if we managed to
install the idmap.

Hmm, I wonder if this is at all related to RAS, since we've just enabled
that and if we take a fault whilst rewriting swapper then we're going to
get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?

Will

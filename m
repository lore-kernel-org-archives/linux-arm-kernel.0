From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 14:13:38 -0500
Subject: [U-Boot] [RFC PATCH 0/2] ARM: v7: Enable basic framework for
 supporting bits for CVE-2017-5715
In-Reply-To: <CAOMZO5CcEf=EhFWknKmCXXLJPOgx=65jLH+X1OAGkg5VxBGVew@mail.gmail.com>
References: <20180125214559.27570-1-nm@ti.com>
 <CAOMZO5CcEf=EhFWknKmCXXLJPOgx=65jLH+X1OAGkg5VxBGVew@mail.gmail.com>
Message-ID: <CAGo_u6qyf1Z+zSG-17TYRDPzG8V_0_-nk1F15HB4tPyT9rbUYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 9:05 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Jan 25, 2018 at 7:45 PM, Nishanth Menon <nm@ti.com> wrote:
>> Hi Folks,
>>
>> This is a follow through on the discussion we have had in [1].
>> This itself is'nt a complete solution and is based on recommendation
>> This from Arm[2] for variant 2 CVE-2017-5715
>>
>> The Linux kernel discussions are spread out in [3], ATF and OPTEE
>> status are available in [4].
>>
>> This is just an RFC series (build tested at this point) to check if
>> the direction is fine and should follow the final solution once kernel
>> patches get to upstream, IMHO.
>>
>> NOTE: As per ARM recommendations[2], and discussions in list[1] ARM
>> Cortex-A9/12/17 do not need additional steps in u-boot to enable the
>> OS level workarounds.
>>
>> Nishanth Menon (2):
>>   ARM: Introduce ability to enable ACR::IBE on Cortex-A8 for
>>     CVE-2017-5715
>>   ARM: Introduce ability to enable invalidate of BTB on Cortex-A15 for
>>     CVE-2017-5715
>

I started respinning the series, while there is definitely a use of
implementing in u-boot,
I am starting to wonder if we should also be doing this in kernel. ->
following is an example:
for OMAP5uEVM (dual A15) with  next-20180612 -> Uboot does setup the
IBE bit, so the
CPU0 ICIALLU does get activated however, that is not true for CPU1.
Further if we enter low power states, we'd also start loosing the
context, wont we?

Log:

[    0.001484] Calibrating delay loop (skipped), value calculated
using timer frequency.. 12.28 BogoMIPS (lpj=61440)
[    0.001510] pid_max: default: 32768 minimum: 301
[    0.001804] Security Framework initialized
[    0.001907] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001928] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004144] CPU: Testing write buffer coherency: ok
[    0.004258] CPU0: Spectre v2: using ICIALLU workaround
[    0.005130] /cpus/cpu at 0 missing clock-frequency property
[    0.005159] /cpus/cpu at 1 missing clock-frequency property
[    0.005178] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006660] Setting up static identity map for 0x80100000 - 0x80100078
[    0.007036] rcu: Hierarchical SRCU implementation.
[    0.008424] smp: Bringing up secondary CPUs ...
[    0.010557] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.010566] CPU1: Spectre v2: firmware did not set auxiliary
control register IBE bit, system vulnerable
[    0.011162] smp: Brought up 1 node, 2 CPUs
[    0.011181] SMP: Total of 2 processors activated (24.57 BogoMIPS).
[    0.011197] CPU: All CPU(s) started in HYP mode.
[    0.011211] CPU: Virtualization extensions available.
[    0.013729] devtmpfs: initialized
[    0.044497] VFP support v0.3: implementor 41 architecture 4 part 30
variant f rev 0
[    0.046160] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.046201] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.046942] pinctrl core: initialized pinctrl subsystem
[    0.050282] NET: Registered protocol family 16
[    0.054624] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.055930] omap_hwmod: l3_main_3 using broken dt data from ocp
[    0.057244] omap_hwmod: l3_main_2 using broken dt data from ocp
[    0.167706] audit: initializing netlink subsys (disabled)
[    0.168044] audit: type=2000 audit(0.160:1): state=initialized
audit_enabled=0 res=1
[    0.168979] (NULL device *): Failed to create dummy-scm_conf at 0
debugfs directory
[    0.169566] cpuidle: using governor menu
[    0.184644] OMAP GPIO hardware version 0.1


-- 
---
Regards,
Nishanth Menon

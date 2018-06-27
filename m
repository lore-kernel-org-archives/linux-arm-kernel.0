From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 27 Jun 2018 11:51:45 +0800
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks for
 CPU hotplug
In-Reply-To: <b40f9a03-e416-f4e6-707b-257f4d29d893@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <d6812552-f27c-83d8-900d-5849e5c6d141@huawei.com>
 <b40f9a03-e416-f4e6-707b-257f4d29d893@arm.com>
Message-ID: <1fff22a2-0421-c102-172a-508d1ca8f2b0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/6/26 17:23, Sudeep Holla wrote:
[...]
>> Core(s) per socket:    15      //it's 15 now...
> 
> I know exactly what's the problem. And I think that's exactly the
> behavior on my x86 box too. Further you might see another issue
> as most of these applications like lstopo and lscpu parse only CPU0
> sysfs, things fall apart if CPU0 is hotplugged out which is not allowed
> on most of x86 boxes I have tried.
> 
> So, for me, that's issue with the application TBH.
> 
> [..]
> 
>> Offlined 16 cores on NUMA node 0, everything backs to normal:
> 
> Expected :)
> 
>> but when onlined CPU15 after,
>> Architecture:          aarch64
>> Byte Order:            Little Endian
>> CPU(s):                64
>> On-line CPU(s) list:   15-63
>> Off-line CPU(s) list:  0-14
>> Thread(s) per core:    1
>> Core(s) per socket:    12     // it's 12, hmm...
> 
> I had to looks at the lscpu code and I think that explains why you can
> get 12 here. We have
> 	add_summary_n(tb, _("Core(s) per socket:"),
> 		cores_per_socket ?: desc->ncores / desc->nsockets);
> 
> Now cores_per_socket because we don't have procfs entry, so ncores=49
> and nsockets=4, which means you get 12. TBH lscpu should be used only
> when all CPUs are online. Lots of inaccurate assumptions in it.
> 
>>
>> I think maybe the cpumask for the socket is changed in a
>> wrong way when online/offline CPUs, didn't take a deep look into
>> that, hope the test helps.
>>
> 
> I am not convinced if there's any issue unless you see discrepancy in
> sysfs entries themselves and not though applications interpreting the
> values for you based on some wrong assumptions.

Thanks for the clarify and let me know the detail, I tested 4.17 on
a x86 machine which CPU0 can be offlined, also with the same lscpu version,
I got the same on x86:

lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                72
On-line CPU(s) list:   1-9,11-23,25-45,47-65,67-71
Off-line CPU(s) list:  0,10,24,46,66                  // offline CPUs to make no continuous 18 logical CPUs on a socket
Thread(s) per core:    1                              // it's 2 before CPU offlined
Core(s) per socket:    17                             // and not 18 which is the value before CPU offlined
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz
Stepping:              4
CPU MHz:               2999.755
CPU max MHz:           3700.0000
CPU min MHz:           1000.0000
BogoMIPS:              4600.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              25344K
NUMA node0 CPU(s):     1-9,11-17,36-45,47-53
NUMA node1 CPU(s):     18-23,25-35,54-65,67-71

So with this patch set:

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

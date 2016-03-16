From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 16 Mar 2016 08:06:22 -0500
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160316100759.GA18387@arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com>
Message-ID: <56E95A4E.4050709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> [adding Cavium folk and Timur]
>
> On Wed, Mar 16, 2016 at 05:32:23PM +0800, Ganesh Mahendran wrote:
>> Reverts commit 97303480753e ("arm64: Increase the max granular size").
>>
>> The commit 97303480753e ("arm64: Increase the max granular size") will
>> degrade system performente in some cpus.
>>
>> We test wifi network throughput with iperf on Qualcomm msm8996 CPU:
>> ----------------
>> run on host:
>>    # iperf -s
>> run on device:
>>    # iperf -c <device-ip-addr> -t 100 -i 1
>> ----------------
>>
>> Test result:
>> ----------------
>> with commit 97303480753e ("arm64: Increase the max granular size"):
>>      172MBits/sec
>>
>> without commit 97303480753e ("arm64: Increase the max granular size"):
>>      230MBits/sec
>> ----------------
>>
>> Some module like slab/net will use the L1_CACHE_SHIFT, so if we do not
>> set the parameter correctly, it may affect the system performance.
>>
>> So revert the commit.
>
> Unfortunately, the original patch is required to support the 128-byte L1
> cache lines of Cavium ThunderX, so we can't simply revert it like this.
> Similarly, the desire for a single, multiplatform kernel image prevents
> us from reasonably fixing this at compile time to anything other than
> the expected maximum value.
>
> Furthermore, Timur previously said that the change is also required
> "on our [Qualcomm] silicon", but I'm not sure if this is msm9886 or not:
>
> http://lkml.kernel.org/r/CAOZdJXUiRMAguDV+HEJqPg57MyBNqEcTyaH+ya=U93NHb-pdJA at mail.gmail.com

I was talking about our server part, the QDF2432.  At the time, I wasn't 
allowed to mention it by name.

> You could look into making ARCH_DMA_MINALIGN a runtime value, but that
> looks like an uphill struggle to me. Alternatively, we could only warn
> if the CWG is bigger than L1_CACHE_BYTES *and* we have a non-coherent
> DMA master, but that doesn't solve any performance issues from having
> things like locks sharing cachelines, not that I think we ever got any
> data on that (afaik, we don't pad locks to cacheline boundaries anyway).
> I'm also not sure what it would mean for PCI NoSnoop transactions.

Our internal version of this patch made it a Kconfig option.  Perhaps 
that would at least be an improvement over just reverting it?  We 
already have to have our own defconfig for the QDF2432.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

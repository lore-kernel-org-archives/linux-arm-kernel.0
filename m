From: steve.muckle@linaro.org (Steve Muckle)
Date: Mon, 8 Feb 2016 15:59:48 -0800
Subject: [PATCH v3 0/6] CPUs capacity information for heterogeneous systems
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Message-ID: <56B92BF4.4030405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juri,

On 02/03/2016 03:59 AM, Juri Lelli wrote:
>  v1: DT + sysfs [1]
> 
>  v2: Dynamic profiling at boot [2]
> 
> Third version of this patchset proposes what seems to be the solution we agreed
> upon (see [2] for reference) to the problem of how do we init CPUs original
> capacity: we run a bogus benchmark (stealing int_sqrt from lib/ we run that in
> a loop to perform some integer computation, better benchmarks are welcome)
> on the first cpu of each frequency domain (assuming no u-arch differences
> inside domains), measure time to complete a fixed number of iterations and then
> normalize results to SCHED_CAPACITY_SCALE (1024). This time around we also
> added a boot time parameter to disable profiling at boot (as it can be time
> consuming) and sysfs attributes with which default values can be overwritten.
> The proposed solution is basically putting together bits of v1 and v2 that are
> considered valuable and acceptable for mainline.

I'm still concerned that there's no way to obtain optimal boot time on a
heterogeneous system. Either the dynamic benchmarking is enabled, adding
1 sec, or the benchmarking is skipped, and task distribution on the
heterogeneous CPUs is determined by the platform's CPU numbering and
chance, potentially impacting performance nondeterministically until
userspace sets the correct capacity values via sysfs.

I believe you tested the impact on boot time of using equal capacity
values and saw little difference. I'm wondering though, what was the CPU
numbering on that target?

thanks,
Steve

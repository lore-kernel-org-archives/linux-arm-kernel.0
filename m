From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 20 Sep 2009 23:46:03 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090920190227.GB5413@n2100.arm.linux.org.uk>
References: <4A7AEEB6.5060903@googlemail.com>	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>	<20090817140422.GA10764@n2100.arm.linux.org.uk>	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>	<20090919224022.GA738@n2100.arm.linux.org.uk>	<1253435940.498.15.camel@pc1117.cambridge.arm.com>	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
Message-ID: <4AB6B0AB.8040307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Sep 20, 2009 at 10:31:39AM +0100, Russell King - ARM Linux wrote:
>> On Sun, Sep 20, 2009 at 09:39:00AM +0100, Catalin Marinas wrote:
>>> I don't think it's recommended to clean the D-cache (and invalidate the
>>> I-cache) every time in copy_user_highpage, therefore cache maintenance
>>> via mprotect -> change_protection -> flush_cache_range may be a better
>>> option.
>> I really don't believe so - try it yourself - run some benchmarks on your
>> ARMv6 or v7 system, comparing the results both with and without the patch.
>> Especially pay attention to the process creation/shell script performance.
>> I think you'll find that with your patch, it'll be worse than ARM systems
>> running at similar clock rates with VIVT caches.
> 
> The figures reveal a 10% reduction in the performance of execve - that's
> quite a nasty hit, basically meaning shell scripts will run about 10%
> slower (shell scripts typically exec lots of programs.)
> 
> Using my proposal measures more favourably - there is no measurable impact
> on execve itself (maybe a 0.5% reduction, which I consider to be in the
> measurement noise), but a 5.5% reduction in the performance of fork()+exit()
> - this is using __cpuc_coherent_kern_range() in
> v6_copy_user_highpage_nonaliasing() to ensure the new page is fully
> coherent.

Thanks for running these benchmarks. The results on both your and my 
patch are affected by invalidating the whole I-cache in 
v6_coherent_user_range() rather than doing it by line (that's historical 
because of some erratum on ARM1136 - maybe we should fix this).

Another thing that's affecting the performance of my patch as it 
currently is (and withtout changing generic code) - the D-cache flushing 
generates a fault in some situations which takes time to process. I can 
fix this by using the VAtoPA translation registers in the 
coherent_user_range function.

Anyway, I think it depends on the type of applications you are running. 
I personally don't see shell performance too important, so we may 
disagree on the best fix here.

For a web server (Apache) where you have plenty of forks, your patch 
might affect the performance quite a lot as you get many 
copy_user_highpage() calls for CoW (BTW, unrelated to this issue, 
www.linux-arm.org, including the Git server, is hosted on a set of 
Marvell MV78100 boards - http://www.linux-arm.org/Main/LinuxArmOrg).

While we can choose benchmarks to show that either option is bad, we 
should probably try to get an optimal solution.

My view is that something similar to flush_dcache_page + 
update_mmu_cache would be better (though maybe not these functions 
directly but could try to reuse PG_arch_1).

> One thing I have noticed: it takes the Realview SMP board _two_ attempts
> to boot a kernel.  The first attempt tends to cause a spontaneous reboot
> when the CLCD controller is enabled, or possibly a hang.  The second
> attempt seems to always run fine.

I noticed this as well only on RealView EB but not all boards. The other 
SMP boards I have are fine. It could be a hardware bug, I don't see 
anything obvious in Linux.

-- 
Catalin

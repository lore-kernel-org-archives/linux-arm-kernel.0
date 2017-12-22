From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Dec 2017 11:02:04 +0100
Subject: [PATCH 0/3] Add DVFS support on CPU clock for Armada 37xx
In-Reply-To: <20171221231341.GC7997@codeaurora.org> (Stephen Boyd's message of
 "Thu, 21 Dec 2017 15:13:41 -0800")
References: <20171130134029.20751-1-gregory.clement@free-electrons.com>
 <20171221231341.GC7997@codeaurora.org>
Message-ID: <87shc3dqsj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
 
 On jeu., d?c. 21 2017, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 11/30, Gregory CLEMENT wrote:
>> Hi,
>> 
>> This small series is needed to use DVFS on Armada 37xx. When DVFS is
>> enabled the CPU clock setting is done using an other set of registers
>> from the North Bridge Power Management block.
>> 
>> The series adds the possibility to modify the CPU frequency using the
>> associate load level matching the target frequency. However
>> configuring the frequencies for each load is done by the cpufreq
>> driver submitted in a separate series.
>> 
>> Obviously having both series (cpufreq and clk) is needed to support
>> DVFS on Armada 37xx, but there is no dependencies between the series
>> (for building or at runtime).
>> 
>
> Are you relying on the clk API returning an error to detect if
> DVFS is present or not? Just curious why that part of the code
> was there.

The cpufreq framework rely on the clk framwork to setup the clk
frequency of the CPU. For this hardware when DVFS is enabled the we
don't directly control the frequency of the CPUs but the "load
level". And it is during the initialization that we associate CPU
frequency to a load level.

The clk part is there to setup this load level for the hardware but by
still using the frequency as an entry point as it was what is expected
by the kernel. So cpufreq will ask a frequency depending of its policy,
then the clk driver will setup the load level matching this frequency.

And to answer your specific question we don't rely on the clk API
returning an error to detect if DVFS is present or not. For this we
directly read the DVFS bit exposed through the syscon.

Gregory

>
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

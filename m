From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 15 Jun 2017 09:22:46 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <d9b1121b-6e04-dfe7-b75b-9fbc6129a907@arm.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
 <20170614062229.GA28496@leoy-ThinkPad-T440>
 <20170614223453.3357117a7f25ee68924a071c@arm.com>
 <d9b1121b-6e04-dfe7-b75b-9fbc6129a907@arm.com>
Message-ID: <20170615092246.bc4fb71637e482a118199864@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jun 2017 09:41:22 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> On 15/06/17 04:34, Kim Phillips wrote:
> [...]
> > How does one tell whether writes to /dev/cpu_dma_latency are effective?
> > 
> Watch /sys/devices/system/cpu/cpu*/cpuidle/state*/{usage,time}, they
> shouldn't tick based on the value set to cpu_dma_latency.
> 
> E.g. a value of 0 should stop entering all the idle states.

I see all states following the same pattern whether 0 or not:

root at juno:~# cat show2.sh 
show()
{
	echo $1 > /dev/cpu_dma_latency
	echo === $1:
	cat /sys/devices/system/cpu/cpu2/cpuidle/state*/{usage,time}
	echo ---
	sleep 10
	cat /sys/devices/system/cpu/cpu2/cpuidle/state*/{usage,time}
}

show 0
show 1500
show 0
root at juno:~# taskset -c 2 bash ./show2.sh
=== 0:
1893
894
5417
1398675
65997648
3818880750
---
1895
905
5434
1401721
68076867
3826795502
=== 1500:
1895
905
5434
1401721
68076867
3826795502
---
1895
918
5447
1401721
69403510
3835466081
=== 0:
1895
918
5447
1401721
69403510
3835466081
---
1896
929
5463
1403577
71454839
3843409979

googling suggests the /dev/cpu_dma_latency file should be *kept* open,
and written a 32-bit binary number:

https://access.redhat.com/articles/65410

If so (I don't have time to test), this cpu debug documentation is very
deceptive.

Kim

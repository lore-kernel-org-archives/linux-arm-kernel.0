From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 11 Nov 2018 15:08:53 +0200
Subject: [bug report] armada-8040-mcbin: 4.20-rc1 boot failure
In-Reply-To: <20181109121112.xibwnc354wzsbovl@bars>
References: <20181109121112.xibwnc354wzsbovl@bars>
Message-ID: <877ehj7od6.fsf@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey, Gregory,

Sergey Matyukevich writes:
> MacchiatoBin board fails to boot v4.20-rc1 kernel built using arm64
> defconfig. According to quick bisection of the board dts file, the
> root cause is in dts patch enabling CPU deep idle states:
> see 8ed46368776b3bc. Is there any pending fix other than reverting
> deep idle state support ?

I reproduced the same boot failure on the Armada 8K based Clearfog
GT-8K. Revert of commit 8ed46368776b3bc on top of v4.20-rc1 makes the
system boot again.

Here is the splat I get:

[   87.358425] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   87.364556] rcu: 	3-...!: (1 ticks this GP) idle=d04/0/0x0 softirq=79/79 fqs=1
[   87.371897] rcu: 	(detected by 2, t=21490 jiffies, g=-1035, q=179)
[   87.378106] Task dump for CPU 3:
[   87.381347] swapper/3       R  running task        0     0      1 0x00000028
[   87.388428] Call trace:
[   87.390892]  __switch_to+0x78/0xb4
[   87.394310]  arm_enter_idle_state+0x38/0x4c
[   87.398512]  cpuidle_enter_state+0xc8/0x15c
[   87.402713]  cpuidle_enter+0x18/0x20
[   87.406304]  call_cpuidle+0x30/0x34
[   87.409807]  do_idle+0x19c/0x224
[   87.413048]  cpu_startup_entry+0x20/0x24
[   87.416988]  secondary_start_kernel+0x158/0x168

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

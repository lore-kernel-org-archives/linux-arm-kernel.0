From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 15:39:45 -0800
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <20170117232314.GI27312@n2100.armlinux.org.uk>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170117232314.GI27312@n2100.armlinux.org.uk>
Message-ID: <fd4a4f48-f19e-dcac-c286-8e03db89e99a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 03:23 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 17, 2017 at 03:07:12PM -0800, Florian Fainelli wrote:
>> This message is not particularly informative, and is not paired with an
>> identical message when a CPU is brought online. Finally, it slows the
>> CPU hotplug path down, thus allowing less CPU hotplug operations per
>> second. Just remove it.
> 
> CPU hotplug isn't a fast operation anyway - it's also fairly disruptive
> in that it uses stop_machine() to halt activity everywhere while taking
> the CPU offline.

We have a test that consists in shutting down all CPUs as frequently as
we can and do this for about 2 million iterations which takes roughly
24h, and this printk slows thing down by a reasonable amount. Here are
some numbers on 500 hotplug operations:

w/ printk:
real    0m9.997s
user    0m0.725s
sys     0m3.030s
#

w/o printk:
real    0m8.547s
user    0m0.436s
sys     0m1.838s

> 
> If you're worried about a single printk slowing things down, it sounds
> like you're doing something wrong here - maybe you should be using
> cpuidle for power management rather than trying to make CPU hotplug do
> that for you?

No, this is not about power management considerations here, just how
fast we can bang it.

> 
> A rapidly changing CPU hotplug state has other side effects - such as
> reading /proc/interrupts is meaningless, because as soon as you've read
> it the CPUs could have changed.  It also makes a farce of spreading
> interrupts over the available CPUs.
> 
> All in all, I don't think this is a good idea...

Well, for one it's inconsistent, and it also leaves room for subtle
timing/caching issues with some platforms (OK, maybe not so much).
Improving the speed and consistency was the primary motive.
-- 
Florian

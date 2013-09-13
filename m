From: cinifr@gmail.com (cinifr)
Date: Fri, 13 Sep 2013 16:49:46 +0800
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <5231EE43.5090900@arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
 <5231EE43.5090900@arm.com>
Message-ID: <CAK3cCBzr8_LTYarZDgPYZY7_-5Qco_Qw+ACi=c2uOrn7MqwkBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 00:39, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 12/09/13 17:07, cinifr wrote:
>>> This cannot be a compile-time option as above in a multiplatform build.
>>> Other paltforms (e.g. KVM guests) *must* use the virtual counters to get
>>> any semblance of a consistent view of time.
>> Yes I accept compile-time option is not perfect  in my pre email,
>> But,Why Ohter paltforms *must* use the virtual counters? I think KVM
>> should not limit how to use arch timer in its guest OS. Of cause, if
>> KVM guest use vct can be more efficiency then that use pct. but KVM
>> should and must support guest OS to access pct.
>
> The virtual counter is there for a good reason: it allows a virtual
> machine to:
> - see its time starting at zero
> - be migrated to another host without seeing time shifting one way or
> another.
>
> So using the physical counter in a VM is a recipe for disaster if you're
> doing any kind of time tracking. The counter being used for
> sched_clock(), we cannot afford to see it being shifted one way or another.
I accept that virtual count is better in VM than physical counter
because hypversion can modify VM timer by set   CNTVOFF. But I think
hypversior should support that VM should can access physical counter,
When VM use physical count.  hypversior could trap accessing physical
count from guest OS, and return a value that guest OS want liking
hypervisor set CNTVOFF  for virtual counter. On this way, VM could too
see its timer at zero and VM could  too be migrated to another host
without seeing time shifting.

> If you have issues with the use of the virtual counter, I suggest you
> fix your firmware to have a consistent CNTVOFF across CPUs. And/or even
> better, boot your kernel in HYP mode, as it will take care of setting
> CNTVOFF to zero.
>
I am   wondering   what is the principle between kernel and bootload?
What should be done in bootloader and what should be done in kernel?
As you said, If kernel boot from hyp,  Kernel can set  CNTVOFF to zero
directly, does we add the code to set CNTVOFF in kernel?  But, if
kernel boot from PL1 NS=0,  Does kernel  need to switch hyp mode to
set  CNTVOFF and return  PL1 NS=0 mode? Or,kernel dont care it because
kernel   believe bootloader have set CNTVOFF  before?
Thanks,
           Fan.

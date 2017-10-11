From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 17:10:11 +0100
Subject: [RFC 0/7] arm64: provide pseudo NMI with GICv3
In-Reply-To: <CAMTL27FYM=oiNjh1JoXPMx6eTLJZXYm8QPb4QcQe-wgWpeEaBA@mail.gmail.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
 <CAMTL27FYM=oiNjh1JoXPMx6eTLJZXYm8QPb4QcQe-wgWpeEaBA@mail.gmail.com>
Message-ID: <9dde96d6-a430-8d63-4f99-e9453ab2e12c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/10/17 16:55, Daniel Thompson wrote:
> On 11 October 2017 at 14:00, Julien Thierry <julien.thierry@arm.com> wrote:
>> Hi,
>>
>> This series is a continuation of the work started by Daniel [1]. The goal is
>> to use GICv3 interrupt priorities to simulate an NMI.
> 
> Cool. By coincidence, and after ignoring the code for three kernel
> releases, I'm halfway through rebasing this to v4.14... and *very*
> happy to be able to grab yours instead. There's a machine I want to
> play with it on!
> 

Good to know someone will be testing this then ;) , thanks.

> Have you just brought it up to date or have you acted on Marc Z.'s
> pending feedback from the last circulation?
> 

First 3 patches should be pretty much identical. I've done a bit of 
rework on patch 4, acting on some of Marc's comments, fixing some issues 
I found along the road, some refactoring.

Then I added code to the GICv3 irqchip so you can turn an irq as NMI 
like so:
irq_set_irqchip_state(virq, IRQCHIP_STATE_NMI, true);

So this means you need to do it through a virtual irq number (e.g. no 
IPI). I started working on some patches to make it work with IPI as 
well, but I wanted to get some feeback on this first before finalizing them.

> 
>> To achieve this, set two priorities, one for standard interrupts and
>> another, higher priority, for NMIs. Whenever we want to disable interrupts,
>> we mask the standard priority instead so NMIs can still be raised. Some
>> corner cases though still require to actually mask all interrupts
>> effectively disabling the NMI.
>>
>> Of course, using priority masking instead of PSR.I comes at some cost. On
>> hackbench, I notice a ~6% drop of performance. However, on a kernel build,
>> I do not see significant differences.
> 
> Which micro-architecture?
> 

8 cores A57.

> In micro-benchmarks (with hot caches) I've seen the lock sequence
> speed up on some designs, slow down a bit on some and slow down a
> *lot* others. In the worst cases the code impacts Android macro
> benchmarks like scrolling... on the other hand the code was stable
> enough to run the whole Android stack reliably.
> 

So far I only tested with classic Linux distros, so if you find issues 
with Android (or other) do let me know.

Same if you have any question about the changes.

Thanks,

-- 
Julien Thierry

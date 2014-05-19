From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 May 2014 11:53:57 -0500
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140519113109.07264028@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqJy=dYpVFbgjGVRHrgwfaB7dkJVGazpfjf9qf7Z9poJuw@mail.gmail.com>
 <20140515120152.7b0beb37@free-electrons.com>
 <CAL_JsqKO5j-rTQVwo9AJA=WYF_oSfdvbM-LjF7QNox3SPGuAkg@mail.gmail.com>
 <20140519113109.07264028@free-electrons.com>
Message-ID: <CAL_JsqLE2xD_jnKph+4J-EA=2g2MYTPg9jefie6Zd9w3G5s27g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 4:31 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Rob Herring,
>
> On Thu, 15 May 2014 09:44:11 -0500, Rob Herring wrote:
>

>> > See above. It's not only about having issues to get the vendor to fix
>> > the firmware. It's also about:
>> >
>> >  * Having a consistent strategy with regard to what the kernel does and
>> >    what the bootloader does. Why would the kernel set the SMP and TLB
>> >    broadcast bit when CONFIG_SMP is set and the processor is SMP, but
>> >    not when CONFIG_SMP is disabled and the system is I/O coherent?
>>
>> It is not that simple. The SMP bit has different meanings depending on
>> the core, but is more related to cache usage than running multi-core
>> or not. On the A15 for example, IIRC, the SMP bit basically means
>> disable cache lookups while the C bit only means disable cache
>> allocations (i.e. cache hits can occur with the "cache disabled").
>
> Hum, right, and?

My only point is the function of the bit is not entirely consistent
from core to core and the kernel may not know the right thing to do.
The only consistent policy is to make it a bootloader problem. An A15
and A7 should always enable it because otherwise you are running with
caches disabled and the A15/A7 don't really support AMP operation. An
A9 may depend on the AMP usage of the cores for how to set the SMP
bit. I think the kernel can only set the SMP bit when CONFIG_SMP is
enabled and otherwise it must leave it to the bootloader to do.

Some examples:

A15/A7 - always set by bootloader
A9 SMP - only set by bootloader if AMP is never used, otherwise set by kernel
A9 AMP - cleared/untouched by bootloader, untouched by kernel

Then there's other cores I'm not familiar with. If they are not used
for AMP, then it should be easy decision for the bootloader to setup.

This raises another question of how you configure AMP setup. Perhaps
not a problem we want to solve here.

>> >  * User support issues. Having gazillions of bootloader updates every
>> >    time a piece of configuration settings is rejected by the kernel
>> >    maintainers is going to be a nightmare for users.
>>
>> It's an artifact of trying to upstream the kernel after shipping
>> rather than before. If these issues were fixed in the bootloader at
>> the same time as someone decided to just hack up the vendor kernel,
>> then probably none of us would even know about the issue.
>
> Sorry, but that just doesn't work. The time it takes to mainline things
> is *way* longer than the time it takes for the SoC vendor to start
> providing early SoC releases and development boards with bootloaders to
> customers. There will also be some bootloader pushed out to customers
> before the code is mainlined in Linux.

It can work and is possible because I did it at Calxeda and Intel does
it. Highbank support went upstream 6-9 months before Si and boards
arrived. It did require some changes after Si, but those were small
and most changes were in the firmware side. It does require a certain
mindset for the company to drive the planning and needs software
influence over the h/w design. It is not something easy to accomplish
especially when you get behind working on the previous generation that
you can't start early on the next gen. While your ELC presentation
showed things are improving with Marvell upstreaming (which is great
to see), I'd argue the 6 month embargo you had is still a problem.

Intel gets new platform support upstream before details are publicly
announced and chips are available beyond OEMs. You can argue Intel
platforms are a lot different, but that doesn't matter because that is
who the ARM vendors are competing against.

>> As long as upstream is not a requirement, you are not in a position
>> you can win.
>
> Have you seen the number of patches we have sent over the last two
> years for these platforms? You must have missed them, or otherwise I
> don't understand how you manage to conclude that upstream is not a
> requirement.

Sorry, I should say a requirement for production (by customers) and
for distribution kernel support. Obviously, that was not a requirement
if you look at the Marvell kernel for ubuntu. But that was a few years
back before you really started. Maybe things are changing.

>> You can never keep up with someone that has the freedom
>> to just go and change whatever they want without having to deal with
>> those annoying kernel maintainers. You fix these issues, there will
>> just be other reasons why mainline is not usable (Do they still have
>> the random one line deletion of a goto statement in the scheduler).
>>
>> Speaking from experience rebasing i.MX vendor kernels, nothing
>> upstream is easier to update than partially upstream if you try to
>> build upon what is upstream. Generally speaking, vendors don't care
>> what their delta against upstream is any more than they care about
>> upstream being production quality.
>>
>> Obviously, Marvell does care about mainline to some extent or I
>> wouldn't be talking to you. But how do we get them to care enough to
>> make mainline production quality? Part of the problem is we have
>> distro's willing to take your money and vendor kernel (they are also
>> willing to take your money and upstream kernel as well).
>
> Could you be more specific about what Marvell isn't doing today to be
> mainline production ready? As I said, we've been working hard since two
> years to push to mainline the support for their SoCs. Our patches can
> certainly be criticized, but the end result is clear: their Armada 370,
> XP and now 375/38x platforms are quite well supported in mainline. And
> since the patches have been merged, they surely have matched the
> mainline kernel quality requirements, no?

Obviously, what is mainlined matches mainline kernel quality
requirements and you all are doing a great job there. My guess is that
the vendor kernel is still used because of performance reasons (like
coherent i/o) and feature gaps. Is the vendor BSP really shrinking
over time and is what remains becoming more inline with what is
acceptable for mainline (i.e. no HAL layer)?

Rob

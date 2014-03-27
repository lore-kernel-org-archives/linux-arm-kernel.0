From: elder@linaro.org (Alex Elder)
Date: Thu, 27 Mar 2014 14:08:44 -0500
Subject: mach-spear SMP questions
In-Reply-To: <20140327171914.GE7528@n2100.arm.linux.org.uk>
References: <533428B2.2050906@linaro.org>
 <20140327143933.GD7528@n2100.arm.linux.org.uk> <5334584C.1090708@linaro.org>
 <20140327171914.GE7528@n2100.arm.linux.org.uk>
Message-ID: <5334773C.3020908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2014 12:19 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 27, 2014 at 11:56:44AM -0500, Alex Elder wrote:
>> On 03/27/2014 09:39 AM, Russell King - ARM Linux wrote:
>>> On Thu, Mar 27, 2014 at 08:33:38AM -0500, Alex Elder wrote:
>>>> I'm doing some code cleanup and have a question about
>>>> something related to SMP in mach-spear.  Can anyone
>>>> help me with these questions?
>>>
>>> I think you're working in a similar area to that which I have been - but
>>> with different ends in mind.  Have a look for my L2 cache series on LAKML.
>>
>> By "different ends in mind," do you mean conflicting
>> goals, or simply for different reasons?
> 
> Hmm, "L2 cache series" doesn't suggest anything?  The L2 cache series is...
> a series cleaning up the L2 cache code, which includes removing incorrect
> uses of outer_flush_all().

I merely wanted to be clarify your meaning.

> Merely removing that call would likely break Spear, so it had to be fixed
> properly.
> 
>>>> My question has to do with how secondary cores start for
>>>> SMP.  Most machines need to send a wakeup event from the
>>>> boot core to each secondary core as it is told to start.
>>>> But mach-spear does not do this.  I'd like to know if this
>>>> is an oversight, or confirm that this is simply not necessary
>>>> for this machine.
>>>
>>> It could be that the "BootMonitor" waits for spear13xx_smp_prepare_cpus()
>>> to write the address of the function to jump to into SYS_LOCATION - I can't
>>> see any other way this code would work (there's nothing else there to tell
>>> the secondary CPUs where to start executing from or when to start executing
>>> from that point.)
>>
>> That could be.
>>
>> My next question is whether sending a wakeup event would
>> be *harmful*.  If it's not, this machine can use the
>> common pen-release code I'm consolidating things to use.
> 
> I've seen this attempt many times before... you're not the first.
> Somehow, saying "no" to something never sticks.  It just postpones it
> until someone else thinks it's a good idea and tries the same thing
> again. :(

Maybe this time will be better?  :)

>>>> Also, while most machines touch a memory location and then
>>>> do a targeted cache involving only that location, mach-spear
>>>> does a full flush.  Is the full flush really required for
>>>> some reason?
>>>
>>> It's not required.  As part of the L2 cache cleanup, I have this
>>> change:
>>
>> That's perfect.  Just like all other implementations
>> (so I can factor it out).  Now I just need to know
>> whether I can use the shared the smp_boot_secondary
>> method.
> 
> People keep trying to do this, and I keep saying no to it because (as I
> keep stating each time this comes up) the majority of implementations
> haven't /thought/ about their hotplug implementations at all, and have
> just gone down the path of "let's copy-n-paste the first solution we
> find" which has historically been that used on the ARM Realview
> platform.

It looks that way to me.  But how do you stop people from
spreading the copy/paste disease if there's no obvious
alternative--or if it appears that it's what "everybody
does?"

What I really am trying to do is get to the point where we
can specify an "enable-method" in the device tree.  To do
that I looked at how these various platforms were starting
their secondary cores and they're almost all the same "pen"
method.  And obvious first step is to factor out the common
code.

> The problem with that is the ARM Realview is a really dumb piece of
> hardware: it has no control over the secondary CPUs.  When it powers
> up, all CPUs come out of reset simultaneously, and enter the boot
> monitor.

> The boot monitor then holds the secondary CPUs itself, allowing the
> boot CPU to run the rest of the boot monitor code, eventually falling
> through to the boot loader and ultimately to Linux.
> 
> Linux then sets the address of the CPU holding pen code, and pokes the
> boot monitor to release the secondary CPUs to that holding place - it
> results in all three secondary CPUs ending up there simultaneously.
> The holding pen's purpose is to hold the CPUs there while Linux
> continues the boot process to the point of requesting each CPU
> individually to come up.

Yes, that's exactly how it works.

> The secondary function of the pen release code is to deal with hotplug
> on this platform: once a secondary CPU is released into the kernel code,
> there is no way to take it back out of the kernel.  So, the CPU hotplug
> code has to "fake" taking a CPU offline.  It does this by taking the
> CPU out of coherency, and putting it into a low power state, waiting
> for an event to wake it back up.  That wakeup event is based upon the
> pen thing again selecting the appropriate CPU to "plug" back in.

At this point I have not been looking at its use in hotplug.

> This approach also has the problem that it is /not/ kexec friendly -
> since we can't get rid of the secondary CPUs, a kexec'd kernel ends up
> simply overwriting the code that the secondary CPUs happened to be
> executing at the time, probably crashing them.  In any case, the
> secondary CPUs will not come back up after a kexec since they'll probably
> have crashed.

Why is this even used then?  (Sorry, like I said, I've been
looking at SMP startup only.)

> In the case of a system where the secondary CPUs can be held in reset
> independently of the boot CPU, that hardware should be used when bringing
> up or taking down a secondary CPU.  If you have that facility, then there
> is absolutely no reason to use the "pen" stuff.

And what if there is no such facility?

> I consider any platform which copies the Realview SMP code to be broken
> by definition.  I do not wish this code to be turned into some kind of
> generic helper, because by doing so, we're endorsing it as a proper way
> to do something.  It is *not* a proper way to implement this.  It's the
> implementation used by ARM Ltd's platforms for the sole reason that this
> hardware has no form of controls on the secondary CPUs what so ever.

I have no ability to change how these machines control their
secondary CPUs.  Nor do I have knowledge of whether they
have the ability to independently hold secondary cores in
reset.  Even if they did, I don't have the information I'd
require to implement such a thing so they do it the right
way.

What I *can* do is identify a half dozen essentially identical
implementations of code littering the code base and consolidate
them into a single implementation.  In doing so I will not change
their behavior at all (unpleasant as it may be), but I will
improve the code overall.  It will make it transparent that
these are in fact all doing the same thing, and I hope it will
lead to it becoming easier to implement SMP startup in a better
way for all implementations if/when there is such a thing.
As I said above, my broader aim is to support a device-tree
specified way of booting secondary cores, and in doing so
I'm trying to be consistent with how it's being done for ARM64.

I'm not endorsing this way of starting secondary cores.  But
looking at all these similar (but not quite identical) blocks
of code makes it harder than it should be to get a handle on
what's going on, and suggests that maybe they *must* all
have custom implementations.

I understand your point that having a common set of
functions implies an endorsement of that way of doing
things.  But I'd argue that everyone using a shared
implementation (even if it's the wrong way) is better
than everyone *copying* the same implementation.  People
can be pressured at review time to do it differently if
there is a better way available.

I think everyone knows that duplicated code is bad, and
that's why I'm not the first one to set out to do this.
I'm about half done and I find that it adds about 120
new lines of common code but removes 340 lines that were
duplicated (including 5 files completely going away).
All of this duplicated code is under the arch/arm/mach-*
directories, by the way, so this helps the goal of
doing away with that stuff as well.

Even if "everybody is doing it wrong," I feel pretty
strongly that the net effect of consolidating is positive.

I hope you'll reconsider your "no."  I'll have the patches
available soon (to allow an objective look at the outcome).

					-Alex

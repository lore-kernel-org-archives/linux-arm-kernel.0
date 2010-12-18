From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 18 Dec 2010 06:10:49 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101218120154.GA4803@n2100.arm.linux.org.uk>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
	<AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
	<20101218120154.GA4803@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 6:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Dec 18, 2010 at 01:17:34AM -0600, Andrei Warkentin wrote:
>> I do want to bring to your attention something I found while making
>> the patch I mailed here. It's that
>> secondary_startup (along with MMU-enabling friends) are located in the
>> .init.text section and get nuked after
>> startup. Which means that the secondary startup right now can't be
>> done without moving this code out of .init.text.
>> Moving that stuff is kind of iffy too, because it's used immediately
>> in head.S. I didn't try very hard :) (and it didn't work, but that's
>> my fault). Now I have a good reason to try again :).
>
> I have a series of 10 patches which does that, posted previously to this
> mailing list on 4th October which addresses that.
>
> There's another series of 22 patches which clean up the SMP support which
> you also probably aren't aware of (Daniel Walker is though.) ?That now
> has the VFP and pen_release fixes I just posted added to it, and it's
> also going to make the failure-to-online message a little more verbose
> as to why the failure happened.
>
>> >> >> ? ? ? /* return happens from __cortex_a9_restore */
>> >> >> ? ? ? barrier();
>> >> >> ? ? ? writel(smp_processor_id(), EVP_CPU_RESET_VECTOR);
>> >> >
>> >> > And here, if the CPU is not _immediately_ stopped, it will return and
>> >> > restart the bring-up. ?If you are using hardware to reset the CPU (which
>> >> > it seems you are), you should ensure that this function never returns.
>> >> > You may also wish to add a pr_crit() here to indicate when this failure
>> >> > happens.
>> >> >
>> >>
>> >> It is immediately stopped. Turned off really. But this is where it
>> >> will resume on when it gets brought back up (__cortex_a9_restore takes
>> >> care of that)
>> >
>>
>> But this is a writel to memory. And CONFIG_ARM_DMA_MEM_BUFFERABLE is
>> defined, so there is a __wmb() after the write, and in our case
>> #define wmb() ? ? ? ? ? do { dsb(); outer_sync(); } while (0)
>>
>> The dsb will flush the write buffer, unless I misunderstand.
>
> writel() is defined as follows:
>
> #define writel(v,c) ? ? ? ? ? ? ({ __iowmb(); writel_relaxed(v,c); })
>
> Notice that the wmb barrier is performed before the actual write to device,
> not after it. ?That is to ensure that if this device write is telling
> something to start DMA, any previous writes to DMA coherent memory (eg,
> for ring descriptors) will be visible to the DMA agent.
>

...and in that last case there are no writels following the write of
SMP id to reset vector. Oops :/.

> There are no ordering guarantees between the device write vs accesses
> after the writel().
>
>> Keep in mind that this is not why we were seeing that failure. If it
>> failed here, secondary_boot spinning on this value wouldn't have
>> succeeded, and it wouldn't even try spinning with a timeout on the
>> cpu_online bit. And while I agree with you that the hotplug code code
>> be severely less byzantine (and help everybody all the other mach SMP
>> efforts in a generic fashion), it's not the problem either - it works
>> - boot_secondary returns success and cpu_up enters the timeout wait
>> for the online bit.
>
> Well, the code has issues as it currently stands, and I'd like to see
> some of those issues resolved first, and then re-checking where we stand
> with this.
>
>> I debugged through what was happening, and boot_secondary was
>> succeeding (this means that the secondary IS now about to jump to
>> secondary_start_kernel).
>
> I assume you are aware that your boot_secondary() _always_ succeeds, even
> if this times out?
>
> ? ? ? ?timeout = jiffies + HZ;
> ? ? ? ?while (time_before(jiffies, timeout)) {
> ? ? ? ? ? ? ? ?if (readl(EVP_CPU_RESET_VECTOR) != boot_vector)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ?udelay(10);
> ? ? ? ?}
> ...
> ? ? ? ?spin_unlock(&boot_lock);
>
> ? ? ? ?return 0;
>
> It would be good if you fixed that and re-tested - what could be
> happening is exactly the same thing you're accusing the generic code
> of doing:
>
> ? ? ? ?CPU0 ? ? ? ? ? ? ? ? ? ?CPU1
> ? ? ? ?writes RESET_VECTOR
> ? ? ? ?prods CPU
> ? ? ? ?starts wait
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?cpu starts slowly
> ? ? ? ?times out
> ? ? ? ?restores RESET_VECTOR
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?writes RESET_VECTOR
> ? ? ? ?returns success
> ? ? ? ?starts wait for CPU online
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?...
> ? ? ? ?times out
> ? ? ? ?returns -EIO
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?cpu comes online
>
> You'll never know if your reset vector has been corrupted in this way
> because you always return success.

Gah, that's terrible...how could I have missed this... I'll go put the
foot back in my mouth :).

>
>> But the wait to set the online bit timed out.
>> Not by much (judging from kernel messages), but timed out. Now, this
>> was on a IO/memory/compute overloaded system, this isn't supposed to
>> happen in real life, but it happened, and it's not helping our stress
>> tests ;-). Basically there is no safe guards to prevent something like
>> this from happening, hence the patch.
>
> We assume in __cpu_up() is that if boot_secondary() returns success, the
> CPU is well on its way to coming online - iow, platform_secondary_init()
> has been reached, and we have relatively little stuff to do before we see
> the CPU coming online.
>
> I can't see that your code allows that assumption to be made, as
> boot_secondary() always returns success.
>
> Maybe you need your wait-for-reset-vector to be longer, and on failure
> place the CPU back into reset to ensure that it doesn't corrupt the
> reset vector if it starts late?
>

Definitely. This would be exactly the right place to place any holding logic...

Thanks again,
A

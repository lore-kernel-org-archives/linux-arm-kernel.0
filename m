From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 16:22:29 +0900
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <201306061917.52550.arnd@arndb.de>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <20130605192019.GG18614@n2100.arm.linux.org.uk>
 <CANqRtoRXDpdzTxJAZRe1cAVg0sPj8UuVfkR_bFUY-sKe7gnHUg@mail.gmail.com>
 <201306061917.52550.arnd@arndb.de>
Message-ID: <CANqRtoSKAm_9VXus=zzer2ELrS2NmZ=znZCSJH65imTXGk5ong@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jun 7, 2013 at 2:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 06 June 2013, Magnus Damm wrote:
>> Thanks for your comments. As you probably saw in patch 00/06, the goal
>> with this series is to remove CONFIG_MEMORY_START/SIZE from
>> mach-shmobile.
>>
>> I myself am quite happy to keep on using the kernel configuration to
>> describe the main memory window like today, this is exactly how we
>> used to do it on SH as well. What is a bit difficult is that we for
>> mach-shmobile are requested to consolidate the kernel configurations
>> and move to CONFIG_MULTIPLATFORM.
>>
>> My main concern is that I'd like to keep per-board memory
>> configuration somewhere, just removing it seems like a regression in
>> usefulness to me. Do you have any recommendation for me how to
>> proceed?
>
> Actually I think with an appended DTB file, you should be able to
> pass the correct memory configuration per board just like everyone
> else, even when booting directly from mask ROM. I understand that
> you still have a long way to go before you can go DT-only for all
> shmobile SoCs, so what we need is a way to bridge the mid-term
> where you want to support that boot method on SoCs with incomplete
> or missing DT support.

The only two boards where we today boot from the reset vector and
actually need to provide this information to the kernel are Mackerel
and AP4EVB.

My approach with this series was more to make sure all boards keep on
working regardless what their boot loader pass. This since I too do
not trust the boot loader - especially on older boards. Perhaps the
more acceptable approach is to pretend to start trusting the
information by the boot loader and deal with the fallout if that
happens. Things may break when removing CONFIG_MEMORY_START/SIZE since
the MEM_SIZE and PHYS_OFFSET change in arch/arm/kernel/atags_parse.c

Anyway I can update my romImage series so it uses appended DTB with
both AP4EVB and Mackerel. Then this series can simply be thrown away.

> The easiest way is probably to declare that multiplatform booting
> on shmobile is only supported for DT-enabled boards and that support
> for non-DT booting will be removed at the same time as
> non-multiplatform booting on shmobile. This is the same thing we are
> doing e.g. on Exynos and the various Marvell embedded (non-PXA/MMP)
> chips.  The time line for this not set yet, and I think that will
> be one of the hot topics at this year's ARM subarch maintainer summit
> that I hope we will have the chance to do during the kernel summit.
> FWIW, my take on this is that at some point we will require both DT
> and multiplatform for all ARMv6 and ARMv7 platforms anyway (not
> for the older ones, in particular StrongARM and XScale), but we have
> to come up with a timing that works for everyone.

Yeah, I agree with your idea but I wonder about the timing. Actually,
I was thinking that the prime candidate boards for multiplatform are
our DT -reference boards. Still blocked on common clock framework
though... I will try to sort out the memory bits first.

Thanks,

/ magnus

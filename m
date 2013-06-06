From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 19:17:52 +0200
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <CANqRtoRXDpdzTxJAZRe1cAVg0sPj8UuVfkR_bFUY-sKe7gnHUg@mail.gmail.com>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <20130605192019.GG18614@n2100.arm.linux.org.uk>
 <CANqRtoRXDpdzTxJAZRe1cAVg0sPj8UuVfkR_bFUY-sKe7gnHUg@mail.gmail.com>
Message-ID: <201306061917.52550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Magnus Damm wrote:
> Thanks for your comments. As you probably saw in patch 00/06, the goal
> with this series is to remove CONFIG_MEMORY_START/SIZE from
> mach-shmobile.
> 
> I myself am quite happy to keep on using the kernel configuration to
> describe the main memory window like today, this is exactly how we
> used to do it on SH as well. What is a bit difficult is that we for
> mach-shmobile are requested to consolidate the kernel configurations
> and move to CONFIG_MULTIPLATFORM.
> 
> My main concern is that I'd like to keep per-board memory
> configuration somewhere, just removing it seems like a regression in
> usefulness to me. Do you have any recommendation for me how to
> proceed?

Actually I think with an appended DTB file, you should be able to
pass the correct memory configuration per board just like everyone
else, even when booting directly from mask ROM. I understand that
you still have a long way to go before you can go DT-only for all
shmobile SoCs, so what we need is a way to bridge the mid-term
where you want to support that boot method on SoCs with incomplete
or missing DT support.

The easiest way is probably to declare that multiplatform booting
on shmobile is only supported for DT-enabled boards and that support
for non-DT booting will be removed at the same time as
non-multiplatform booting on shmobile. This is the same thing we are
doing e.g. on Exynos and the various Marvell embedded (non-PXA/MMP)
chips.  The time line for this not set yet, and I think that will
be one of the hot topics at this year's ARM subarch maintainer summit
that I hope we will have the chance to do during the kernel summit.
FWIW, my take on this is that at some point we will require both DT
and multiplatform for all ARMv6 and ARMv7 platforms anyway (not
for the older ones, in particular StrongARM and XScale), but we have
to come up with a timing that works for everyone.

	Arnd

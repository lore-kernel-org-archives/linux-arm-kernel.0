From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 29 Jan 2016 14:34:53 -0800
Subject: [PATCH v4 00/13] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1453977766-20907-1-git-send-email-james.morse@arm.com> (James
 Morse's message of "Thu, 28 Jan 2016 10:42:33 +0000")
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
Message-ID: <7hvb6chv5e.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

James Morse <james.morse@arm.com> writes:

> This version of hibernate is rebased onto v4.5-rc1, including updated patches
> shared with kexec v13 [0] (1-5, 10).

Thanks for this series!

I'd like to help in testing this so I'm just curious which platforms
you've been testing this on.  I'm assuming a Juno (r2?), anything else?

Are you testing the resume from cold boot, or just from kexec?

For cold boot on Juno, I'm assuming there would be some
booloader/firmware changes needed to find and boot from the hibernation
image?  Is that being worked on?  If not Juno, are you aware of any
other platforms that could be tested with resume from cold boot?

Not knowing the answers to the above, I tested your branch using arm64
defconfig + CONFIG_HIBERNATION=y on my Juno and noticed that it didn't
stay suspended (full suspend log below) so I'm looking for
ideas/recommenations on how to test this.

FWIW, my Juno is running the latest ATF + u-boot firmware from the
Linaro ARM landing team.

Kevin

/ # echo disk > /sys/power/state
[   29.563430] PM: Syncing filesystems ... done.
[   29.567901] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   29.576989] PM: Preallocating image memory... done (allocated 65512 pages)
[   31.969977] PM: Allocated 262048 kbytes in 2.38 seconds (110.10 MB/s)
[   31.976362] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   31.985303] Suspending console(s) (use no_console_suspend to debug)
[   31.992900] PM: freeze of devices complete after 1.370 msecs
[   31.993877] PM: late freeze of devices complete after 0.960 msecs
[   31.995109] PM: noirq freeze of devices complete after 1.225 msecs
[   31.995112] Disabling non-boot CPUs ...
[   32.012751] CPU1: shutdown
[   32.028584] psci: Retrying again to check for CPU kill
[   32.028587] psci: CPU1 killed.
[   32.060689] CPU2: shutdown
[   32.076579] psci: Retrying again to check for CPU kill
[   32.076583] psci: CPU2 killed.
[   32.108734] CPU3: shutdown
[   32.124579] psci: Retrying again to check for CPU kill
[   32.124582] psci: CPU3 killed.
[   32.160690] CPU4: shutdown
[   32.176578] psci: Retrying again to check for CPU kill
[   32.176581] psci: CPU4 killed.
[   32.212685] CPU5: shutdown
[   32.228580] psci: Retrying again to check for CPU kill
[   32.228584] psci: CPU5 killed.
[   32.241393] PM: Creating hibernation image:
[   32.241393] PM: Need to copy 63772 pages
[   32.241393] PM: Hibernation image created (63772 pages copied)
[   32.241440] Enabling non-boot CPUs ...
[   32.274634] Detected PIPT I-cache on CPU1
[   32.274680] CPU1: Booted secondary processor [410fd080]
[   32.274896]  cache: parent cpu1 should not be sleeping
[   32.275095] CPU1 is up
[   32.306712] Detected PIPT I-cache on CPU2
[   32.306738] CPU2: Booted secondary processor [410fd080]
[   32.306922]  cache: parent cpu2 should not be sleeping
[   32.307120] CPU2 is up
[   32.338913] Detected VIPT I-cache on CPU3
[   32.338959] CPU3: Booted secondary processor [410fd033]
[   32.339184]  cache: parent cpu3 should not be sleeping
[   32.339378] CPU3 is up
[   32.371098] Detected VIPT I-cache on CPU4
[   32.371125] CPU4: Booted secondary processor [410fd033]
[   32.371341]  cache: parent cpu4 should not be sleeping
[   32.371536] CPU4 is up
[   32.403281] Detected VIPT I-cache on CPU5
[   32.403309] CPU5: Booted secondary processor [410fd033]
[   32.403531]  cache: parent cpu5 should not be sleeping
[   32.403741] CPU5 is up
[   32.404202] PM: noirq thaw of devices complete after 0.454 msecs
[   32.404979] PM: early thaw of devices complete after 0.723 msecs
[...]

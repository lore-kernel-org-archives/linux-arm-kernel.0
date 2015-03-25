From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Mar 2015 19:46:16 +0100
Subject: "ARM: multi_v7_defconfig: Enable shmobile platforms" breaks
 Tegra20 multi_v7_defconfig boot
In-Reply-To: <CANMBJr7ibVCxQRUG47OT0meNntMjEoVqL7kiEK9DtCfp5NXPgg@mail.gmail.com>
References: <alpine.DEB.2.02.1503251740130.13341@utopia.booyaka.com>
 <CANMBJr7ibVCxQRUG47OT0meNntMjEoVqL7kiEK9DtCfp5NXPgg@mail.gmail.com>
Message-ID: <CAMuHMdWO9nqtpsvjUdE6KSbiOTfX=7XnzX1QXt06r3W4Et2rDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Tyler,

On Wed, Mar 25, 2015 at 7:28 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
> On 25 March 2015 at 11:03, Paul Walmsley <paul@pwsan.com> wrote:
>> Looks like commit 4a3a6f86693922b29cf829c63f652b057f14619e ("ARM:
>> multi_v7_defconfig: Enable shmobile platforms") breaks Tegra20
>> multi_v7_defconfig boot.
>>
>> Boot log before:
>>
>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105514_6af714b069dc278d5d8e1b7afc13568f71d9aba8/20150325105514/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt
>>
>> Boot log after:
>>
>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150325105350_4a3a6f86693922b29cf829c63f652b057f14619e/20150325105350/boot/tegra20-trimslice/tegra20-trimslice/multi_v7_defconfig_log.txt

So it just hangs when booting the kernel. Do you have any early debugging
support (earlycon, DEBUG_LL) for your kernel?

>> Any ideas?  Stephen Warren thinks there might be an initcall that might
>> not check to see what kind of device it's running on.

Always possible of course, but it didn't trigger on my boneblack.

> Can you try to shift your kernel load address around a bit? From
> experience with the boards from kernelci.org we find that as the multi
> v7 kernel size increases they can clobber memory when they get
> decompressed.

Kernel size can indeed be an issue. I believe the failure to boot on ape6evm
from U-Boot mentioned in the commit is caused by that, too.
Note that the error message only shows up with DEBUG_LL enabled (and
some manual editing of Kconfig.debug to make that work).

I'll try changing the kernel load address on ape6evm, too.

>> commit 4a3a6f86693922b29cf829c63f652b057f14619e
>> Author: Geert Uytterhoeven <geert+renesas@glider.be>
>> Date:   Tue Feb 24 15:14:45 2015 +0100
>>
>>     ARM: multi_v7_defconfig: Enable shmobile platforms
>>
>>     Enable support for shmobile platforms that became multi-platform aware.
>>     Several non-critical drivers and subsystems are built as modules, to keep
>>     kernel size reasonable.
>>
>>     Tested on:
>>       - r8a73a4/ape6evm:
>>           - U-Boot fails with "Error: unrecognized/unsupported machine ID",
>>           - kexec works.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

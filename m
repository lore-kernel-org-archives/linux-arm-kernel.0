From: pistol@cs.duke.edu (Valentin Pistol)
Date: Mon, 15 Oct 2012 16:48:40 -0400
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <20121009210802.GA31615@mudshark.cambridge.arm.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
 <20120918100438.GC32204@mudshark.cambridge.arm.com>
 <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
 <20121009210802.GA31615@mudshark.cambridge.arm.com>
Message-ID: <CAPfQmK+zLLR59FtuxdV82AhcoVV8tNTqGdL2bCh1Nn7YSpLHjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can you try this with my hw-breakpoint branch please? I've reworked a fair
> amount of code there, so it might at least be more verbose if it fails.

I am trying the Linaro 12.08 images from
http://releases.linaro.org/12.08/android/leb-panda/
After testing it boots fine on my board, I replaced the uImage with
one built from your code at
git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git and
hw-breakpoint branch.

Unfortunately it gets stuck on "Uncompressing Linux... done, booting
the kernel." on the serial port.
What kernel config are you using? I'm using omap2plus_defconfig
resulting in a Linux-3.7.0-rc1-00015-gd633d80b kernel:
$ make mrproper
$ make ARCH=arm CROSS_COMPILE=arm-eabi- omap2plus_defconfig uImage

I also tried using the Linaro 12.08 kernel config from the above page:
$ make mrproper
$ cp linaro_kernel_config .config
$ make ARCH=arm CROSS_COMPILE=arm-eabi- uImage
[ accept a lot of default values due to kernel version changes ]

Then I mount the SD card and replace the uImage file yet neither uImages boot.
Here is the full serial log: http://pastebin.com/raw.php?i=YQ4vk634

> In that discussion, the TI folks are confusing `Monitor-mode Debug' with
> `Secure Monitor Mode'. They are two completely different things and (for the
> purposes of this discussion), unrelated. You should press them further on
> this!

Thanks for the clarification, I contacted them again and will see how
it turns out.

>> Have you used a Pandaboard and can comment on how to enable the
>> breakpoints/watchpoints?
>
> I haven't tried it, but I do have a Panda now so I could give it a go when I
> get a chance. I suspect there's something related to power-management at
> play... for JTAG, you need to hack MLO as described here:
>
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka15314.html
>
> maybe something similar is required for self-hosted (monitor mode) debug?

If you could give it a try on your Panda that would be great!

On Fri, Oct 12, 2012 at 7:26 AM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
> I'm running Linaro 12.08 on Pandaboard (Rev A1) and on this board
> DBGAUTHSTATUS.NSNE and DBGAUTHSTATUS.NSE are set.
>
> With additional logs in enable_monitor_mode()
> [arch/arm/kernel/hw_breakpoint.c]:
>
> root at linaro-nano:~# dmesg | grep hw-break
> [    0.321380] hw-breakpoint: arch_hw_breakpoint_init cpu0 debug_arch=3
> [    0.321441] hw-breakpoint: enable_monitor_mode cpu1 DBGDSCR=03070002
> [    0.321441] hw-breakpoint: enable_monitor_mode cpu1
> DBGAUTHSTATUS=000000af
> [    0.321502] hw-breakpoint: enable_monitor_mode cpu0 DBGDSCR=03070002
> [    0.321533] hw-breakpoint: enable_monitor_mode cpu0
> DBGAUTHSTATUS=000000af
> [    0.321533] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> watchpoint registers.
> [    0.321563] hw-breakpoint: maximum watchpoint size is 4 bytes.

Dietmar,

That looks great! Did you flash the prebuilt images from Linaro 12.08
and replaced the kernel with those extra debug messages on top of
kernel at git://android.git.linaro.org/kernel/panda? Or are you using
Will's branch?
I am using a newer Pandaboard ES (Rev B1) and hope this is not the problem.
Could you please provide a few instructions to reproduce your setup?

Thanks!
Valentin

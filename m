From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 11:24:46 -0700
Subject: [PATCH 0/3] clk: bcm2835: critical clocks and parent selection
In-Reply-To: <5E7C0C2A-8FA0-4EFF-9627-DFC34662590B@martin.sperl.org>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
 <5731B8BA.30402@martin.sperl.org> <87a8jxyfua.fsf@eliezer.anholt.net>
 <FD44F435-512C-49A5-B1F5-3C62AAF805AC@martin.sperl.org>
 <5E7C0C2A-8FA0-4EFF-9627-DFC34662590B@martin.sperl.org>
Message-ID: <87lh3f9lsh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

> On 10.05.2016, at 21:58, Martin Sperl <kernel@martin.sperl.org> wrote:
>> 
>> 
>> 
>>> On 10.05.2016, at 19:37, Eric Anholt <eric@anholt.net> wrote:
>>> 
>>> Martin Sperl <kernel@martin.sperl.org> writes:
>>> 
>>>>> On 10.05.2016 03:01, Eric Anholt wrote:
>>>>> With the new patch 2 inserted between my previous pair, I think this
>>>>> should cover Martin's bugs with clock disabling.
>>>>> 
>>>>> I tested patch 2 to be important on the downstream kernel: with the
>>>>> DPI panel support added there, I was losing ethernet (my only I/O)
>>>>> when the HDMI HSM hanging off of PLLD_PER got disabled due to
>>>>> EPROBE_DEFER.
>>>>> 
>>>>> Eric Anholt (3):
>>>>> clk: bcm2835: Mark the VPU clock as critical
>>>>> clk: bcm2835: Mark GPIO clocks enabled at boot as critical.
>>>>> clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent
>>>>> 
>>>>> drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
>>>>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>>> I gave it a try - with all 3 patches applied I get the following enabled 
>>>> clocks:
>>>> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
>>>> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
>>>> /sys/kernel/debug/clk/emmc/clk_enable_count:1
>>>> /sys/kernel/debug/clk/gp1/clk_enable_count:1
>>>> /sys/kernel/debug/clk/gp2/clk_enable_count:1
>>>> /sys/kernel/debug/clk/osc/clk_enable_count:1
>>>> /sys/kernel/debug/clk/pllc/clk_enable_count:2
>>>> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
>>>> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
>>>> /sys/kernel/debug/clk/vpu/clk_enable_count:2
>>>> 
>>>> At least on my compute module gp1/gp2 is enabled, but there is no rate
>>>> set - so why is it marked as critical for all devices?
>>>> So why apply patch2 for all possible devices?
>>> 
>>> According to the CLK_IS_CRITICAL patches, the author intended critical
>>> clocks not to use the included function for marking clocks as critical
>>> From the DT.  I'm not sure why, but writing patches using that when they
>>> say not to seemed like a waste.
>>> 
>>> We could check if gp1/gp2 are already on before marking them critical.
>> That may seem reasonable.
>>> 
>>>> Loading/unloading the amba_pl011 module does not crash the system,
>>>> but a simple stty -F /dev/ttyAMA0 does crash the system!
>>>> 
>>>> Here the sequence:
>>>> root at raspcm:~# dmesg -C
>>>> root at raspcm:~# modprobe amba_pl011
>>>> root at raspcm:~# dmesg -c
>>>> [  141.708453] Serial: AMBA PL011 UART driver
>>>> [  141.709158] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
>>>> base_baud = 0) is a PL011 rev2
>>>> root at raspcm:~# rmmod  amba_pl011
>>>> root at raspcm:~# dmesg -c
>>>> [  150.511248] Trying to free nonexistent resource 
>>>> <0000000020201000-0000000020201fff>
>>>> root at raspcm:~# modprobe amba_pl011
>>>> root at raspcm:~# dmesg -c
>>>> [  159.385002] Serial: AMBA PL011 UART driver
>>>> [  159.385714] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
>>>> base_baud = 0) is a PL011 rev2
>>>> root at raspcm:~# stty -F /dev/ttyAMA0
>>>> speed 9600 baud; line = 0;
>>>> -brkint -imaxbel
>>>> root at raspcm:~# Timeout, server raspcm not responding.
>>>> 
>>>> The reason behind this is that the firmware pre-configured uart clock
>>>> looks like this:
>>>> root at raspcm:~# cat /sys/kernel/debug/clk/uart/regdump
>>>> ctl = 0x00000296
>>>> div = 0x000a6aab
>>>> so it is configured to use plld_per (which itself is running, even if 
>>>> not enabled
>>>> in the kernel)
>>>> 
>>>> But as plld_per is not among the enabled clocks then plld_per
>>>> gets disabled as soon as the tty device is closed (by stty) and
>>>> this also disables plld...
>>>> 
>>>> Similar effect when using PCM/i2s and use speaker-test:
>>>> root at raspcm:~# dmesg -C
>>>> root at raspcm:~# modprobe snd-soc-bcm2835-i2s; modprobe snd-soc-pcm5102a; 
>>>> modprobe snd-soc-hifiberry-dac
>>>> root at raspcm:~# dmesg
>>>> [   81.968591] snd-hifiberry-dac sound: pcm5102a-hifi <-> 20203000.i2s 
>>>> mapping ok
>>>> root at raspcm:~# speaker-test -c 2 -r 44100 -F S16_LE -f 440 -t sine&
>>>> [1] 579
>>>> root at raspcm:~#
>>>> speaker-test 1.0.28
>>>> 
>>>> Playback device is default
>>>> Stream parameters are 44100Hz, S16_LE, 2 channels
>>>> Sine wave rate is 440.0000Hz
>>>> Rate set to 44100Hz (requested 44100Hz)
>>>> Buffer size range from 128 to 131072
>>>> Period size range from 64 to 65536
>>>> Using max buffer size 131072
>>>> Periods = 4
>>>> was set period_size = 32768
>>>> was set buffer_size = 131072
>>>> 0 - Front Left
>>>> 1 - Front Right
>>>> 
>>>> root at raspcm:~#
>>>> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
>>>> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
>>>> /sys/kernel/debug/clk/emmc/clk_enable_count:1
>>>> /sys/kernel/debug/clk/gp1/clk_enable_count:1
>>>> /sys/kernel/debug/clk/gp2/clk_enable_count:1
>>>> /sys/kernel/debug/clk/osc/clk_enable_count:2
>>>> /sys/kernel/debug/clk/pcm/clk_enable_count:1
>>>> /sys/kernel/debug/clk/pllc/clk_enable_count:2
>>>> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
>>>> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
>>>> /sys/kernel/debug/clk/plld/clk_enable_count:1
>>>> /sys/kernel/debug/clk/plld_per/clk_enable_count:1
>>>> /sys/kernel/debug/clk/vpu/clk_enable_count:2
>>>> root at raspcm:~# kill %1
>>>> root at raspcm:~# Time per period = 106.889502
>>>> Timeout, server raspcm not responding.
>>>> 
>>>> You see that plld gets now used and when I kill speaker-test
>>>> the machine crashes again.
>>> 
>>> Just so I can be clear here: What are you using to talk to the Pi?
>>> Builtin USB ethernet?
>> Compute module with USB  Ethernet adapter, but I also got an 
>> enc28j60 connected via spi, but that is not enabled by default
>> 
>>> 
>>>> So this patchset does not really solve any of the problems that
>>>> I have reported either.
>>>> 
>>>> That is why my patchset has taken the "HAND_OFF" approach
>>>> instead (which still just hides some of the issues), but at least
>>>> it does not crash the system on the use of plld and it allows
>>>> for custom parent and mash selection.
>>> 
>>> HAND_OFF sure doesn't look like it's landing in the next kernel, so
>>> writing patches using it doesn't make much sense to me.
>> 
>> If it is critical or hands-off does not really make a difference...
>> 
>>>> In reality it would require consumers of the corresponding
>>>> parent clocks in the kernel (arm, ...) and the knowledge which
>>>> clocks are really needed by the firmware - i.e plld.
>>>> 
>>>> Note that the sdram clock is using plld_core parent!
>>>> root at raspcm:~#  cat /sys/kernel/debug/clk/sdram/regdump
>>>> ctl = 0x00004006
>>>> div = 0x00003000
>>>> root at raspcm:~# cat /sys/kernel/debug/clk/sdram/clk_rate
>>>> 166533331
>>> 
>>> However, it's not enabled, right?  Bit 4 isn't set in the CTL reg.
>> You are probably right there, but still there must be something
>> hidden that requires plld or plld_per or plld_core, that requires critical.
>> 
>> There must be some reason why it gets set up during the
>> boot process by the firmware.
>> 
>
> Correction:
>
> Actually the SDC control register contains some more bits compared
> to most other clock control registers:
> CM_SDCCTL_CTRL (12-15), CM_SDCCTL_ACCPT(16) and CM_SDCCTL_UPDATE(17)
>
> See also:
> https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md#cm_sdcctl
>
> If I poke that register (0x201011a8) from userspace with 0x5a000000
> then the machine crashes as well - so I assume these bits control
> the custom SD-Ram PLL - unfortunately it still does not say which
> PLL is used.

You must not change the CTRL bits while ACCEPT is unset.

> Note that I also tried disabling PLLD_CORE and the system crashed as well
> (root at raspcm:~#  peekpoke $[0x20101000 + 0x10c] w
> /dev/mem opened.
> Memory mapped at address 0xb6fdd000.
> Value at address 0x2010110C (0xb6fdd10c): 0x20A
> root at raspcm:~# peekpoke $[0x20101000 + 0x10c] w $[0x5a000000 + 0x20a + 32]
> /dev/mem opened.
> Memory mapped at address 0xb6fe7000.
> Value at address 0x2010110C (0xb6fe710c): 0x20A
> Written 0x5A00022A; readback 0x22A
> root at raspcm:~# Write failed: Broken pipe

I don't have an answer for this one, and spent a while digging.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/7be444d5/attachment-0001.sig>

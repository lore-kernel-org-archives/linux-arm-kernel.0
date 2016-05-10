From: eric@anholt.net (Eric Anholt)
Date: Tue, 10 May 2016 10:37:17 -0700
Subject: [PATCH 0/3] clk: bcm2835: critical clocks and parent selection
In-Reply-To: <5731B8BA.30402@martin.sperl.org>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
 <5731B8BA.30402@martin.sperl.org>
Message-ID: <87a8jxyfua.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

> On 10.05.2016 03:01, Eric Anholt wrote:
>> With the new patch 2 inserted between my previous pair, I think this
>> should cover Martin's bugs with clock disabling.
>>
>> I tested patch 2 to be important on the downstream kernel: with the
>> DPI panel support added there, I was losing ethernet (my only I/O)
>> when the HDMI HSM hanging off of PLLD_PER got disabled due to
>> EPROBE_DEFER.
>>
>> Eric Anholt (3):
>>    clk: bcm2835: Mark the VPU clock as critical
>>    clk: bcm2835: Mark GPIO clocks enabled at boot as critical.
>>    clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent
>>
>>   drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
> I gave it a try - with all 3 patches applied I get the following enabled 
> clocks:
> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
> /sys/kernel/debug/clk/emmc/clk_enable_count:1
> /sys/kernel/debug/clk/gp1/clk_enable_count:1
> /sys/kernel/debug/clk/gp2/clk_enable_count:1
> /sys/kernel/debug/clk/osc/clk_enable_count:1
> /sys/kernel/debug/clk/pllc/clk_enable_count:2
> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
> /sys/kernel/debug/clk/vpu/clk_enable_count:2
>
> At least on my compute module gp1/gp2 is enabled, but there is no rate
> set - so why is it marked as critical for all devices?
> So why apply patch2 for all possible devices?

According to the CLK_IS_CRITICAL patches, the author intended critical
clocks not to use the included function for marking clocks as critical
>From the DT.  I'm not sure why, but writing patches using that when they
say not to seemed like a waste.

We could check if gp1/gp2 are already on before marking them critical.

> Loading/unloading the amba_pl011 module does not crash the system,
> but a simple stty -F /dev/ttyAMA0 does crash the system!
>
> Here the sequence:
> root at raspcm:~# dmesg -C
> root at raspcm:~# modprobe amba_pl011
> root at raspcm:~# dmesg -c
> [  141.708453] Serial: AMBA PL011 UART driver
> [  141.709158] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
> base_baud = 0) is a PL011 rev2
> root at raspcm:~# rmmod  amba_pl011
> root at raspcm:~# dmesg -c
> [  150.511248] Trying to free nonexistent resource 
> <0000000020201000-0000000020201fff>
> root at raspcm:~# modprobe amba_pl011
> root at raspcm:~# dmesg -c
> [  159.385002] Serial: AMBA PL011 UART driver
> [  159.385714] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
> base_baud = 0) is a PL011 rev2
> root at raspcm:~# stty -F /dev/ttyAMA0
> speed 9600 baud; line = 0;
> -brkint -imaxbel
> root at raspcm:~# Timeout, server raspcm not responding.
>
> The reason behind this is that the firmware pre-configured uart clock
> looks like this:
> root at raspcm:~# cat /sys/kernel/debug/clk/uart/regdump
> ctl = 0x00000296
> div = 0x000a6aab
> so it is configured to use plld_per (which itself is running, even if 
> not enabled
> in the kernel)
>
> But as plld_per is not among the enabled clocks then plld_per
> gets disabled as soon as the tty device is closed (by stty) and
> this also disables plld...
>
> Similar effect when using PCM/i2s and use speaker-test:
> root at raspcm:~# dmesg -C
> root at raspcm:~# modprobe snd-soc-bcm2835-i2s; modprobe snd-soc-pcm5102a; 
> modprobe snd-soc-hifiberry-dac
> root at raspcm:~# dmesg
> [   81.968591] snd-hifiberry-dac sound: pcm5102a-hifi <-> 20203000.i2s 
> mapping ok
> root at raspcm:~# speaker-test -c 2 -r 44100 -F S16_LE -f 440 -t sine&
> [1] 579
> root at raspcm:~#
> speaker-test 1.0.28
>
> Playback device is default
> Stream parameters are 44100Hz, S16_LE, 2 channels
> Sine wave rate is 440.0000Hz
> Rate set to 44100Hz (requested 44100Hz)
> Buffer size range from 128 to 131072
> Period size range from 64 to 65536
> Using max buffer size 131072
> Periods = 4
> was set period_size = 32768
> was set buffer_size = 131072
>   0 - Front Left
>   1 - Front Right
>
> root at raspcm:~#
> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
> /sys/kernel/debug/clk/emmc/clk_enable_count:1
> /sys/kernel/debug/clk/gp1/clk_enable_count:1
> /sys/kernel/debug/clk/gp2/clk_enable_count:1
> /sys/kernel/debug/clk/osc/clk_enable_count:2
> /sys/kernel/debug/clk/pcm/clk_enable_count:1
> /sys/kernel/debug/clk/pllc/clk_enable_count:2
> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
> /sys/kernel/debug/clk/plld/clk_enable_count:1
> /sys/kernel/debug/clk/plld_per/clk_enable_count:1
> /sys/kernel/debug/clk/vpu/clk_enable_count:2
> root at raspcm:~# kill %1
> root at raspcm:~# Time per period = 106.889502
> Timeout, server raspcm not responding.
>
> You see that plld gets now used and when I kill speaker-test
> the machine crashes again.

Just so I can be clear here: What are you using to talk to the Pi?
Builtin USB ethernet?

> So this patchset does not really solve any of the problems that
> I have reported either.
>
> That is why my patchset has taken the "HAND_OFF" approach
> instead (which still just hides some of the issues), but at least
> it does not crash the system on the use of plld and it allows
> for custom parent and mash selection.

HAND_OFF sure doesn't look like it's landing in the next kernel, so
writing patches using it doesn't make much sense to me.

> In reality it would require consumers of the corresponding
> parent clocks in the kernel (arm, ...) and the knowledge which
> clocks are really needed by the firmware - i.e plld.
>
> Note that the sdram clock is using plld_core parent!
> root at raspcm:~#  cat /sys/kernel/debug/clk/sdram/regdump
> ctl = 0x00004006
> div = 0x00003000
> root at raspcm:~# cat /sys/kernel/debug/clk/sdram/clk_rate
> 166533331

However, it's not enabled, right?  Bit 4 isn't set in the CTL reg.

> and also hsm (probably hardware security module):
> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/regdump
> ctl = 0x000002d6
> div = 0x000030e0
> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/clk_rate
> 163551916

That's the HDMI state machine (there's even a comment saying so),
controlled by the vc4 driver.

> So turning plld off stops sdram and hsm - at least that is my
> interpretation.
>
> This means we need to define a clock property in firmware or
> we need a ram node making use of "mmio-sram" maybe?
>
> Marking sdram as "critical" or "hand_off" could also solve that
> for the moment (but it does not solve all the other hidden
> clock dependencies of the firmware)

If there are other hidden dependencies, then we should figure them out.

> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1655,7 +1655,8 @@ static const struct bcm2835_clk_desc 
> clk_desc_array[] = {
>                  .ctl_reg = CM_SDCCTL,
>                  .div_reg = CM_SDCDIV,
>                  .int_bits = 6,
> -               .frac_bits = 0),
> +               .frac_bits = 0,
> +               .flags = CLK_IS_CRITICAL),
>          [BCM2835_CLOCK_V3D]     = REGISTER_VPU_CLK(
>                  .name = "v3d",
>                  .ctl_reg = CM_V3DCTL,

The Pi foundation folks believe that the cprman SDRAM clock isn't ever
used (there's a separate PLL in the SDRAM controller, and cprman is only
intended for unused low-power states), and at least in your sample of
the reg, it's not enabled.  Instead of grepping for clk_enable_count, it
would be really useful for debugging to look at your clk_summary
instead.

> Still I would say that this should actually move to the dt to
> correctly describe the HW.

If you created a series that *just* added critical support, using
assigned-clocks, and got the DT folks to agree to it, that would be fine
with me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/e3c8773a/attachment.sig>

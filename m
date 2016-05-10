From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 10 May 2016 21:58:08 +0200
Subject: [PATCH 0/3] clk: bcm2835: critical clocks and parent selection
In-Reply-To: <87a8jxyfua.fsf@eliezer.anholt.net>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
 <5731B8BA.30402@martin.sperl.org> <87a8jxyfua.fsf@eliezer.anholt.net>
Message-ID: <FD44F435-512C-49A5-B1F5-3C62AAF805AC@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 10.05.2016, at 19:37, Eric Anholt <eric@anholt.net> wrote:
> 
> Martin Sperl <kernel@martin.sperl.org> writes:
> 
>>> On 10.05.2016 03:01, Eric Anholt wrote:
>>> With the new patch 2 inserted between my previous pair, I think this
>>> should cover Martin's bugs with clock disabling.
>>> 
>>> I tested patch 2 to be important on the downstream kernel: with the
>>> DPI panel support added there, I was losing ethernet (my only I/O)
>>> when the HDMI HSM hanging off of PLLD_PER got disabled due to
>>> EPROBE_DEFER.
>>> 
>>> Eric Anholt (3):
>>>  clk: bcm2835: Mark the VPU clock as critical
>>>  clk: bcm2835: Mark GPIO clocks enabled at boot as critical.
>>>  clk: bcm2835: Skip PLLC clocks when deciding on a new clock parent
>>> 
>>> drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
>>> 1 file changed, 30 insertions(+), 2 deletions(-)
>> I gave it a try - with all 3 patches applied I get the following enabled 
>> clocks:
>> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
>> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
>> /sys/kernel/debug/clk/emmc/clk_enable_count:1
>> /sys/kernel/debug/clk/gp1/clk_enable_count:1
>> /sys/kernel/debug/clk/gp2/clk_enable_count:1
>> /sys/kernel/debug/clk/osc/clk_enable_count:1
>> /sys/kernel/debug/clk/pllc/clk_enable_count:2
>> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
>> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
>> /sys/kernel/debug/clk/vpu/clk_enable_count:2
>> 
>> At least on my compute module gp1/gp2 is enabled, but there is no rate
>> set - so why is it marked as critical for all devices?
>> So why apply patch2 for all possible devices?
> 
> According to the CLK_IS_CRITICAL patches, the author intended critical
> clocks not to use the included function for marking clocks as critical
> From the DT.  I'm not sure why, but writing patches using that when they
> say not to seemed like a waste.
> 
> We could check if gp1/gp2 are already on before marking them critical.
That may seem reasonable.
> 
>> Loading/unloading the amba_pl011 module does not crash the system,
>> but a simple stty -F /dev/ttyAMA0 does crash the system!
>> 
>> Here the sequence:
>> root at raspcm:~# dmesg -C
>> root at raspcm:~# modprobe amba_pl011
>> root at raspcm:~# dmesg -c
>> [  141.708453] Serial: AMBA PL011 UART driver
>> [  141.709158] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
>> base_baud = 0) is a PL011 rev2
>> root at raspcm:~# rmmod  amba_pl011
>> root at raspcm:~# dmesg -c
>> [  150.511248] Trying to free nonexistent resource 
>> <0000000020201000-0000000020201fff>
>> root at raspcm:~# modprobe amba_pl011
>> root at raspcm:~# dmesg -c
>> [  159.385002] Serial: AMBA PL011 UART driver
>> [  159.385714] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq = 81, 
>> base_baud = 0) is a PL011 rev2
>> root at raspcm:~# stty -F /dev/ttyAMA0
>> speed 9600 baud; line = 0;
>> -brkint -imaxbel
>> root at raspcm:~# Timeout, server raspcm not responding.
>> 
>> The reason behind this is that the firmware pre-configured uart clock
>> looks like this:
>> root at raspcm:~# cat /sys/kernel/debug/clk/uart/regdump
>> ctl = 0x00000296
>> div = 0x000a6aab
>> so it is configured to use plld_per (which itself is running, even if 
>> not enabled
>> in the kernel)
>> 
>> But as plld_per is not among the enabled clocks then plld_per
>> gets disabled as soon as the tty device is closed (by stty) and
>> this also disables plld...
>> 
>> Similar effect when using PCM/i2s and use speaker-test:
>> root at raspcm:~# dmesg -C
>> root at raspcm:~# modprobe snd-soc-bcm2835-i2s; modprobe snd-soc-pcm5102a; 
>> modprobe snd-soc-hifiberry-dac
>> root at raspcm:~# dmesg
>> [   81.968591] snd-hifiberry-dac sound: pcm5102a-hifi <-> 20203000.i2s 
>> mapping ok
>> root at raspcm:~# speaker-test -c 2 -r 44100 -F S16_LE -f 440 -t sine&
>> [1] 579
>> root at raspcm:~#
>> speaker-test 1.0.28
>> 
>> Playback device is default
>> Stream parameters are 44100Hz, S16_LE, 2 channels
>> Sine wave rate is 440.0000Hz
>> Rate set to 44100Hz (requested 44100Hz)
>> Buffer size range from 128 to 131072
>> Period size range from 64 to 65536
>> Using max buffer size 131072
>> Periods = 4
>> was set period_size = 32768
>> was set buffer_size = 131072
>> 0 - Front Left
>> 1 - Front Right
>> 
>> root at raspcm:~#
>> root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
>> /sys/kernel/debug/clk/aux_uart/clk_enable_count:1
>> /sys/kernel/debug/clk/emmc/clk_enable_count:1
>> /sys/kernel/debug/clk/gp1/clk_enable_count:1
>> /sys/kernel/debug/clk/gp2/clk_enable_count:1
>> /sys/kernel/debug/clk/osc/clk_enable_count:2
>> /sys/kernel/debug/clk/pcm/clk_enable_count:1
>> /sys/kernel/debug/clk/pllc/clk_enable_count:2
>> /sys/kernel/debug/clk/pllc_core0/clk_enable_count:1
>> /sys/kernel/debug/clk/pllc_per/clk_enable_count:1
>> /sys/kernel/debug/clk/plld/clk_enable_count:1
>> /sys/kernel/debug/clk/plld_per/clk_enable_count:1
>> /sys/kernel/debug/clk/vpu/clk_enable_count:2
>> root at raspcm:~# kill %1
>> root at raspcm:~# Time per period = 106.889502
>> Timeout, server raspcm not responding.
>> 
>> You see that plld gets now used and when I kill speaker-test
>> the machine crashes again.
> 
> Just so I can be clear here: What are you using to talk to the Pi?
> Builtin USB ethernet?
Compute module with USB  Ethernet adapter, but I also got an 
enc28j60 connected via spi, but that is not enabled by default

> 
>> So this patchset does not really solve any of the problems that
>> I have reported either.
>> 
>> That is why my patchset has taken the "HAND_OFF" approach
>> instead (which still just hides some of the issues), but at least
>> it does not crash the system on the use of plld and it allows
>> for custom parent and mash selection.
> 
> HAND_OFF sure doesn't look like it's landing in the next kernel, so
> writing patches using it doesn't make much sense to me.

If it is critical or hands-off does not really make a difference...

>> In reality it would require consumers of the corresponding
>> parent clocks in the kernel (arm, ...) and the knowledge which
>> clocks are really needed by the firmware - i.e plld.
>> 
>> Note that the sdram clock is using plld_core parent!
>> root at raspcm:~#  cat /sys/kernel/debug/clk/sdram/regdump
>> ctl = 0x00004006
>> div = 0x00003000
>> root at raspcm:~# cat /sys/kernel/debug/clk/sdram/clk_rate
>> 166533331
> 
> However, it's not enabled, right?  Bit 4 isn't set in the CTL reg.
You are probably right there, but still there must be something
hidden that requires plld or plld_per or plld_core, that requires critical.

There must be some reason why it gets set up during the
boot process by the firmware.

> 
>> and also hsm (probably hardware security module):
>> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/regdump
>> ctl = 0x000002d6
>> div = 0x000030e0
>> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/clk_rate
>> 163551916
> 
> That's the HDMI state machine (there's even a comment saying so),
> controlled by the vc4 driver.
> 
>> So turning plld off stops sdram and hsm - at least that is my
>> interpretation.
>> 
>> This means we need to define a clock property in firmware or
>> we need a ram node making use of "mmio-sram" maybe?
>> 
>> Marking sdram as "critical" or "hand_off" could also solve that
>> for the moment (but it does not solve all the other hidden
>> clock dependencies of the firmware)
> 
> If there are other hidden dependencies, then we should figure them out.

But strangely the sdram (plus the below) is the only one with
plld that is enabled (unless it is one of the clocks we have not
added to the kernel side yet)

Maybe there is something that derives directly from plld_core
or any of the other plld-dividers?

Core would indicate anything central to the videocore...
Anyway both plld_core as well as plld_per ad well as both
Pll_dsi that are running by default (but I doubt that the
Dsi would be relevant)

I guess you are in a better situation to figure out which
hidden HW blocks uses plld...

> 
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -1655,7 +1655,8 @@ static const struct bcm2835_clk_desc 
>> clk_desc_array[] = {
>>                .ctl_reg = CM_SDCCTL,
>>                .div_reg = CM_SDCDIV,
>>                .int_bits = 6,
>> -               .frac_bits = 0),
>> +               .frac_bits = 0,
>> +               .flags = CLK_IS_CRITICAL),
>>        [BCM2835_CLOCK_V3D]     = REGISTER_VPU_CLK(
>>                .name = "v3d",
>>                .ctl_reg = CM_V3DCTL,
> 
> The Pi foundation folks believe that the cprman SDRAM clock isn't ever
> used (there's a separate PLL in the SDRAM controller, and cprman is only
> intended for unused low-power states), and at least in your sample of
> the reg, it's not enabled.  Instead of grepping for clk_enable_count, it
See my comment above - it must be configured for some reason
during the boot process by the firmware .


> would be really useful for debugging to look at your clk_summary
> instead.

Here you go:
   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 uart1_pclk                               0            0   125000000          0 0
 uart0_pclk                               0            0     3000000          0 0
 apb_pclk                                 0            0   126000000          0 0
 osc                                      2            2    19200000          0 0
    tsens                                 0            0     1920000          0 0
    vec                                   0            0    19200000          0 0
    otp                                   0            0     4800000          0 0
    timer                                 0            0     1000002          0 0
    pllh                                  0            0  1485000000          0 0
       pllh_pix_prediv                    0            0  1485000000          0 0
          pllh_pix                        0            0   148500000          0 0
       pllh_aux_prediv                    0            0     5800782          0 0
          pllh_aux                        0            0      580078          0 0
       pllh_rcal_prediv                   0            0     5800782          0 0
          pllh_rcal                       0            0      580078          0 0
    plld                                  2            2  1998399975          0 0
       plld_dsi1                          0            0     7806250          0 0
       plld_dsi0                          0            0     7806250          0 0
       plld_per                           1            1   499599994          0 0
          pwm                             1            1     9999958          0 0
          hsm                             0            0   163551916          0 0
          uart                            0            0     2997598          0 0
       plld_core                          1            1   499599994          0 0
          sdram                           1            1   166533331          0 0
    pllc                                  2            2  1998399975          0 0
       pllc_per                           1            1   999199988          0 0
          emmc                            1            1   249799997          0 0
       pllc_core2                         0            0     7806250          0 0
       pllc_core1                         0            0     7806250          0 0
       pllc_core0                         1            1   999199988          0 0
          vpu                             1            1   249799997          0 0
             aux_spi2                     0            0   249799997          0 0
             aux_spi1                     0            0   249799997          0 0
             aux_uart                     0            0   249799997          0 0
             peri_image                   0            0   249799997          0 0
    pllb                                  0            0  1399999951          0 0
       pllb_arm                           0            0   699999976          0 0
    plla                                  0            0  1998399975          0 0
       plla_ccp2                          0            0     7806250          0 0
       plla_dsi0                          0            0     7806250          0 0
       plla_per                           0            0     7806250          0 0
       plla_core                          0            0   999199988          0 0
          h264                            0            0   249799997          0 0
          isp                             0            0   249799997          0 0
          v3d                             0            0   249799997          0 0
 dsi1e                                    0            0           0          0 0
 dsi0e                                    0            0           0          0 0
 cam1                                     0            0           0          0 0
 cam0                                     0            0           0          0 0
 dpi                                      0            0           0          0 0
 tec                                      0            0           0          0 0
 smi                                      0            0           0          0 0
 slim                                     0            0           0          0 0
 gp2                                      1            1           0          0 0
 gp1                                      1            1           0          0 0
 gp0                                      0            0           0          0 0
 dft                                      0            0           0          0 0
 aveo                                     0            0           0          0 0
 pcm                                      0            0           0          0 0

(that is with the critical patch for sdram - so ignore the ?enable_count?
for sdram)

> 
>> Still I would say that this should actually move to the dt to
>> correctly describe the HW.
> 
> If you created a series that *just* added critical support, using
> assigned-clocks, and got the DT folks to agree to it, that would be fine
> with me.

In the end I do not care for which patch gets in - I just want a solution
that does not crash and I guess that is also what the foundation
wants (and they want to move to the clock framework and I try to get
it there)

Martin

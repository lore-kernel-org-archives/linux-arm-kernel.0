From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 10 Apr 2014 21:48:36 -0700
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree to
 PLL5
In-Reply-To: <CAJ+vNU1uzKCZxjsr+inuOi_VJbs+iR14uqXKOCr_32ZS__HrZQ@mail.gmail.com>
References: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU1uzKCZxjsr+inuOi_VJbs+iR14uqXKOCr_32ZS__HrZQ@mail.gmail.com>
Message-ID: <CAJ+vNU0V_vXDOvergiQ2q00EFL46kGFJCvqCS=hdW5x=0rjN5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 9:31 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Wed, Apr 9, 2014 at 8:39 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
>> Allows clk_set_rate() on the DI clocks to propagate up to PLL5.
>>
>> This allows imx-drm to produce the exact clock rate required with no
>> modulation due to the fractional divider.  Modulation of the clock rate
>> can and does prevent TVs from locking to the HDMI signal - they will
>> report no signal rather than trying to lock to such a signal.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> I still have this patch which is required so that imx-drm is capable of
>> producing HDMI clocks which are close enough to the HDMI defined
>> frequencies such that TVs and similar can recognise the signal.  Without
>> this, I don't get any kind of output on my TV desite imx-drm being set
>> to the correct mode.  I have proven that this is because the HDMI clock
>> is *very* wrong without this patch.
>>
>>  arch/arm/mach-imx/clk-imx6q.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>
> Hi Russell,
>
> This fixed HDMI on the boards I'm testing it on (Gateworks Ventana).
> Without it I encounter the same issue you describe above.
>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
>
> Tim

I neglected to mention that even after this patch I do see an issue
where the monitor does not sync if plugged in on board powerup.  The
following is what I see with DEBUG enabled in imx-hdmi:

on boot with monitor plugged in:
[    4.612634] imx-hdmi 120000.hdmi: Detected HDMI controller
0x13:0x1a:0xa0:0xc1
[    4.620213] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[    4.627039] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[    4.638744] imx-drm display-subsystem.10: bound 120000.hdmi (ops hdmi_ops)
[    4.638774] imx-hdmi 120000.hdmi: EVENT=plugin
[    4.638786] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
[    4.638796] imx-hdmi 120000.hdmi: final pixclk = 0
[    4.656902] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
[    4.722049] imx-hdmi 120000.hdmi: got edid: width[70] x height[39]

# monitor has no sync - EDID is correct, but looks like it
mis-interprets the mode (above)

root at ventana:~# hexdump -C
/sys/devices/soc0/display-subsystem.10/drm/card0/card0-HDMI-A-1/edid
00000000  00 ff ff ff ff ff ff 00  4a 8b 54 4c 01 00 00 00  |........J.TL....|
00000010  0c 11 01 03 81 46 27 78  8a a5 8e a6 54 4a 9c 26  |.....F'x....TJ.&|
00000020  12 45 46 af cf 00 95 00  95 0f 95 19 01 01 01 01  |.EF.............|
00000030  01 01 01 01 01 01 01 1d  00 72 51 d0 1e 20 6e 28  |.........rQ.. n(|
00000040  55 00 b9 88 21 00 00 1e  8c 0a d0 8a 20 e0 2d 10  |U...!....... .-.|
00000050  10 3e 96 00 b9 88 21 00  00 18 00 00 00 fd 00 32  |.>....!........2|
00000060  4b 18 3c 0b 00 0a 20 20  20 20 20 20 00 00 00 fc  |K.<...      ....|
00000070  00 33 32 56 33 48 2d 48  36 41 0a 20 20 20 01 29  |.32V3H-H6A.   .)|
00000080  02 03 21 71 4e 06 07 02  03 15 96 11 12 13 04 14  |..!qN...........|
00000090  05 1f 90 23 09 07 07 83  01 00 00 65 03 0c 00 10  |...#.......e....|
000000a0  00 8c 0a d0 90 20 40 31  20 0c 40 55 00 b9 88 21  |..... @1 . at U...!|
000000b0  00 00 18 01 1d 80 18 71  1c 16 20 58 2c 25 00 b9  |.......q.. X,%..|
000000c0  88 21 00 00 9e 01 1d 80  d0 72 1c 16 20 10 2c 25  |.!.......r.. .,%|
000000d0  80 b9 88 21 00 00 9e 01  1d 00 bc 52 d0 1e 20 b8  |...!.......R.. .|
000000e0  28 55 40 b9 88 21 00 00  1e 02 3a 80 d0 72 38 2d  |(U at ..!....:..r8-|
000000f0  40 10 2c 45 80 b9 88 21  00 00 1e 00 00 00 00 d0  |@.,E...!........|
00000100

root at ventana:~# cat
/sys/devices/soc0/display-subsystem.10/drm/card0/card0-HDMI-A-1/modes
1280x720
1920x1080
1920x1080
1920x1080
1280x1024
1440x900
1440x900
1440x900
1280x720
1280x720
1024x768
1024x768
1024x768
800x600
800x600
800x600
800x600
720x576
848x480
720x480
720x480
640x480
640x480
640x480
640x480
640x480
720x400

and hotplug the monitor:
[   51.946693] imx-hdmi 120000.hdmi: EVENT=plugout
[   54.918144] imx-hdmi 120000.hdmi: EVENT=plugin
[   54.922619] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
[   54.928346] imx-hdmi 120000.hdmi: final pixclk = 0
[   54.951254] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
[   55.007786] imx-hdmi 120000.hdmi: got edid: width[70] x height[39]
[   55.016677] imx-hdmi 120000.hdmi: CEA mode used vic=4
[   55.021966] imx-hdmi 120000.hdmi: final pixclk = 74250000
[   55.046148] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[   55.051744] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[   55.058563] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[   55.071574] imx-hdmi 120000.hdmi: CEA mode used vic=4
[   55.076656] imx-hdmi 120000.hdmi: final pixclk = 74250000
[   55.100279] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[   55.105707] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[   55.112534] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250

# monitor is now sync'd with proper output and EDID is same as before

root@ventana:~# cat
/sys/devices/soc0/display-subsystem.10/drm/card0/card0-HDMI-A-1/modes
1280x720
1280x720
1280x720
800x600
800x600
800x600
800x600
720x576
848x480
720x480
720x480
640x480
640x480
640x480
640x480
640x480
720x400

Any ideas?

Regards,

Tim

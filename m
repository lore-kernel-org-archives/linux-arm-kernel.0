From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Thu, 5 Oct 2017 14:18:31 +0000
Subject: DryIce , RTC not working on imx53.
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

DryIce , SRTC not working on imx53. ( kernel 4.x) ?( same hardware running older kernel versions.. means , rtc is working)

During boot all seems to be fine but once you try to read or write the hardware clock later on ? it bails out with this error on the console. 

hwclock

[   97.186577] imxdi_rtc 53fa4000.rtc: Write-wait timeout val = 0x5a2ff8d3 reg = 0x00000008

Hwclock : select() to /dev/rtc0 to wait for clock tick timed out: No such file or directory



I've Added some driver ? printk?s?.

# hwclock
[   73.362559] dryice_rtc_read_time ------------------------------------------------
[   73.395077] dryice_rtc_read_time ------------------------------------------------
[   73.414156] dryice_rtc_read_time ------------------------------------------------
[   73.421700] di_write_wait ------------------------------------------------
[   73.472624] di_int_enable ------------------------------------------------
[   73.514609] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x5a3000c8 reg = 0x00000008
[   73.523019] di_int_enable ------------------------------------------------

<< STALLS for 5 seconds here >>
<< STALLS for 5 seconds here >>
<< STALLS for 5 seconds here >>
<< STALLS for 5 seconds here >>
<< STALLS for 5 seconds here >>

hwclock[   78.584909] dryice_rtc_alarm_irq_enable ------------------------------------------------
: select() to /dev/rtc0 to wait f[   78.593456] di_int_disable ------------------------------------------------
or clock tick timed out: No such file or directory






Strace .. logging ================================


stat("/lib/ld-uClibc.so.0", {st_mode=S_IFREG|0777, st_size=25300, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x4000000, -1, 0) = 0xb6f04000
set_tls(0xb6f04490, 0xb6f04b38, 0xb6f07088, 0xb6f04490, 0xb6f06f74) = 0
mprotect(0xb6ed2000, 4096, PROT_READ)   = 0
mprotect(0xb6f06000, 4096, PROT_READ)   = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 opost isig icanon echo ...}) = 0
gettimeofday({1513095430, 708097}, NULL) = 0
getuid32()                              = 0
open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = -1 ENOENT (No such file or directory)
open("/dev/rtc0", O_RDONLY|O_LARGEFILE) = 3
brk(0)                                  = 0x18000
brk(0x19000)                            = 0x19000
stat64("/etc/adjtime", 0xbeec26a8)      = -1 ENOENT (No such file or directory)
ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) = 0
select(4, [3], NULL, NULL, {5, 0}


<< STALLS for 5 seconds here  --  select is not returning !!! timeout is 5 seconds?. >>

)      = 0 (Timeout)[  141.766162] dryice_rtc_alarm_irq_enable ------------------------------------------------

write(2, "hwclock", 7hwclock)                  = 7
write(2, ": ", 2: )                       =[  141.782195] di_int_disable ------------------------------------------------
2
write(2, "select() to ", 12select() to )            = 12
write(2, "/dev/rtc0", 9/dev/rtc0)                = 9
write(2, " to wait for clock tick timed ou"..., 33 to wait for clock tick timed out) = 33
write(2, ": ", 2: )                       = 2
write(2, "No such file or directory", 25No such file or directory) = 25
write(2, "\n", 1
)                       = 1
ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  = 0
close(3)                                = 0
exit_group(74)                          = ?








QUICK analyses  ( could be wrong) ? 
It seems that hwclock is reading the current-timestamp 3 times and if not changed in those 3 read cycles? it sets up an read-interrupt-abort able time reader that should return as soon as the irq fires? but this seems to be missing !

FYI:  I?ve been using following commint to enable srtc.
commit 5b725054147deaf966b3919e10a86c6bfe946a18
Author: Patrick Bruenn <p.bruenn@beckhoff.com>
Date:? ?Wed Jul 26 14:05:32 2017 +0200

? ? ARM: dts: imx53: add srtc node
? ??
? ? The i.MX53 has an integrated secure real time clock. Add it to the dtsi.
? ??
? ? Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
? ? Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 2e516f4..8bf0d89 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -433,6 +433,15 @@
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clock-names = "ipg", "per";
? ? ? ? ? ? ? ? ? ? ? ? };
?
+? ? ? ? ? ? ? ? ? ? ? ?srtc: srtc at 53fa4000 {
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x53fa4000 0x4000>;
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?interrupts = <24>;
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?interrupt-parent = <&tzic>;
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clocks = <&clks IMX5_CLK_SRTC_GATE>;
+? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clock-names = "ipg";
+? ? ? ? ? ? ? ? ? ? ? ?};
+

Best Regards
Noel

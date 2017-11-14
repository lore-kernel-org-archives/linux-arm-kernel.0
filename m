From: Noel.Vellemans@visionBMS.com (Vellemans, Noel)
Date: Tue, 14 Nov 2017 06:40:55 +0000
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net>
 <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
Message-ID: <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI all,

I've been digging a while in the DryIce code (some time ago, it was in a hurry because I needed to release).

I finally ended up by NOT using the DryIce code , for the IMX53 ( internal RTC)

If I recall correctly , this is not the correct driver for the Internal IMX53 RTC, ( for example the register BASE-Addresses / offsets are not correct..) 
resulting in all kind of strange behavior, depending on your situational use-cases:-(




Best Regards
Noel

_______________________
Noel Vellemans
BMS bvba

-----Original Message-----
From: Patrick Br?nn [mailto:P.Bruenn at beckhoff.com] 
Sent: Tuesday, November 14, 2017 6:00 AM
To: Fabio Estevam; Alexandre Belloni
Cc: Vellemans, Noel; linux-arm-kernel at lists.infradead.org; linux-rtc at vger.kernel.org
Subject: RE: DryIce , RTC not working on imx53.

>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Montag, 13. November 2017 19:57
>> I don't recall of any recent change in this area.
>>
I don't think the behavior changed recently. I tried a kernel 4.4.65 and it shows the same symptoms. I guess Noel really means 3.19-> 4.0.

>> Patrick/Noel,
>>
>> Does the change below help?
Unfortunately no. Did you run hwclock or rtctest?
I still see:
root at CX9020:~# cat /proc/interrupts | grep rtc
 40:          0      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc
root at CX9020:~# hwclock -D -r
hwclock from util-linux 2.29.2
Using the /dev interface to the clock.
Last drift adjustment done at 1490885082 seconds after 1969 Last calibration done at 1490885082 seconds after 1969 Hardware clock is on UTC time Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
[   41.035269] irq 40: nobody cared (try booting with the "irqpoll" option)
[   41.042514] handlers:
[   41.044847] [<c06031e0>] dryice_irq
[   41.048398] Disabling IRQ #40
select() to /dev/rtc to wait for clock tick timed out...synchronization failed root at CX9020:~# cat /proc/interrupts | grep rtc
 40:     100000      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc


or if I run rtctest from tools/testing/selftests/timers/ (after reboot):

root at CX9020:~# cat /proc/interrupts | grep rtc
 40:          0      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc
root at CX9020:~# ./rtctest

                        RTC Driver Test Example.

Counting 5 update (1/sec) interrupts from reading /dev/rtc0:[   37.550399] irq 40: nobody cared (try booting with the "irqpoll" option)
[   37.557646] handlers:
[   37.559980] [<c06031e0>] dryice_irq
[   37.563532] Disabling IRQ #40
^C
root at CX9020:~# cat /proc/interrupts | grep rtc
 40:     100000      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc


With the attached patch I get rid of the unhandled interrupts. But that patch just ACKs everything.
 root at CX9020:~# cat /proc/interrupts | grep rtc
 40:          0      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc
root at CX9020:~# hwclock -D -r
hwclock from util-linux 2.29.2
Using the /dev interface to the clock.
Last drift adjustment done at 1490885082 seconds after 1969 Last calibration done at 1490885082 seconds after 1969 Hardware clock is on UTC time Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
select() to /dev/rtc to wait for clock tick timed out...synchronization failed root at CX9020:~# cat /proc/interrupts | grep rtc
 40:     301844      tzic  24 Edge      53fa4000.srtc
 41:          0      tzic  25 Edge      53fa4000.srtc

>From 422747686f5723ac75b98ad610b3ef4d94ef271f Mon Sep 17 00:00:00 2001
From: Patrick Bruenn <p.bruenn@beckhoff.com>
Date: Tue, 14 Nov 2017 05:23:24 +0100
Subject: [PATCH] XXX: disable interrupts manually

---
 drivers/rtc/rtc-imxdi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c index 80931114c899..4b64a5350bac 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -686,6 +686,24 @@ static irqreturn_t dryice_irq(int irq, void *dev_id)
        dier = readl(imxdi->ioaddr + DIER);
        dsr = readl(imxdi->ioaddr + DSR);

+       /* ack monotonic counter overflow */
+       if (DSR_MCO == dsr) {
+               return IRQ_HANDLED;
+       }
+       if (dier & DIER_WCIE) {
+               if (dsr & DSR_MCO) {
+                       di_int_disable(imxdi, DIER_WCIE);
+                       return IRQ_HANDLED;
+               }
+       }
+
+       if (dier & DIER_CAIE) {
+               if (dsr & DSR_MCO) {
+                       di_int_disable(imxdi, DIER_CAIE);
+                       return IRQ_HANDLED;
+               }
+       }
+
        /* handle the security violation event */
        if (dier & DIER_SVIE) {
                if (dsr & DSR_SVF) {
@@ -710,7 +728,10 @@ static irqreturn_t dryice_irq(int irq, void *dev_id)
                  operations. It means the interrupt is for DryIce -Security.
                  IRQ must be returned as none.*/
                if (list_empty_careful(&imxdi->write_wait.head))
+               {
+                       printk("rtc: XXXX: dier: 0x%x dsr: 0x%x\n", 
+ dier, dsr);
                        return rc;
+               }

                /* DSR_WCF clears itself on DSR read */
                if (dsr & (DSR_WCF | DSR_WEF)) { @@ -737,6 +758,9 @@ static irqreturn_t dryice_irq(int irq, void *dev_id)
                        rc = IRQ_HANDLED;
                }
        }
+       if (rc != IRQ_HANDLED) {
+               printk("rtc: XXXX: dier: 0x%x dsr: 0x%x\n", dier, dsr);
+       }
        return rc;
 }

--
2.11.0
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff Registered office: Verl, Germany | Register court: Guetersloh HRA 7075

From: pintu.ping@gmail.com (Pintu Kumar)
Date: Fri, 11 May 2018 17:07:37 +0530
Subject: Delivery Status Notification (Failure)
In-Reply-To: <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
References: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
 <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
 <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
Message-ID: <CAOuPNLgbT59h=Jm5YiOCbrqFkDokJ8xutQ_OkpsFYzKazKhTHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I need one help.
I am using i.MX7 Sabre board with kernel version 4.1.15

Let's say I am interested in GPIO number: 21
I wanted to set CPU affinity for particular GPIO->IRQ number, so I
tried the below steps:
root at 10:~# echo 21 > /sys/class/gpio/export
root at 10:~# echo "rising" > /sys/class/gpio/gpio21/edge
root at 10:~# cat /proc/interrupts | grep 21
  47: 0 0 gpio-mxc 21 Edge gpiolib
root at 10:~# cat /sys/class/gpio/gpio21/direction
in
root at 10:~# cat /proc/irq/47/smp_affinity
3
root at 10:~# echo 2 > /proc/irq/47/smp_affinity
-bash: echo: write error: Input/output error

But I get input/output error.
When I debug further, found that irq_can_set_affinity is returning 0:
[    0.000000] genirq: irq_can_set_affinity (0): balance: 1,
irq_data.chip: a81b7e48, irq_set_affinity:   (null)
[    0.000000] write_irq_affinity: FAIL

I also tried first setting /proc/irq/default_smp_affinity to 2 (from 3).
This change is working, but the smp_affinity setting for the new IRQ
is not working.

When I try to set smp_affinity for mmc0, then it works.
# cat /proc/interrupts | grep mmc
295:         55          0     GPCV2  22 Edge      mmc0
296:          0          0     GPCV2  23 Edge      mmc1
297:         52          0     GPCV2  24 Edge      mmc2

root at 10:~# echo 2 > /proc/irq/295/smp_affinity
root at 10:~#


So, I wanted to know what are the conditions for which setting
smp_affinity for an IRQ will work ?

Is there any way by which I can set CPU affinity to a GPIO -> IRQ ?
Whether, irq_set_affinity_hint() will work in this case ?


Thanks,
Pintu

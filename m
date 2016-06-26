From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 26 Jun 2016 18:00:41 +0200
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
Message-ID: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've just spend most of my Sunday debugging a problem
where Allwinner ARM SoC based boards will not shutdown when
using a Fedora 24 userland, where as the exact same
kernel works fine with Fedora 22.

It turns out that irq-balanced is to blame. In Fedora 24
it pins the i2c controller, which talks to the pmic
which is needed for poweroff to cpu-id 1:

[root at localhost ~]# cat /proc/irq/49/smp_affinity
2

Where as the reboot_cpu is cpu-id 0 and with
cpu 1 disabled at poweroff time, the i2c transfer
never gets past its first step leading to an i2c
driver timeout + kernel panic due to machine_power_off()
returning.

As a workaround I can stop irq-balanced and do:

echo 3 > /proc/irq/49/smp_affinity

Before doing poweroff and then everything works as
expected again.

Now the question is how to fix this?

IMHO this is a kernel-bug, if we disable CPU-s then we
should unpin any irqs pinned to them before doing so.

If someone can write a fix for this I will be more then
happy to test it.

Although I'm mostly unfamiliar with the irq code I'm also
willing to try and write a fix myself, assuming that
people agree that this is the right thing to-do, and
that I can get some hints where to start.

Regards,

Hans



p.s.

I also noticed the following in the arm reboot code:

void machine_power_off(void)
{
         local_irq_disable();
         smp_send_stop();

         if (pm_power_off)
                 pm_power_off();
}

And I cannot help but wonder what re-enables local-irqs ?
Clearly something does as they are needed for the i2c
communication done by the m_power_off() call.

From: radoslav.kolev@rnd.bg (Radoslav Kolev)
Date: Fri, 22 Oct 2010 01:30:57 +0300
Subject: imx: PWM module on mx35
Message-ID: <1287700257.4822.29.camel@rado-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to use the PWM module on a Freescale MX35 SOC but all writes
to the PWM module registers seem to be ignored.

I have found two issues reported as fixed in the changelog of
Freescales's Linux BSP for the i.MX31ADS (with similar PWM module) at
http://www.freescale.com/files/soft_dev_tools/doc/support_info/BSPIMX31ADSLTIB__RN.txt

851     Unable to write to PWM registers
1438	Cannot write to PWM registers

Unfortunately I couldn't find any more info about how/where these issues
were fixed or find the issues in some public issue tracking system.

I added this code to the plat-mxc/pwm.c module after request_mem and
ioremap of the PWM registers to make a simple test writing to the period
register:

//read value of period register and print to console
reg=ioread32(pwm->mmio_base+0x10);
printk("PWMPR1: %lx \n", reg);

//write new value
iowrite32(0x123, pwm->mmio_base+0x10);

//read value and print to console
reg=ioread32(pwm->mmio_base + 0x10);
printk("PWMPR2: %lx \n", reg);


Which yields the following output:

PWMPR1: fffe 
PWMPR2: fffe 

According to the MX35 reference manual 0xfffe is exactly the default
reset value of the PWM period register, so it seems I'm accessing the
right register and reads work fine, but all writes are ignored. It is
the same with other registers like PWM control register.

Any ideas, pointers to possible cause of this problem or just sharing if
you have been (un)successful using the PWM module on the MX35 will be
greatly appreciated.

Best regards,
Radoslav Kolev

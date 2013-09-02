From: drasko.draskovic@gmail.com (Drasko DRASKOVIC)
Date: Mon, 2 Sep 2013 19:02:59 +0200
Subject: Socfpga timer1 activation
Message-ID: <CAEk6gTDuqB2pKCw-Ht0RW9d2B2tsQYSCAQm8Y-O=gGbFNXnE5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
In socfpga.dts I can see following definitions :

/* Local timer */
timer at fffec600 {
compatible = "arm,cortex-a9-twd-timer";
reg = <0xfffec600 0x100>;
interrupts = <1 13 0xf04>;
};

timer0: timer0 at ffc08000 {
compatible = "snps,dw-apb-timer-sp";
interrupts = <0 167 4>;
reg = <0xffc08000 0x1000>;
};

timer1: timer1 at ffc09000 {
compatible = "snps,dw-apb-timer-sp";
interrupts = <0 168 4>;
reg = <0xffc09000 0x1000>;
};

timer2: timer2 at ffd00000 {
compatible = "snps,dw-apb-timer-osc";
interrupts = <0 169 4>;
reg = <0xffd00000 0x1000>;
};

timer3: timer3 at ffd01000 {
compatible = "snps,dw-apb-timer-osc";
interrupts = <0 170 4>;
reg = <0xffd01000 0x1000>;
};


However, from my board's shell :
root at socfpga_cyclone5:~# cat /proc/interrupts
           CPU0       CPU1
525:      24935      24717       GIC  twd
648:        801          0       GIC  eth0
653:          0          0       GIC  dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1
656:          0          0       GIC  dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb2
667:     163006          0       GIC  dw-mci
679:          0          0       GIC  ff705000.spi
682:          0          0       GIC  dw_spi0
684:          0          0       GIC  dw_spi1
686:          6          0       GIC  ffc04000.i2c
687:          0          0       GIC  ffc05000.i2c
690:       2390          0       GIC  serial
697:          9          0       GIC  timer2
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       1268       1289  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:          3          1  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
Err:          0

So, I can see only timer2.

root at socfpga_cyclone5:~# find / -name "timer*"
/proc/timer_list
/proc/device-tree/soc/timer3 at ffd01000
/proc/device-tree/soc/timer2 at ffd00000
/proc/device-tree/soc/timer1 at ffc09000
/proc/device-tree/soc/timer0 at ffc08000
/proc/device-tree/soc/timer at fffec600
/proc/device-tree/aliases/timer3
/proc/device-tree/aliases/timer2
/proc/device-tree/aliases/timer1
/proc/device-tree/aliases/timer0
/sys/kernel/debug/tracing/events/timer
/sys/kernel/debug/tracing/events/timer/timer_cancel
/sys/kernel/debug/tracing/events/timer/timer_expire_exit
/sys/kernel/debug/tracing/events/timer/timer_expire_entry
/sys/kernel/debug/tracing/events/timer/timer_start
/sys/kernel/debug/tracing/events/timer/timer_init
/sys/module/oprofile/parameters/timer
root at socfpga_cyclone5:~#

Where is defined which timer will be present, activated and
initialized on the board - i.e. only timer2 is active in this case,
and I would like to use timer1.

BR,
Drasko

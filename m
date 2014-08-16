From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Aug 2014 13:01:15 -0300
Subject: [RFC] usb issue on imx27: 3 clocks are needed
In-Reply-To: <53EF7AF6.2000405@gmail.com>
References: <53EF7AF6.2000405@gmail.com>
Message-ID: <CAOMZO5CSGUp5qsgtDtqdoVq69EGmxV=quDD0CBSvHiOL5JNiwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Sat, Aug 16, 2014 at 12:38 PM, Philippe Reynes <tremyfr@gmail.com> wrote:
> Hi all,
>
> i.MX27's usb needs three clocks (usb_ipg_gate, usb_ahb_gate and usb_div)
> but the current chipidea driver implementation, and devicetree, provides
> only ipg and ahb. Consequently, if the bootloader don't enable the last
> one, the kernel will crash.

Which kernel version and what is the crash log you are getting?

I used to get a USB crash on mx27, which was fixed with the following commit:

commit b67b19447eb4f60d4f004f48298154630d4bed39
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Wed Apr 16 14:53:18 2014 -0300

    ARM: dts: imx27: Use the correct usb clock gate

    USB Host1, Host2 and OTG are gated via 'usb_ipg_gate' clock, so
fix it in order
    to avoid the following kernel oops:

    usbcore: registered new interface driver usb-storage
    10024000.usb supply vbus not found, using dummy regulator
    Unhandled fault: external abort on non-linefetch (0x808) at 0xf4424184
    Internal error: : 808 [#1] PREEMPT ARM
    Modules linked in:
    CPU: 0 PID: 1 Comm: swapper Not tainted 3.15.0-rc1-26325-g971f9fd-dirty #64
    task: c7829aa0 ti: c7836000 task.ti: c7836000
    PC is at ci_hdrc_probe+0x3a4/0x634
    LR is at ci_hdrc_probe+0x100/0x634
    pc : [<c036cc78>]    lr : [<c036c9d4>]    psr: 60000013
    sp : c7837d48  ip : 00000001  fp : 00000000
    r10: 00000000  r9 : 00000000  r8 : c791b6c0
    r7 : c7945000  r6 : f4424000  r5 : c7945010  r4 : c794e010
    r3 : f4424184  r2 : 00000000  r1 : 8c000004  r0 : 0c000004
    Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
    Control: 0005317f  Table: a0004000  DAC: 00000017
    Process swapper (pid: 1, stack limit = 0xc78361c0)
    Stack: (0xc7837d48 to 0xc7838000)

    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Do you have this one applied?

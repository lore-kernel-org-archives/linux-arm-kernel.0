From: holgerschurig@gmail.com (Holger Schurig)
Date: Thu, 17 Jul 2014 10:22:12 +0200
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
In-Reply-To: <20140716183904.GQ21766@n2100.arm.linux.org.uk>
References: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
 <20140716095850.GO21766@n2100.arm.linux.org.uk>
 <CAOpc7mGrZXbr-cytzSHLUjgoYz88ZFeuv2g0kJ2kzOnbF7Uz5g@mail.gmail.com>
 <20140716183904.GQ21766@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mHZZz-mxEKuoyoWtz7a=X=gDdQ7TVCDCZFYcR0+DYFSeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's good that you didn't invest too much time, because I found the
real culprit.

I wanted to trigger the "clock from phy" code path in
imx6q_1588_init() (arch/arm/mach-imx/mach-imx6q.c). This is done in
weird way: the code checks the 3rd clock in the DTS somehow.

So I removed the 3rd clock in my dts, e.g. making it:

&fec {
    status = "okay";
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_fec>;
    phy-mode = "rmii";
    phy-reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
    clocks = <&clks 117>, <&clks 117>;
    clock-names = "ipg", "ahb";
};

And as soon as I make that, the TCP checksumming doesn't work. When I
remove that manual-clock-assignment it (so that the default get's
active), tcp checksumming works. That I told you it works with wmb()
was in error, because I changed several things at once (grave
debugging error....  shame on me!).

Now if the TCP checksumming code in the chip depends the ptp clock,
then no code part should check if it is set to something else. So I
guess imx6q_1588_init() is actualy buggy by checking for dtsclock[2]
!= ptp_clk.

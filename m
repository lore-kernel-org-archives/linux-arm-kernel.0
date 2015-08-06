From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Aug 2015 19:13:12 +0200
Subject: Armadaxp GPIO interrupts
In-Reply-To: <CAG1O52XUyPkgTTRKftujZBNK1=n6GBdWgBg_kq6SsC5XMaeU3w@mail.gmail.com>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
 <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
 <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
 <20150805162155.GE32760@lunn.ch>
 <CAG1O52WPFfm+XGk01iUVWLu=-Dm7bcDVmhv3P8iQDH+HHjsLUA@mail.gmail.com>
 <20150806132926.GB19896@lunn.ch>
 <CAG1O52XUyPkgTTRKftujZBNK1=n6GBdWgBg_kq6SsC5XMaeU3w@mail.gmail.com>
Message-ID: <20150806171312.GI13421@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:28:12PM +0530, raghu MG wrote:
> Ok,I think I need to understand more about this gpio driver.
> 
> As you said its registering chained handler,but why are they(IRQs) not
> visible in cat /proc/interrupts.

chained interrupts are never visible there. All you see are leaf
interrupts, i.e. the device interrupts. Here is my Armada XP based
WRT1900AC:

$ cat /proc/interrupts 
            CPU0       CPU1       
 16:    8959833   12783597  armada_370_xp_irq   5 Level     armada_370_xp_per_cpu_tick
 19:          0          0  armada_370_xp_irq  31 Level     mv64xxx_i2c
 20:       1453          0  armada_370_xp_irq  41 Level     serial
 26:          0          0  armada_370_xp_irq  45 Level     ehci_hcd:usb3
 27:       9682          0  armada_370_xp_irq   8 Level     mvneta
 28:          4          0  armada_370_xp_irq  10 Level     mvneta
 29:      35078          0  armada_370_xp_irq  55 Level     f10a0000.sata
 30:       3839          0  armada_370_xp_irq 113 Level     f10d0000.nand
 70:          0          0  f1018140.gpio   0 Edge      WPS
 71:         20          0  f1018140.gpio   1 Edge      Factory Reset Button
 90:          2          0  armada_370_xp_irq  51 Level     f1060900.xor
 91:          2          0  armada_370_xp_irq  52 Level     f1060900.xor
 92:          2          0  armada_370_xp_irq  94 Level     f10f0900.xor
 93:          2          0  armada_370_xp_irq  95 Level     f10f0900.xor
 94:          0          0  armada_370_xp_msi_irq   0 Edge      xhci_hcd

Notice the two f1018140.gpio, which are the buttons.

> Do I need to further initialize marvell GPIO registers to trigger
> these events.

Nope, just the normal gpio API and all will work, as demonstrated by
the two buttons on my board.

> Do I need to change the polarity in polarity register to suit the
> board requirements in probe function.

Nope, you put that in the DT file:

        gpio_keys {
                compatible = "gpio-keys";
                #address-cells = <1>;
                #size-cells = <0>;
                pinctrl-0 = <&keys_pin>;
                pinctrl-names = "default";

                button at 1 {
                        label = "WPS";
                        linux,code = <KEY_WPS_BUTTON>;
                        gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
                };

                button at 2 {
                        label = "Factory Reset Button";
                        linux,code = <KEY_RESTART>;
                        gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
                };
        };

You can change GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW if that is what you
need.

	Andrew
 

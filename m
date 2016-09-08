From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 15:23:53 +0200
Subject: [PATCH 0/6] SA11x0 serial updates
In-Reply-To: <20160905122810.GP1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
 <20160829120531.GG1041@n2100.armlinux.org.uk>
 <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
 <20160905122810.GP1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdYgXYP-Ev-KB+iewqz=W4QhQEmo33sBQC37rJSTu54vFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2016 at 2:28 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Sep 05, 2016 at 11:09:38AM +0200, Linus Walleij wrote:
>> On Mon, Aug 29, 2016 at 2:05 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>
>> > This series converts SA11x0 serial to make use of the mctrl helpers
>> > where appropriate.  This allows us to remove several board-specific
>> > callbacks.
>>
>> >From GPIO and H3600 point of view:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks - did you check that the appropriate GPIOs were claimed for
> serial in gpio's debugfs?

Yes that works like a charm. I have some problems with the
PCMCIA GPIOs as it turns out but that is all.

GPIO before (v4.8-rc3):

cat gpio
gpiochip0: GPIOs 0-27, gpio:
 gpio-0   (                    |Power Button        ) in  hi
 gpio-10  (                    |PCMCIA CD1          ) in  hi
 gpio-11  (                    |PCMCIA IRQ1         ) in  hi
 gpio-17  (                    |PCMCIA CD0          ) in  hi
 gpio-18  (                    |Action button       ) in  hi
 gpio-21  (                    |PCMCIA IRQ0         ) in  hi
 gpio-23  (                    |COM DCD             ) in  hi
 gpio-25  (                    |COM CTS             ) in  lo
 gpio-26  (                    |COM RTS             ) out lo

gpiochip1: GPIOs 28-43, parent: platform/htc-egpio, htc-egpio:
 gpio-28  (                    |Flash Vpp           ) out lo
 gpio-29  (                    |PCMCIA CARD RESET   ) out lo
 gpio-30  (                    |OPT RESET           ) out lo
 gpio-32  (                    |OPT NVRAM ON        ) out lo
 gpio-33  (                    |OPT ON              ) out lo
 gpio-34  (                    |LCD power           ) out lo
 gpio-36  (                    |LCD control         ) out lo
 gpio-42  (                    |LCD 5v              ) out lo
 gpio-43  (                    |LCD 9v/-6.5v        ) out lo

After:

cat gpio
gpiochip0: GPIOs 0-27, gpio:
 gpio-0   (                    |Power Button        ) in  hi
 gpio-18  (                    |Action button       ) in  hi
 gpio-23  (                    |dcd                 ) in  hi
 gpio-25  (                    |cts                 ) in  lo
 gpio-26  (                    |rts                 ) out lo

gpiochip1: GPIOs 28-43, parent: platform/htc-egpio, htc-egpio:
 gpio-28  (                    |Flash Vpp           ) out lo
 gpio-34  (                    |LCD power           ) out lo
 gpio-36  (                    |LCD control         ) out lo
 gpio-42  (                    |LCD 5v              ) out lo
 gpio-43  (                    |LCD 9v/-6.5v        ) out lo

As you can see all but the PCMCIA GPIOs are playing well
with the new setup.

Once this stuff is upstream I can attempt to convert the rest of
GPIOs on the h3xxx to use descriptors.

Yours,
Linus Walleij

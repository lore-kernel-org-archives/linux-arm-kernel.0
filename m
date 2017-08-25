From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Aug 2017 10:32:44 +0200
Subject: [patch v6 0/3] JTAG driver introduction
In-Reply-To: <CAPLgG==Jj=Ys=SvhOCspSfunbWnuqPySvW9RfuqE8HYnG4C=ZQ@mail.gmail.com>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
 <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
 <CAPLgG==Jj=Ys=SvhOCspSfunbWnuqPySvW9RfuqE8HYnG4C=ZQ@mail.gmail.com>
Message-ID: <CACRpkdbozWaL0RXyZXjzxYK3JHiqYziSkTGSgGORdptX-rwR8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 11:37 PM, Rick Altherr <raltherr@google.com> wrote:
> On Thu, Aug 24, 2017 at 2:07 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Aug 22, 2017 at 6:10 PM, Oleksandr Shamray
>> <oleksandrs@mellanox.com> wrote:
>>
>>> SoC which are not equipped with JTAG master interface, can be built
>>> on top of JTAG core driver infrastructure, by applying bit-banging of
>>> TDI, TDO, TCK and TMS pins within the hardware specific driver.
>>
>> I guess you mean it should then use GPIO lines for bit-banging?
>>
>> I was wondering about how some JTAG clients like openOCD does
>> this in some cases.
>
> Many common uses of OpenOCD leverage USB devices, such as FTDI FT232R,
> that have a command queue for bitbanging operations.  Managing these
> via libusb is ugly but platform-agnostic.

Incidentally, people are sending patches to expose the FTDI
expanders as common GPIO chips under Linux, so we can
internally in the kernel or from the usersapce character device
access them as "some GPIOs".

>> In my worst nightmare they export GPIO lines using
>> the horrid ABI in /sys/gpio/*
>
> https://sourceforge.net/p/openocd/code/ci/v0.10.0/tree/src/jtag/drivers/sysfsgpio.c

Gnah!
Whoever writes a slot-in replacement making the character device
take precendence wins lots of karma.

> While that is certainly horrible (and slow), mapping in the GPIO
> registers via /dev/mem strikes me as worse:
>
> https://sourceforge.net/p/openocd/code/ci/v0.10.0/tree/src/jtag/drivers/bcm2835gpio.c

Yeah that is quite horrible.

There were reasons to do things like that, but since we have
developed .set_multiple() to hammer several lines in a register
at once, the same efficiency can be achieved using the standard
character device.

Yours,
Linus Walleij

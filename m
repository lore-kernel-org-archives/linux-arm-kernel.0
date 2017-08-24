From: raltherr@google.com (Rick Altherr)
Date: Thu, 24 Aug 2017 14:37:06 -0700
Subject: [patch v6 0/3] JTAG driver introduction
In-Reply-To: <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
 <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
Message-ID: <CAPLgG==Jj=Ys=SvhOCspSfunbWnuqPySvW9RfuqE8HYnG4C=ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 2:07 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Aug 22, 2017 at 6:10 PM, Oleksandr Shamray
> <oleksandrs@mellanox.com> wrote:
>
>> SoC which are not equipped with JTAG master interface, can be built
>> on top of JTAG core driver infrastructure, by applying bit-banging of
>> TDI, TDO, TCK and TMS pins within the hardware specific driver.
>
> I guess you mean it should then use GPIO lines for bit-banging?
>
> I was wondering about how some JTAG clients like openOCD does
> this in some cases.
>

Many common uses of OpenOCD leverage USB devices, such as FTDI FT232R,
that have a command queue for bitbanging operations.  Managing these
via libusb is ugly but platform-agnostic.

> In my worst nightmare they export GPIO lines using
> the horrid ABI in /sys/gpio/*
>

https://sourceforge.net/p/openocd/code/ci/v0.10.0/tree/src/jtag/drivers/sysfsgpio.c

While that is certainly horrible (and slow), mapping in the GPIO
registers via /dev/mem strikes me as worse:

https://sourceforge.net/p/openocd/code/ci/v0.10.0/tree/src/jtag/drivers/bcm2835gpio.c

> In best case they use the GPIO character device or even
> libgpiod.
>
> But having a JTAG abstraction inside the kernel that can
> grab a few lines for JTAG defined in a device tree, ACPI DSDT
> or similar makes sense too, as it abstracts the hardware so the
> JTAG client can then just open whatever /dev/jtag0 is on the machine
> and go ahead without having to bother about what GPIO lines
> are connected exactly where.
>
> Yours,
> Linus Walleij

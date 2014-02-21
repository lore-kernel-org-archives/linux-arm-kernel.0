From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 21 Feb 2014 11:27:43 +0530
Subject: I2C dummy adapter driver ?
In-Reply-To: <5305382E.9050902@gmail.com>
References: <5305382E.9050902@gmail.com>
Message-ID: <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2014 04:33, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> Hi All,
>
> I was wondering whether it would be reasonable to create a generic
> Linux dummy I2C bus controller driver. The rationale behind it is
> there might be hardware configurations where I2C communication is
> handled by firmware but still it is useful to have I2C slave devices
> instantiated by a Linux I2C bus adapter driver.
> It would be useful to have the common devicetree I2C binding scheme
> working regardless of where the I2C communication is handled - in
> firmware or by the host CPU.
>
> Currently we have a somewhat dummy I2C adapter driver at drivers/media/
> platform/exynos4-is/fimc-is-i2c.c.
>
The driver does seem 'dummy' because it doesn't implement the
i2c_algorithm.master_xfer()
Perhaps your remote f/w contains the client driver for the slave chip
and it abstracts out the controls for you over mailbox? If so, I think
you can do even without this dummy driver.

OTOH if the remote doesn't know how to drive the slave and it simply
read/write the registers over i2c just as you ask it over mailbox,
then we do need a 'virtual pass-through' driver that maps Linux I2C
API onto remote's api in the i2c_algorithm.master_xfer()  Such a
virtual driver may indeed be shared across platforms but if it works
over some common mailbox api. (my platform will share that with yours)

Cheers,
Jassi

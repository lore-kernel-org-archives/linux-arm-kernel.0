From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Jun 2014 14:27:49 +0200
Subject: [PATCH] ARM: integrator: fix section mismatch problem
In-Reply-To: <20140604105657.GA23430@n2100.arm.linux.org.uk>
References: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
 <20140604105657.GA23430@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYfcNJ0DdK8Hto0TiXDUES4SSGT_qv6PU56xA9O=WFFVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 12:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 04, 2014 at 12:53:22PM +0200, Linus Walleij wrote:
>> However the module driver model of the Integrator LM bus
>> assumes that logic tile drivers can be probed at runtime. This
>> is not really the case for IM-PD1: these tiles are detected at
>> boot and they cannot be plugged into a running system. Before
>> this patch it is of course possible to modprobe them later.
>
> Check whether you can bind/unbind the driver via sysfs.  Merely making
> stuff non-modular is really just a hack around this problem where the
> device model can be used to bind/unbind devices.

I first attempted to approach the problem using the pattern from
platform_device_probe() which allows to have a discardable probe()
function in a platform_driver.

In that case the sysfs bind/unbind problem is handled like so:

       /* make sure driver won't have bind/unbind attributes */
        drv->driver.suppress_bind_attrs = true;

So the support of sysfs bind/unbind for a certain driver is somewhat
optional, really.

I will try the approach to set this for the IM-PD1 driver.

Yours,
Linus Walleij

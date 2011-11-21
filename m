From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Nov 2011 08:47:51 +0100
Subject: [RFC][PATCH] gpiolib: add irq_wake (power-management) sysfs file
In-Reply-To: <1321004406-15663-1-git-send-email-p-combes@ti.com>
References: <1321004406-15663-1-git-send-email-p-combes@ti.com>
Message-ID: <CACRpkdbo0CRQTYYS2C3XdoP+43VX9TyVnXf4LwS6e1a+BMyAzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 10:40 AM, Patrick Combes <p-combes@ti.com> wrote:

> This patch creates a new sysfs file /sys/class/gpio/gpioN/irq_wake to enable
> usermode application to set the wake properties of a gpio IRQ.
> This option can be set or not for each gpio to preserve power consumption (e.g
> embedded systems).
(...)
> + ? ? ? if (!test_bit(FLAG_EXPORT, &desc->flags))
> + ? ? ? ? ? ? ? status = -EIO;
> + ? ? ? else if (sysfs_streq(buf, "enable") || sysfs_streq(buf, "1"))
> + ? ? ? ? ? ? ? status = enable_irq_wake(gpio_to_irq(gpio));
> + ? ? ? else if (sysfs_streq(buf, "disable") || sysfs_streq(buf, "0"))
> + ? ? ? ? ? ? ? status = disable_irq_wake(gpio_to_irq(gpio));
> + ? ? ? else
> + ? ? ? ? ? ? ? status = -EINVAL;

As noted elsewhere, human-readable files go into debugfs.

sysfs rule is one file, one value.

Create a file ile named "irq_wakeup_enable" that works
like this:

cat wakeup_enable
0
echo 1 > wakeup_enable
cat wakeup_enable
1

Also document you new ABI in
Documentation/ABI/testing/*
and preferabley write some new words on it
in Documentation/gpio.txt too.

Thanks!
Linus Walleij

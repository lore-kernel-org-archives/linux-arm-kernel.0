From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 18:28:06 +0200
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
References: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
Message-ID: <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 10:44 PM, Gottfried Haider
<gottfried.haider@gmail.com wrote:

> I'll hopefully find time to look at the more recent changes to the gpio
> subsystem (lsgpio?!), but since this patch is up for discussion now - what I
> was wondering: how does this change relate to /sys/class/gpio/gpio%d? Is
> this completely orthogonal - or would this change the sysfs interface as
> well?

The old sysfs interface is not changing. However it is deprecated so once
you have a v4.8+ kernel, consider migrating whatever userspace you have
to use the chardev ABI instead.

See:
commit fe95046e960b4b76e73dc1486955d93f47276134
"gpio: ABI: mark the sysfs ABI as obsolete"
commit 521a2ad6f862a28e2e43cb3e254a26bf0f9452e9
"gpio: add userspace ABI for GPIO line information"
commit d7c51b47ac11e66f547b55640405c1c474642d72
"gpio: userspace ABI for reading/writing GPIO lines"
commit 61f922db72216b00386581c851db9c9095961522
"gpio: userspace ABI for reading GPIO line events"

> Regarding the proposed format using the header pin numbers: From what I've
> seen in terms of existing educational materials, it seems the overwhelming
> majority ends up using GPIO numbers instead of physical pin header
> numbering. (e.g. [1] [2])

What does that number mean? If you are referring to the global
GPIO numberspace it is obsolete and just reflecting the fact that
people up until now was referring to Linux-internal GPIO numbers.

> Would it be too confusing to try to pick GPIO 5 from an alphabetically
> sorted list like this "P11_GPIO17", "P12_GPIO18"? (I know, alphabetical
> sorting is an issue here already for a different reason. But applications
> might do it, I guess?)

Any attempt to preserve the global GPIO numberspace is futile.
If it is the local offset number on the chip it is another thing, that
is kind of OK if the arch maintainer likes it.

Global GPIO numbers are inherently inconsistent since the introduction
of deferred probe, as GPIO drivers often pick a dynamic number base
and thus end up with the same number even though that can depend on
things like cosmic radiation or the temperature of their board when
they boot. So global GPIO numbers are considered harmful and have
therefore been obsoleted as userspace ABI.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 25 Jun 2011 23:04:39 +0200
Subject: [PATCH 1/3] leds: create a trigger for ARM CPU activity
In-Reply-To: <BANLkTikt3YRO1fYRZNzHpygZxRdxK4x-bA@mail.gmail.com>
References: <1308763983-24749-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTikt3YRO1fYRZNzHpygZxRdxK4x-bA@mail.gmail.com>
Message-ID: <BANLkTinQ6EZ9_Bh92SZswtyTax0LSJFX+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 3:42 AM, Bryan Wu <bryan.wu@canonical.com> wrote:

> I've been thinking about moving the arm led_event interface to
> drivers/leds/. And maybe other machines can simply benefit from this
> trigger driver, since the led_event interface is actually not really
> ARM specific.
>
> So what about add a new trigger just named ledtrig-cpu.c which can be
> shared by other machines as well as ARM monsters.

Well I don't know about that. The ARM CPU LED triggers mess around
in arch/arm/kernel/process.c to insert a callback whenever the idle
state is entered or exited for a CPU in cpu_idle(). I don't know if that
is something other archs would like to copy to get working CPU usage
LED indicators.

Also leds_event is a global callback which is pretty brutal,
for example right now the driver hogs that callback, noone else can
use it. (Well if only used for CPU maybe that's natural.)

I mainly moved the machine part of this code to consolidate it, but
let's ask on LKML to see if there is some general interest in this,
for the moment I suggest we go with ARM CPU leds, it's easy enough
to amend by just renaming the file and Kconfig text the day some other
CPU wants to do this.

Linus Walleij

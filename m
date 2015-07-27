From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 12:19:08 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <20150716171930.GB27060@localhost.localdomain>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
 <20150716171930.GB27060@localhost.localdomain>
Message-ID: <CACRpkdYUcXjJz+jZ5ZMXK1a7GLi8eL+ecr-yL6Y8901f_-pknQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 7:19 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Thu, Jul 16, 2015 at 09:50:44AM +0200, Linus Walleij wrote:
>> NACK. And it has been NACKed before again and again, search
>> the mailinglist for repetitive answers.
>
> Yeah, ok, I give up.
>
> This happens with every DT discussion that tries to make things
> logical for the end user.

Are you assuming bad faith?

I'm trying to maintain the GPIO subsystem, the problem with DT
is that there are no proper DT reviewers for stuff like this, instead
the task of reviewing DT stuff is pushed down to Linux subsystem
maintainers like me.

I think Michael made a very very nice patch series trying to make
things logical for end users, please participate in that discussion.

>> The GPIO numbers inside the Linux kernel are Linux specific and
>> have nothing to do with the hardware numbers. If they sometimes
>> match it is a lucky coincidence.
>
> Someone should tell the users that.
>
>> The same goes for IRQ numbers
>> in the kernel FWIW.
>
> Isn't there a mapping interface for irq numbers?

I don't see what you mean here. The numbers that appear in
say /proc/interrupts may seem stable but they are not.
They depend on things like probe order between irqchips
and can change between two boots.

The reason users don't have an issue with it is that there is
(thank god) no userspace ABI for interrupts.

>> So this "binding" has nothing to do with describing the hardware,
>> which device tree is for. If it ever comes to exist it needs to be
>> a "linux-*" property. But I doubt it will.
>
> How can you say that the GPIO numbers associated with the pins and
> appearing in published data sheets (and used in every schematic) are
> not part of the hardware?

What the Linux kernel call GPIO numbers (or IRQ numbers for that
matter) is something different from the hardware numbers in the
datasheets. To the kernel it is just some cookie number.

In the irqchip subsystem we have ->hwirq that corresponds to
whatever the datasheet says, and which appears in the second
column i /proc/interrupts, and in the GPIO subdrivers I tend to
try to use "offset" the same way, giving a local number for that
GPIO controller.

Things were simple in the past because the GPIO numberspace
was designed under the assumption that there would be only
one GPIO controller on a system, but the exploding complexity
of systems made it unmanageable.

The problem is for example if I have a SoC with a GPIO expander:
both have a GPIO line named "0". Which one wins? The SoC
because it is "more important"? This issue is all over the place
in any modern chipset. In Ux500 I have sometimes three GPIO
expanders, all three with GPIO line 0, and also a GPIO 0 on
the SoC of course. So we need to express this complexity to
userspace, not try to simplify the world.

Yours,
Linus Walleij

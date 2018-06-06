From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 6 Jun 2018 09:02:04 +0200
Subject: panic kexec broken on ARM64?
In-Reply-To: <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
Message-ID: <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

Am 05.06.2018 um 19:46 schrieb James Morse:
> Hi Petr,
>
> (CC: +Akashi, Marc)
>
> On 05/06/18 09:01, Petr Tesarik wrote:
>> I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
>> when a panic kernel is loaded.
> kdump is a best-effort thing, it looks like this is a case where the
> crashed-kernel can't tear itself down.
>
> Do you have the rest of the stack trace? Was it handling an irq when it decided
> to panic?:
> https://lkml.org/lkml/2018/3/13/1134

the Raspberry Pi 3 B+ support is very fresh (linux-next). Since i didn't 
see a version, i need to doublecheck.

You are actually using linux-next and not the downstream kernel?

>
>> I attached a hardware debugger and found
>> out that all CPU cores were stopped except one which was stuck in the
>> idle thread. It seems that irq_set_irqchip_state() may sleep, which is
>> definitely not safe after a kernel panic.
> I don't know much about irqchip stuff, but __irq_get_desc_lock() takes a
> raw_spin_lock(), and calls gic_irq_get_irqchip_state() which is just poking
> around in mmio registers, this should all be safe unless you re-entered the same
> code.
>
>
>> If I'm right, then this is broken in general, but I have only ever seen
>> it on RPi 3 Model B+ (even RPi3 Model B works fine), so the issue may
>> be more subtle.
> Is there a hardware difference around the interrupt controller on these?
@James:
No, but the RPi 3 B has a different USB network chip on board (smsc95xx, 
Fast ethernet) instead of lan78xx (Gigabit ethernet).

Stefan

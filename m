From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 29 Jun 2011 09:30:38 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <20110628164453.aa85c85c.rdunlap@xenotime.net>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<20110628164453.aa85c85c.rdunlap@xenotime.net>
Message-ID: <BANLkTinDX9ETcqZ=hvSGaao2s=ZcM-JsAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Thanks for your comments !

On Wed, Jun 29, 2011 at 2:44 AM, Randy Dunlap <rdunlap@xenotime.net> wrote:
>> +hardware accelerators, and therefore are often used to offload cpu-intensive
>
> prefer: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? CPU-
> throughout.

Isn't that changing the meaning a bit ? Let's stick with the original
version, I think it's more clear.

>> +system's physical memory and/or other sensitive hardware resources (e.g. on
>> +OMAP4, remote cores (/hardware accelerators) may have direct access to the
>> +physical memory, gpio banks, dma controllers, i2c bus, gptimers, mailbox
>> +devices, hwspinlocks, etc..). Moreover, those remote processors might be
>> +running RTOS where every task can access the entire memory/devices exposed
>> +to the processor. To minimize the risks of rogue (/buggy) userland code
>
> What is with the leading / here and above (/hardware) and below?

/ here means "or". You can read the sentence twice, either without the
(/ ..) options or with them, and then you get two (different)
examples.

Any idea how to make it more readable ? I prefer not to drop the
second example, as it's adding information.

>> +if RPMSG
>> +
>> +# OK, it's a little counter-intuitive to do this, but it puts it neatly under
>> +# the rpmsg menu (and it's the approach preferred by the virtio folks).
>> +
>> +source "drivers/virtio/Kconfig"
>
> It seems odd to have that Kconfig file sourced in multiple places.
> Are the kconfig tools happy with that?

They are, probably because these places are mutually exclusive today:

$ git grep "drivers/virtio/Kconfig"
arch/ia64/kvm/Kconfig:source drivers/virtio/Kconfig
arch/mips/Kconfig:source drivers/virtio/Kconfig
arch/powerpc/kvm/Kconfig:source drivers/virtio/Kconfig
arch/s390/kvm/Kconfig:source drivers/virtio/Kconfig
arch/sh/Kconfig:source drivers/virtio/Kconfig
arch/tile/kvm/Kconfig:source drivers/virtio/Kconfig
arch/x86/kvm/Kconfig:source drivers/virtio/Kconfig

Now that we start using virtio for inter-processor communications,
too, we might soon bump into a situation where virtio will be sourced
twice.

Probably the solution is to move 'source "drivers/virtio/Kconfig"'
into drivers/Kconfig, and remove all other instances.

Rusty, are you ok with that ?

Thanks,
Ohad.

> Sorry about the delay. ?I had most of this in my drafts folder and
> forgot about it...

Np, thanks a lot !

Ohad.

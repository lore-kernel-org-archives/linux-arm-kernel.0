From: agraf@suse.de (Alexander Graf)
Date: Thu, 18 Apr 2013 10:51:14 +0200
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAFEAcA-38=zx-s3NaBAu-yvDNRbt=KcTs-3c1QJR3COB3G1n2A@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <ede8ee08bb2616c2ed642200e3357367@localhost>
 <CAFEAcA-38=zx-s3NaBAu-yvDNRbt=KcTs-3c1QJR3COB3G1n2A@mail.gmail.com>
Message-ID: <7C17A12D-F7C5-48ED-8D2F-22D8A7F289E3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 18.04.2013 um 10:30 schrieb Peter Maydell <peter.maydell@linaro.org>:

> On 18 April 2013 07:49, Marc Zyngier <maz@misterjones.org> wrote:
>> If you need an early console, why not simply wire the 8250 emulation in
>> kvmtool to be useable from the MMIO bus? I reckon this would solve your
>> problem in a more elegant way...
> 
> The other approach I thought of would be something involving
> defining a hypercall interface for console I/O, in the same
> way that we have hypercalls for "start cpu"/"stop cpu"/etc.
> Is there any mileage in considering that approach, or is it
> a non-starter?

It's exactly what we had for the s390-virtio machine. Virtio-console as console device plus a hypercall for early printk.

It was a mess.

Trying to inject character output that lands in machine context, where hypercalls get handled, inside of a specific virtio-console device, which owns the char output, is hard. We haven't found any good solution in qemu to layer this properly.

The closest approach to something workable was to create 2 char outputs and mux them together, like you usually would mus monitor and serial. Good luck muxing that one again with the monitor :).

I'd rather spare you guys from going through the same pain.


Alex

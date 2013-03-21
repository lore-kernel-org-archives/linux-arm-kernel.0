From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 10:16:40 +0100
Subject: Integrator PCI base dilemma
In-Reply-To: <514A4C30.9080402@gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <514A4C30.9080402@gmail.com>
Message-ID: <CACRpkdbLjhg-EuTBM4-_-xWV+_dDoA-RNo3FOUDN8Ka0w77sGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 12:54 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 03/20/2013 06:15 PM, Linus Walleij wrote:

>> - Unable to assign vga_base early since this should be a virtual
>>   address assigned really early. If I sacrifice this and try to
>>   just remap the stuff, I still run into:
>
> This could be a fixed mapping like we did for the i/o space.

Hm, can you point me to the relevant topics so I can read up on it?

> Wouldn't the drivers' ioremap create a mapping with the the memory
> space? The only user of this mapping may be VGA.

Well the VGA console is supposed to be as early as possible so
in some sense it's like an earlyprint dilemma. The way the mechanism
works right now is to give a raw pointer into the remapped
PCI non-prefetched memory, then the VGA console assumes that
the VGA device will be right there, att offset zero.

(Maybe there is some guarantee that PCI VGA devices will appear
first in that memory space, or it would be hard to do stunts like
this... I admit I haven't done much of PCI in my life.)

> For the config space, how much do you really need? You could ioremap
> this on demand. I think this issue came up before on another platform
> where the config space was very sparsely accessed.

Yes I think you're right here. So there may be a way to avoid the
big chunk of 16MiB remapping and avoid using a static offset for this.

So I end up only keeping one 16MiB remapping for the memory and
another static mapping for the I/O memoryspace.

And we basically have no way to get rid of these static maps :-/

Yours,
Linus Walleij

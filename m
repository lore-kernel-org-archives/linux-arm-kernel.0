From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 30 Dec 2009 21:03:31 -0500
Subject: [PATCH 1/2] pxa: unable to enable L2 in outer cache
In-Reply-To: <alpine.LFD.2.00.0912301302270.4177@xanadu.home>
References: <771cded00912292327r2622e514wcfdef51594da0aa3@mail.gmail.com>
	<f17812d70912300055k41b42ef6o621217ebc1a02fb0@mail.gmail.com>
	<alpine.LFD.2.00.0912301302270.4177@xanadu.home>
Message-ID: <771cded00912301803o496992c3qe7eca4101f90e3da@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 1:04 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 30 Dec 2009, Eric Miao wrote:
>
>> On Wed, Dec 30, 2009 at 3:27 PM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>> > From fced0fdf9c13155169d27310c28ebdfef218b9dc Mon Sep 17 00:00:00 2001
>> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > Date: Wed, 30 Dec 2009 09:31:47 -0500
>> > Subject: [PATCH] [ARM] pxa: unable to enable L2 in outer cache
>> >
>> > Outer cache checked whether L2 is enabled or not. If L2 isn't enabled in XSC3,
>> > it would enable L2. This operation is evil that would make system hang.
>> >
>> > In XSC3 core document, these words are mentioned in below.
>> >
>> > "Following reset, the L2 Unified Cache Enable bit is cleared. To enable the L2
>> > Cache, software may set the bit to a '1' before or at the same time as enabling
>> > the MMU. Enabling the L2 Cache after the MMU has been enabled or disabling the
>> > L2 Cache after the L2 Cache has been enabled, may result in unpredictable
>> > behavior of the processor."
>> >
>> > When outer cache is initialized, the MMU is already enabled. We couldn't enable
>> > L2 after MMU enabled.
>> >
>>
>> Yeah, whatever the manual said, it was actually tested on pxa320 and I remember
>> Nico had proposed a way to enable this by disabling MMU first and then re-enable
>> it.
>
> Yes, but doing so while the system is already running is quite tricky.
> I proposed some code at some point but since I don't have the hardware
> to test with, my code didn't work on first try.
>

Yes. Disabling MMU first and then re-enabling it with L2 is not
complex. It requires that the virtual address is same to physical
address. Since PC needs to be continued while MMU is disabled.
Otherwise, ARM core will meet unpredicated instruction error. If we
adopt this solution, we have to add this kind of map. It's too tricky,
and it's not a good implementation.

Thanks
Haojian

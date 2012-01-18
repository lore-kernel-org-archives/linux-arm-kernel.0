From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2012 11:36:06 +0100
Subject: [PATCH 2/8] dmaengine: Add flow controller information to
 dma_slave_config
In-Reply-To: <4F153A3A.7060902@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326707233.git.viresh.kumar@st.com>
 <CACRpkdY4QQK6wtB5aPU+FwdyyGq-owsDxMmxdwJVnkzdJTRs_Q@mail.gmail.com>
 <4F153A3A.7060902@st.com>
Message-ID: <CACRpkdbwZ5h15b0gBJP6xdk5TJt+CSeNRbEB8o2vzp9FbyD9AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 10:07 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 1/17/2012 2:07 PM, Linus Walleij wrote:

>> I dma_slave_config is supposed to be about info that
>>
>> 1) Must to be set-up at runtime
>
> Hmmm.. Currently if i check the comments in dmaengine.h, it is written
> as you said. But i believe its usage could be more than that.
>
> For example, how amba-pl011 use it today. Nothing dynamic, all static.

Maybe I should say that it's supposed to transfer information from
the driver to the DMA engine that:

1) The driver naturally "knows", like which physical register address
  the FIFO is in or burst width etc and the DMA engine has no
  business knowing.

2) That needs to change at runtime, like for example how the PL022
 driver request 32, 16 or 8 bit wide transfers depending on bus
 width.

I think master mode could very well be under (1). So the driver knows
if this hardware expects the DMA engine to drive the transaction or
if it's the device itself that should drive it.

So I'm starting to think like you :-)

I wonder what the default in each driver should be though?
I guess it's that the DMA engine drives it, so devcie control
is the exception, and that means the code looks good as it is.

> Actually the problem scenario is: pl011 is going to use separate DMA drivers
> (for ex: dw_dmac and pl08x) for separate platforms. Now, pl011's code shouldn't
> be dependent at all on these controllers. So, we have to pass separate data to
> these drivers using dma driver specific platform data.

OK I buy this.

> Now, its better to have some common struct in dmaengine which can fulfill
> requirement of various DMA driver's data.
> (...)
> With this i get rid of half of the dw_dmac specific platform data struct and
> used already defined struct dma_slave_config.

I tend to agree. But the main reason for my part is that the device
driver has this kind of knowledge, not the DMA driver. You can add:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
to the patch.

> One more thing. I missed few things in this patch:
> - Need to update all instances of struct dma_slave_config with
> ? ? ? ?.device_fc = false

All statically defined structs contain zero == false by default
so it's not needed.

Make sure any dynamic allocations (I don't know of any!)
are kzalloc() though.

> If, this field is not getting initialized to false by default, then these users
> will find their code not working atleast with dw_dmac and amba-pl08x.

As per above it will be zero, DMA engine control, by default.

>> If it is (1), so you have a use case where you have to switch a certain channel
>> between DMA master and device flow control at run-time it looks like it could
>> be useful for others as well, but I doubt this so I'd like some back-up on
>> that.
>
> I don't have that crazy usecase :)

Well it doesn't matter, we can support that with this patch though :-)

Yours,
Linus Walleij

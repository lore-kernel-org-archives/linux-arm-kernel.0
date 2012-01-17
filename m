From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Jan 2012 14:37:06 +0530
Subject: [PATCH 2/8] dmaengine: Add flow controller information to
 dma_slave_config
In-Reply-To: <CACRpkdY4QQK6wtB5aPU+FwdyyGq-owsDxMmxdwJVnkzdJTRs_Q@mail.gmail.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326707233.git.viresh.kumar@st.com>
 <CACRpkdY4QQK6wtB5aPU+FwdyyGq-owsDxMmxdwJVnkzdJTRs_Q@mail.gmail.com>
Message-ID: <4F153A3A.7060902@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2012 2:07 PM, Linus Walleij wrote:
>> > Perhaps, this should be a part of struct dma_slave_config. This patch adds
>> > another field device_fc to this structure. User drivers must pass this as true
>> > if they want to be flow controller of certain transfers.
> I dma_slave_config is supposed to be about info that
> 
> 1) Must to be set-up at runtime

Hmmm.. Currently if i check the comments in dmaengine.h, it is written
as you said. But i believe its usage could be more than that.

For example, how amba-pl011 use it today. Nothing dynamic, all static.

Actually the problem scenario is: pl011 is going to use separate DMA drivers
(for ex: dw_dmac and pl08x) for separate platforms. Now, pl011's code shouldn't
be dependent at all on these controllers. So, we have to pass separate data to
these drivers using dma driver specific platform data.

DMA driver's platform data contains two type of stuff: platform specific
(request line, master, etc) and user driver specific (like pl011) (reg address,
burst, width, direction, flow_controller, etc)

Now, its better to have some common struct in dmaengine which can fulfill
requirement of various DMA driver's data.

I find struct dma_slave_config fitting there. All user driver (pl011) specific
data can be passed using this structure. You can call dma_slave_config()
onetime after you got the channel. And after that just submit transfers.

With this i get rid of half of the dw_dmac specific platform data struct and
used already defined struct dma_slave_config.

> 2) All DMA controllers need to know
> 

Sorry i didn't understood it well.

One more thing. I missed few things in this patch:
- Need to update all instances of struct dma_slave_config with
	.device_fc = false

If, this field is not getting initialized to false by default, then these users
will find their code not working atleast with dw_dmac and amba-pl08x.
Can't say about other drivers.

- Also i need to fixup few atmel drivers which are using dw_dmac.

> So if it doesn't *have* to be set up by drivers at runtime, please keep it in
> platform data.
> 
> If it is (1), so you have a use case where you have to switch a certain channel
> between DMA master and device flow control at run-time it looks like it could
> be useful for others as well, but I doubt this so I'd like some back-up on
> that.

I don't have that crazy usecase :)

-- 
viresh

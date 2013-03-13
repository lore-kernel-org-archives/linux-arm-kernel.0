From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 13 Mar 2013 09:29:57 +0100
Subject: omap4 pandaboard: clock input for TiWi module inactive
In-Reply-To: <CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com>
 <513D9CB7.2010402@ti.com> <513DA92F.7020908@ti.com>
 <CAEYbN3T97W=74nMG4x4tVECRkff2RSasapvZQowpUwhJtUd=JQ@mail.gmail.com>
Message-ID: <51403905.3020102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 05:33 PM, Levi Pearson wrote:
> I spent some more time looking at clk-twl6030.c, and it seems it just turns the
> twl6030 chip on when you ask it to enable the clock, and as far as I
> can tell that
> happens based on module dependencies?  There aren't any explicit references to
> it that I can find, so I'm not entirely sure how a clk-twl6040 would
> cause a clock
> to be enabled.

The clk-twl6040 is not really a good example for you start with. We only need
it to turn on in order to get the clock on the output. But the principle is
the same at the end. you need to enable/disable the clock from twl6030...

>>>> If for whatever reason the commits cannot be reverted, would creating
>>>> a driver like drivers/clk/clk-twl6040.c that enabled the twl6030's
>>>> clock output be a suitable alternative?  I'd be willing to take a stab
>>>> at writing it if there's not something like that in the works already.
>>
>> If you can take this it would be great. It is still in my to-do list to
>> integrate the clk-twl6040 clock with the omap-mcpdm driver. I already got
>> working code, but it is not working in a way I would really wanted to be.
>> Integrating external clock to the SoC's clock tree does not seams to be that
>> straight forward: at boot time when the clock tree is initialized the external
>> chip is yet to be probed -> the root clock is not there, but later on for some
>> reason I can not get the CCF to enable the clock tree correctly.
> 
> I looked into the early boot clock setup code, and that does look a lot less
> straightforward.

Yes, this is what I thought for the twl6040 clock integration with McPDM. It
turned out a bit more complicated.
At boot time you do not have the twl clock driver loaded.
You have the clock tree already defined.
When you boot further you add the clock for twl6040.
You want to hook it up with the existing clock tree - to set it as parent of
one of the clock root (which you already modified to not to be the root clock).
I shall work, but it does not:
for external chips we need to do the configuration/enable in clk_prepare time
(because they are over i2c).
So the driver goes and asks for a clock (which supposed to be at the end
rooted to this new external clock).
Nothing happens.
The relevant clock tree has been already got prepared earlier so new prepare
will not going to go down to the root, leaving the root clock disabled.

I'm still looking a way to somehow fix this, but my time is limited right now.


> There are already a few 32k clocks listed there, and
> I *think* they
> all source from the twl6040; do they just come up automatically at power-on?
> From what I can tell, clk32kg is just a gated fork of the regular 32k
> clock that is
> available at boot from twl6040.  I am surprised it doesn't come on by default.

I have not checked the schematics, but it could be that we have crystal 32K on
board as well. TWL6030 can gate some of it's 32K outputs and this is the case
with WiLink on PandaBoard.

> 
> I also don't have a TRM for twl6040 that matches up with what twl-regulator.c is
> doing to enable the clk32kg output; it looks like it's adding it to
> one of the power
> modes, but I'm not entirely sure how the registers it's writing to work, so my
> confidence level in being able to get it transplanted to a separate
> driver has lowered
> quite a bit.

I'm not sure if I have twl6030 TRM either, but I can try to come up with a
basic driver for the twl6030 clocks.

-- 
P?ter

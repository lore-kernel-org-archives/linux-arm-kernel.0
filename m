From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 30 Nov 2017 15:55:23 +0000
Subject: [RFC PATCH 0/3] pinctrl: sunxi: Add DT-based generic pinctrl
 driver
In-Reply-To: <CACRpkdZQPspH79_nS-WgiSg6d2meXUztgocYbxO07vTgP1HehA@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <CACRpkdYFoUmGJYdKz0t9gsrkK=u8-oJjaRBXtNYHaUt9kSa3_g@mail.gmail.com>
 <54ecfdf7-cf4a-3eae-2661-47fa668a6066@arm.com>
 <CACRpkdZQPspH79_nS-WgiSg6d2meXUztgocYbxO07vTgP1HehA@mail.gmail.com>
Message-ID: <59e2ecf9-5802-17e4-b6ad-98d7373d7fe1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/11/17 15:20, Linus Walleij wrote:
> On Fri, Nov 24, 2017 at 1:05 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> On 24/11/17 10:28, Linus Walleij wrote:
> 
>>> The DT maintainers have been pretty clear on that they don't like
>>> using the the DT as a generic fit-all information dump. They
>>> prefer to look up hardware data from per-soc compatible strings.
> (...)
>> I am just a bit worried that with Allwinner recently playing the SKU
>> game we end up with tons of tables for only slightly different SoCs (see
>> the H3 and H5, for instance). And with single image kernels we pile up
>> quite some *data* in each kernel, which is of little interest for
>> everyone else.
> 
> So what you are saying is that you want to use the DTS for
> data dumping

Well, that's what the DT is for, right? As opposed to dump the data in
*every* kernel (Linux, U-Boot, BSD) for *every* SoC.
And, following this argument, why do we have reg and interrupt
properties if we could derive them from the compatible string as well?
Those are SoC specific and immutable by a board as well.

It seems the discussion went slightly heated and astray, but basically I
am after two things, maybe we should separate them:

1) Put the actual mux value into the DT, next to the already existing
function property. That is a small addition, but has the great effect of
avoiding to hard code this information for *each* supported SoC in
*every* kernel. Doing so just sounds like bonkers to me, sorry.

If there is really so much resistance against also *using* this
information from Linux, I would be happy to at least add the already
existing and generic "pinmux" property to the binding. This way we could
add those values to the .dtsi(s), and other OSes could use them. No need
for a driver change in Linux, then. I am not buying this molly guard
argument at all, but this way we could keep this protection in the kernel.
This would immediately allow to get an easy DT based pinctrl driver on
the road for U-Boot.

2) Add the (very few!) properties to the pinctrl root node that we need
to size and enumerate the pins. This would allow generic pinctrl driver
support, so one thing less to worry when bringing up a new SoC (variant).

So my main goal is more about the binding and the DTs.
Linux could just ignore them, though I don't see a good reason for us to
not make use of those for good.

I believe that both are not really a big issue and I don't really
understand why there is so much opposition towards it.

> and what I'm saying is that the DT maintainers
> do not like that stance.
> 
> They will have to speak on the issue directly before we continue
> I think.

Fair enough.

> I have been getting a *LOT* of pushback to putting large amounts
> of data and configuration in the DTS recently, so IIUC that is something
> they simply don't like, probably for good reasons.

That's a shame, maybe it's to limit the amount of review and maintenance
needed? And it's a safe bet to have a simple binding, where nothing can
go wrong? And since we can't predict the future?

I don't know, but in this case we have quite a sample of already
existing controllers and can make an much more educated guess for a
better and compatible binding, kind of in hindsight.

> C.f:
> https://www.spinics.net/lists/dri-devel/msg150321.html
> 
>> Also my understanding is that the actual Allwinner pin controller IP
>> (register map) is very much the same across all SoCs. Mostly the only
>> difference is the mapping between pins and mux functions, which we
>> express in the DT already anyway (in the subnodes). And this is really a
>> poster book example of what DT should be doing: express the specific
>> mappings of a particular implementation. I don't see why this would need
>> to be per-board only, if we can pull this up to the SoC level.
> 
> It's not me you need to sell this point.
> 
> You need to sell it to the DT maintainers.

Well, so far I only got some push back from Thierry, Maxime and you. My
understanding of the DT maintainers' position is to leave those details
to the subsystem maintainers.

Cheers,
Andre.

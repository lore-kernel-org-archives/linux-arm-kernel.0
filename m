From: mkl@blackshift.org (Marc Kleine-Budde)
Date: Mon, 18 Jun 2012 11:54:42 +0200
Subject: Dove clock support
In-Reply-To: <4FDEF7E9.4030504@googlemail.com>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch> <4FDEF7E9.4030504@googlemail.com>
Message-ID: <4FDEFAE2.7000303@blackshift.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 11:42 AM, Sebastian Hesselbarh wrote:
> On 06/18/2012 10:43 AM, Andrew Lunn wrote:
>>> Sure, the address layout is different, but that can be made generic in a
>>> second step. Maybe we need a private pointer in the gate_fn struct.
>>
>> Yes, something like that.
> 
> You need to pass at least the controllers base address. Everything else
> is common - IIRC kirkwood has two SATA, dove only one. Moreover the base
> addresses for the second are not defined, yet.
> 
> Also ge-phy has to be connected with ge-clk, too. But for dove this is
> a clk gate while kirkwood can shut it down somewhere else. I guess it
> can be handled like sata/pcie on kirkwood.

The PHY is a clock gate so I'm handling it via:

> ge = dove_register_gate("ge0", CLOCK_GATING_GBE_BIT | CLOCK_GATING_GIGA_PHY_BIT);

So no gate_fn needed.

>>> BTW: who will enable the clocks that have been disabled via the
>>> sata/pcie shutdown functions?
>>
>> This is potentially a problem when the SATA driver is built as a
>> kernel module. There is no code that i know of to turn the SATA PHYs
>> back on again. I think this has been broken like this for a long
>> time...
> 
> IMHO the driver should take care of enabling clk and PHYs. In my
> understanding of the common clock framework both will be disabled
> if no driver requests it.

But the current drivers don't enable clk and PHYs? But if I understand
Andrew correct, this was the case all the time.

Cheers, Marc

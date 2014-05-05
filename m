From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 May 2014 14:11:08 +0200
Subject: syscon or memory mappings (was: Re: [RFC/PATCH 0/8]
 pinctrl-rockchip: Change wrong initial assumptions)
In-Reply-To: <9747726.2b5sgjTxWB@typ>
References: <1414506.B4e2jZujVm@diego> <4321949.A6Ghcdztds@diego>
 <9747726.2b5sgjTxWB@typ>
Message-ID: <3114029.fvjZVjkFrH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 3. Mai 2014, 14:40:36 schrieb Max Schwarz:
> Hello Heiko,
> 
> On Saturday 03 May 2014 at 01:45:11, Heiko St?bner wrote:
> > > However, this sheds light on an underlying issue: Rockchip is not
> > > treating
> > > the whole GPIO block as one cohesive device as we do currently. Instead,
> > > it
> > > seems to me, one GPIO bank is one device. Each has its cohesive mux,
> > > bank
> > > and pull registers - apart from rk3188-bank-0, maybe. But that one is
> > > special anyway with regards to register ordering (s.b.).
> > > 
> > > The issues you had with RK3188 and now have with RK3288 seem to stem
> > > from
> > > trying to group all banks together into one pinctrl driver.
> > > 
> > > So maybe we should promote the GPIO banks to full devices in the dt and
> > > make smaller mappings for each GPIO bank, i.e. three mappings for each
> > > GPIO bank (mux, bank, pull). I know we have to stay backwards compatible
> > > dt-wise, but that should be doable.
> > 
> > Yes, that is another miss-conception from the early days. The
> > gpio-controllers themself are actually Synopsis Designware IPs - the
> > kernel
> > now even has a separate driver for them (gpio-dwapb). Only the real
> > pincontrol/muxing/pull/etc is from Rockchip.
> > 
> > Currently I can't think of a way to move over gracefully, without
> > introducing crap into the gpio-dwapb driver. As at the moment it parses
> > all
> > information it needs from the dt directly - of course with different
> > bindings.
> > 
> > That is also the reason I do not want to introduce more "special-cases" in
> > the bank-declaration we're using currently - to not make this move more
> > difficult in the future.
> > 
> > As it is, with the patch attached to the last mail, the pinctrl driver
> > wouldn't even need the "rockchip,rk3188-gpio-bank0" compatible anymore, as
> > the information about its special case is now sitting in the bank
> > declaration inside the driver. Which then would enable us to remove the
> > gpio-bank subnodes alltogether and use the external gpio driver.
> 
> Okay, you convinced me. That sounds like a good plan to me. Maybe we can
> introduce some compability code into the pinctrl driver to generate the
> correct dt nodes for gpio-dwabp at runtime? I think that would depend on
> something like CONFIG_OF_DYNAMIC though.

Yep, that's one option. The other would be to let the driver support both (the 
internal gpio code and the real gpio-dwapb), deprecate the old one 
[of course also disallowing it for rk3288 and following] and simply remove it 
after the appropriate timespan (1 or more years if I remember correctly :-) ].



> > While for example syscon cannot handle clocks currently, the underlying
> > regmap can - so it would be only a matter of teaching syscon to tell
> > regmap
> > of the clock to use (GRF and PMU register-clocks in this case), instead of
> > needing to have every user of parts of these registers handle the relevant
> > clock itself on register accesses.
> > 
> > Also, as you can see in the grf map, the rk3188 actually has two
> > soc_status
> > registers (0xac and 0x108) which have the dmac, cpu and drive strength
> > registers in between. So having a syscon only for soc_con and soc_status
> > will produce problems too.
> > 
> > Another example, GRF_IO_VSEL at 0x0380 is most likely some sort of pin
> > voltage selection. As it only spans 1 register I'd assume it could contain
> > settings that span all pin banks.
> 
> Okay, we couldn't handle that with individual devices for each bank.
> 
> > And of course, splitting the register space into dozens of small
> > individual
> > mappings looks messy :-)
> 
> Yes, I agree now ;-)

cool :-D

I've also just sent a v2, including the missing MFD_SYSCON dependency, thanks 
for the find.



Heiko

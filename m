From: andy@warmcat.com (Andy Green)
Date: Mon, 04 Jan 2010 17:28:37 +0000
Subject: Ethernet / SD Boot
In-Reply-To: <4B42169E.5040007@simtec.co.uk>
References: <20091228192244.GD14799@sirena.org.uk>	<4B390AC3.2060702@warmcat.com>	<20091228202123.GA16524@sirena.org.uk>	<4B391941.6000906@warmcat.com>	<20091228224435.GA23617@sirena.org.uk>	<4B39D439.9070909@warmcat.com>	<20091229123348.GB5784@opensource.wolfsonmicro.com>	<4B39FB2C.4010608@warmcat.com>	<20091230131559.GA369@opensource.wolfsonmicro.com>	<4B3B579E.8030105@warmcat.com>	<20091231122727.GA5613@opensource.wolfsonmicro.com>
	<4B3CA02D.9000208@warmcat.com> <4B42169E.5040007@simtec.co.uk>
Message-ID: <4B422545.2000509@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/10 16:26, Somebody in the thread at some point said:

Hi -

> Of course, with bed of nails type systems it is probably possible to
> allow the system to boot off what you like, NAND is easily ~18
> connections to the board, SD is of course less.

Yeah... all kinds of complex board bringup schemes are possible... 
but... are they wise?  It's special for the factory and special for the 
pcb revision.  It's extra cost and management.

For example Openmoko went your NAND bringup route and it was basically 
an intricate, complex Hell that few people understood and fewer, like 
zero, actually wanted to go to the factory with.  OpenOCD basis turned 
it into a lottery if even internal devs could work with it.

For smaller runs test jigs are popular, they have the same problem of 
requiring developer and design effort.

Often when I have this conversation, it mainly runs into the other guy 
having heard / decided that "real men" must have jigs / jtag / u-boot or 
whatever it is.  But actually, it can be a huge amount of dead weight 
around small to medium run development effort and it can be entirely 
optional to tie those stones around your neck.

Maybe you like sorting that out but I really prefer the SD Boot scheme 
where there is no factory bringup arrangement at all except the shipping 
rootfs with some bash scripts turning a board from the oven into a 
shipping device.

>>> That 70 cents does rather add up once you start to ship in volume, even
>>> a fraction of that would.
>>
>> You did notice that you get to save money back from removing NAND and
>> JTAG connectors?
>
> A lot of times these are done as 'bed of nails' pads on the PCB so
> hardly a bank breaker... Also, see PoP argument below.

You're referring to NAND programming here I assume.

Something has to be on the other end of those spring probes / jig and it 
has to be prepared / maintained / tested.  The burden does not end with 
the fact you made contact with some probes.  It's special for the 
factory and cannot be repeated by the user (or even the devs without 
grief).  If you make another run two years later and the guy who did the 
magic left, maybe the processing steps to turn an image into SVF is lost 
and suddenly the visit to the factory is a risk.

A better argument for that I have heard would be, "well, I have to 100% 
test connectivity on all my external ports, don't I, spring probes will 
solve it".  But this argument is also broken, you are not testing 
connector function that way.

If it's doable on the design, the optimal test strategy is often 
loopback plugs and selftest, although how far you can get with that 
depends on exactly what your device exports on the connectors.

>> Due to the other advantages of SD Boot basis you can also expect to get
>> your product to market quicker, spend less time in the factory, and have
>> less returns all of which save money.
>
> And as shown by the nook, make it really easy for your users to root the
> thing without trying. You've been spoiled a bit by having an open design
> to play with, not everyone likes their users messing with the hardware
> once it has left the factory.

No, that does not have to follow.

iMX31 has hard crypto chain of trust all the way from ROM, through SD 
bootloader being signed, which can then validate signatures of kernel 
and rootfs.  If you want it locked up and do true SD boot you can do it.

Further you are mistaken if you think having a NAND on a board is any 
impediment to getting / changing its contents to someone who wants to do 
that.  It makes it harder to change the contents without swapping the 
chip, but that's a double edge sword in debrickability terms when you 
only targeted a factory with a jig to be able to do that.

And modchip folks will tell you that once you have the rootfs, you stand 
a decent chance of finding something that may let you circumvent 
security and reflash it without NAND lifting.

You need a bit more of a story than you just put the same stuff in a 
NAND on your board and it's Fort Knox now.

> Also as another cost item, a lot of the newer cpus with PoP style memory
> have some form of NAND/OneNAND built into the system already so adding
> an extra SD card is often seen as a waste of extant storage.

Some do PoP and some don't; the mix of assets in the PoP is soft if you 
are a large vendor, so it's possible to just get DDR in there.  DDR is 
the thing where PoP actually delivers something, since it removed the 
board layout and verification burden.

>> So I wouldn't let this notional $0.70 put you off.
>>
>>>> Yeah you need to make the uSD connector accessible if you remove a
>>>> cover, that's generally not hard.
>>>
>>> In some form factors.  In others it's very problematic.
>>
>> Dunno how problematic it can be actually, unless you dunk your board in
>> epoxy.  uSD connectors are very small footprint and low profile since
>> they're widely used in consumer equipment like phones.  Since you only
>> need access to it in a crisis due to bricking it, it's OK if you have to
>> remove a cover or whatever.  Space shouldn't be an issue due to what it
>> allows you to throw out from the board.  I'm sure there are special
>> cases but I maintain "generally, that's not hard".
>
> A lot of the time, the bigger manufacturers have enough money that a
> commercial JTAG system makes sense, as not only can it program the board
> but there are also connectivity checking systems that allow you to do
> signal connectiivty testing and other such wonderfullnesses for you.

Yeah.  But many (most?) folks working on this stuff are trying to bring 
complex products to market with insufficient resources and pressed for 
time.  There isn't any internal test team.  What there is mainly is the 
choices that the developer will make as to how to come at production.

By smart choices about how to

  - boot

  - create the rootfs

  - test the device

the developers can eliminate several kinds of downstream steps that are 
currently considered unavoidable and get the optimal situation in 
previously dangerous areas like board bringup and rootfs maintainence.

>> But many chips have 2 or 3 SD units, mux arrangements that bring the
>> same things to different pins.  In the case of SD interface, it's a
>> given in context of phones where a lot of these chips go, so you tend
>> not to find other IO on those balls that is critical and does not also
>> appear on other ball muxes.  (It's only 6 balls anyway, it's not like a
>> memory bus).  It seems you can typically expect you're going to be able
>> to use SD unless you find a specific conflict because the chips are
>> deliberately designed to enable SD usage in typical design.
>
> and of course, a lot of modern mobile devices need SD for talking to
> other devices, such as WLAN chips, external storage cards, etc. It can
> soon take a toll on what is available.

Sure, if you need more SD units than the chip has, something's gonna 
have to give for sure.  But I look around and most things I see don't 
have 3 SDs used up.

The last few objections have basically been, "what if I can't use SD 
Boot for some reason?  Where is your God NOW???"

If you actually can't use it because you dip your board in epoxy; you 
need all the SD ports for something else; your CPU doesn't have SD boot; 
your customer thinks a NAND on a PCB is secure... then don't bother 
considering what you can't use and do something else :-)

Otherwise, you should study carefully the advantages you can get from 
true SD Boot in simplifying the hardware, software engineering and 
production / test / debrick.  It has pretty revolutionary benefits.

-Andy

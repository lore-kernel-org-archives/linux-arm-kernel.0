From: joancarles@fqingenieria.es (joancarles)
Date: Tue, 13 Mar 2012 14:58:10 +0100
Subject: AW: [PATCH] iomux-mx25.h slew rate adjusted for LCD __LD pins
In-Reply-To: <3F263ABB4EDE344D974E1983B56807739E868F97@EX-DAG01.eckelmann.group>
References: <3F263ABB4EDE344D974E1983B56807739E868EAB@EX-DAG01.eckelmann.group>
 <efb4350f3d236ae7feb088b9a5072b8c@mail.fqingenieria.es>
 <3F263ABB4EDE344D974E1983B56807739E868F97@EX-DAG01.eckelmann.group>
Message-ID: <09e474eba58108ebf43032efbe40e244@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>> What a coincidence, we have been fighting with the LCD color issue 
>> on an i.MX258 about two weeks ago and came up with almost the same 
>> patch.
> Sounds like we hit the problem in the right way. Super! :)

I am glad there's someone else with the same issue and solution ;).

>> For us it was enough to change the MX25_PAD_GPIO_E__LD16 and
>> MX25_PAD_GPIO_F__LD17 pins to PAD_CTL_SRE_FAST. Why do you need to 
>> change the others too? Could this introduce undesired signal noise on 
>> the board? We actually experience a weird effect on the ADC lines. 
>> It's all
>> been discussed here:
> For our display problem it's also enough to set MX25_PAD_GPIO_E__LD16
> and MX25_PAD_GPIO_F__LD17 to fast slew rate. So far i can confirm 
> that
> your patch solves the problem.

Good to know.

> The reason I decided to change the other line muxings too is the
> tought, that when these two lines need to set to fast slew rate, all
> other line need to set to fast slew rate too.
> For some reason (I actually don't know) the other lines seems to be
> set >implicit< correctly to fast slew rate. In order to avoid future
> problems I set them explicit to fast slew rate.

I see. Well, we shouldn't be taping possible future failures of 
hardware configuration, since the original change wasn't provoked in any 
way by a change of the slew rate of the before mentioned pins. I reckon 
it has more to do with the different ways the mx25 is initialized these 
days compared to, let's say 2.6.39.x (which was the last kernel our LCD 
screen worked without wash-out and no changes to the slew rate of said 
pins).

> Seeing the aspect that all LD lines implicit set to fast slew rate,

How do you see that?

> there would no electrical change if you set them explicit. For all 
> the
> other lines (not LD16 and LD17)
> The code effectivly changes nothing, but ensures the fast slew rate
> in future.
> That's the idea, but I can't confirm my assumption by measurement.
> What's your opinion?

I could give it a go on the oscilloscope, however the changes in the 
signal tangent might be really tiny.

> I checked my ADC right now. We use it to read out touchscreen. I
> can't find any problems, all seems to be okay.
> What's your use of it?

Touchscreen only, however we've been having our share of fun with it. 
It's still not stable, but that's largely off-topic here at the moment. 
Juergen Beisert (our local hero) has written a ADC/TS driver from 
scratch for the i.MX25 platforms, which is very nicely engineered and 
seems to work just fine. He's posted it to this list a couple of days 
ago for initial comment. After some changes with regard to 
HSYNC/Polarity settings to his driver and some capacitors to the lines 
between the LCD and the ADC, we have a more or less stable reading, with 
a jitter of +-8px.

>>  It's all been discussed here
> shame on me, I missed the post.^^ But I will read it now.

No, shame on me, I forgot to post the link to the discussion, which has 
not at all happened on this mailing list. Here it is:

http://news.gmane.org/gmane.comp.embedded.ptxdist.oselas.community

Search for the "Kernel 3.3 custom mx25 device touchscreen issues" 
thread to find the whole development of two issues: the touchscreen not 
working because of other hardware failures and an initially flaky TS/ADC 
driver, and this issue with regard to the LCD washout effects.

>> Would you care to explain how to perform the "LCD muxing correctly" 
>> in the bootloader and why it should influence what the kernel does?
>
> We have moved our Kernel from 3.0 to 3.2 the LCD problem occurs.
> When booting the 3.0 kernel and the reboot and "warm starting" the
> 3.2 kernel the display running fine.
> When "cold starting" the 3.2 kernel the display problem occurs.

Interesting! What's your device? A custom mx25 board?

> So that lead to the knowledge that there must be an initialization
> problem. What happened?
> The 3.0 kernel starts and init the pins correctly. These pin settings
> kept by "warm starting" the 3.2
> Kernel, so it can drive the display correctly. So the 3.2 seems not
> touching these settings.

For us this did not happen. Booting a 2.6.39.3 kernel worked correctly 
and subsequently "warm starting" or rebooting  with an unpatched 3.3 
kernel created these wash-out effects on our LCD.

> So far I've come to the idea, that the problem shouldn't occur on
> boards where the muxing of the LCD
> completely done by bootloader. Which is not in my case, but I think
> this theory could explain it
> when some mx25 board dons't have the problem with the lcd.

I haven't had a look at the bootloader yet, we're using an old version 
(2010) of u-boot. The issue there is that we boot from NOR and made a 
lot of patches to support our device. Forward porting to a newer release 
of u-boot right now seems like a daunting task, as too many things have 
changed since.

> I must admit that I'm not the most experienced kernel developer, so
> far it would be possible that the idea of setting all LDxx pins
> explicit fast is not the best idea.

 From many years ago, working on the Intel side of kernel hacking, I 
remember that in the community there was always some resistance in 
accepting patches where the origins of the failure of a component wasn't 
really 100% clear. It's clear here, but your patch seems to change 
additional default values for no apparent reason, other than preventing 
another debugging session in the future, should this incidence occur 
again with regard to the other __LDxx pins.

> So I hoping for a divine inspiration :)

That's two of us now ;).

Thanks for your time and insightful discussion.

Cheers
-- 
Joan C. Abelaira
  FQ Ingenier?a Electr?nica, S.A.
Pol?gon Industrial Vilanoveta
Av. de les Roquetes, 9
E-08812 Sant Pere de Ribes (Barcelona)
SPAIN
Telf: +34 932 080 258
Fax: +34 934 592 893
M?vil: +34 638 331 745

http://www.fqingenieria.es/
email: joancarles at fqingenieria.es

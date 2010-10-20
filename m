From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 10:12:15 +0200
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101020075446.GG2562@matterhorn.lan> (Amit Kucheria's message
	of "Wed\, 20 Oct 2010 10\:54\:46 +0300")
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
	<AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
	<20101020075446.GG2562@matterhorn.lan>
Message-ID: <87zku9cmg0.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria <amit.kucheria@linaro.org> writes:

> On 10 Oct 19, Matt Sealey wrote:
>> On Tue, Oct 19, 2010 at 4:15 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > On Tue, Oct 19, 2010 at 10:42:54PM +0200, Arnaud Patard wrote:
>> >> read board id value from the GPIO3_16/17/11
>> >>
>> >>
>> >> +/* ? PCBID2 ?PCBID1 PCBID0 ?STATE
>> >> + ? ? 1 ? ? ? 1 ? ? ?1 ? ?ER1:rev1.1
>> >> + ? ? 1 ? ? ? 1 ? ? ?0 ? ?ER2:rev1.2
>> >> + ? ? 1 ? ? ? 0 ? ? ?1 ? ?ER3:rev1.3
>> >> + ? ? 1 ? ? ? 0 ? ? ?0 ? ?ER4:rev1.4
>> >> +*/
>> >> +static void __init mx51_efikamx_board_id(void)
>> >> +{
>> >> + ? ? int id;
>> >> +
>> >> + ? ? /* things are taking time to settle */
>> >> + ? ? msleep(500);
>> >
>> > Is it really necessary to delay the boot process such a long time?
>> 
>> Yes. On older boards the PCBID pins are pulled high by IOMUX settings
>> (a pulldown on the board on newer revisions will keep it down). IOMUX
>> and GPIO stuff takes a little while to settle in, so if you do it
>> immediately, it will return some freakish values based on random GPIO
>> setup (it may be high, low, or none of the above at any point before
>> the pad setting kicks in).
>
> Then perhaps do this only for the older boards?

How can you detect older boards without looking at board id pins ? :)

>
> So by default there is no delay, but when a (new) config option is enabled,
> delay boot.

I don't think it's a good idea. This would mean that the same kernel
can't run on old and new boards. Also, there's no way to easily know
which board you have (I don't consider opening the box is an easy way)
so it's likely that someone will get this wrong sooner or later.

Arnaud

From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 19 Oct 2010 16:30:25 -0500
Subject: [patch 1/9] efikamx: read board id
In-Reply-To: <20101019211507.GA28242@pengutronix.de>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205251.082848683@rtp-net.org>
	<20101019211507.GA28242@pengutronix.de>
Message-ID: <AANLkTi=SbFy1eFzQ3XUGDjurme=stUSiqmTRVR=EtX5q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 4:15 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Oct 19, 2010 at 10:42:54PM +0200, Arnaud Patard wrote:
>> read board id value from the GPIO3_16/17/11
>>
>>
>> +/* ? PCBID2 ?PCBID1 PCBID0 ?STATE
>> + ? ? 1 ? ? ? 1 ? ? ?1 ? ?ER1:rev1.1
>> + ? ? 1 ? ? ? 1 ? ? ?0 ? ?ER2:rev1.2
>> + ? ? 1 ? ? ? 0 ? ? ?1 ? ?ER3:rev1.3
>> + ? ? 1 ? ? ? 0 ? ? ?0 ? ?ER4:rev1.4
>> +*/
>> +static void __init mx51_efikamx_board_id(void)
>> +{
>> + ? ? int id;
>> +
>> + ? ? /* things are taking time to settle */
>> + ? ? msleep(500);
>
> Is it really necessary to delay the boot process such a long time?

Yes. On older boards the PCBID pins are pulled high by IOMUX settings
(a pulldown on the board on newer revisions will keep it down). IOMUX
and GPIO stuff takes a little while to settle in, so if you do it
immediately, it will return some freakish values based on random GPIO
setup (it may be high, low, or none of the above at any point before
the pad setting kicks in).

>> + ? ? gpio_request(EFIKAMX_PCBID0, "pcbid0");
>> + ? ? gpio_direction_input(EFIKAMX_PCBID0);
>> + ? ? gpio_request(EFIKAMX_PCBID1, "pcbid1");
>> + ? ? gpio_direction_input(EFIKAMX_PCBID1);
>> + ? ? gpio_request(EFIKAMX_PCBID2, "pcbid2");
>> + ? ? gpio_direction_input(EFIKAMX_PCBID2);
>> +
>> + ? ? id = gpio_get_value(EFIKAMX_PCBID0);
>> + ? ? id |= gpio_get_value(EFIKAMX_PCBID1) << 1;
>> + ? ? id |= gpio_get_value(EFIKAMX_PCBID2) << 2;
>> +
>> + ? ? switch (id) {
>> + ? ? case 7:
>> + ? ? ? ? ? ? system_rev = 0x11;
>> + ? ? ? ? ? ? break;
>> + ? ? case 6:
>> + ? ? ? ? ? ? system_rev = 0x12;
>> + ? ? ? ? ? ? break;
>> + ? ? case 5:
>> + ? ? ? ? ? ? system_rev = 0x13;
>> + ? ? ? ? ? ? break;
>> + ? ? case 4:
>> + ? ? ? ? ? ? system_rev = 0x14;
>> + ? ? ? ? ? ? break;
>> + ? ? default:
>> + ? ? ? ? ? ? system_rev = 0x10;
>> + ? ? ? ? ? ? break;
>> + ? ? }
>> +
>> + ? ? if ? ? ?((system_rev == 0x10)
>
> Please replace the tab after 'if' with a space
>
>> + ? ? ? ? ? ? || (system_rev == 0x12)
>> + ? ? ? ? ? ? || (system_rev == 0x14)) {
>> + ? ? ? ? ? ? printk(KERN_WARNING
>> + ? ? ? ? ? ? ? ? ? ? "EfikaMX: Unsupported board revision 1.%u!\n",
>> + ? ? ? ? ? ? ? ? ? ? system_rev & 0xf);
>> + ? ? }
>
> I know nothing about the versioning scheme, but what about 1.1? Is it
> supported?

The check is just a nicety; Genesi have only shipped 1.1 and 1.3
boards to customers.

1.0 was the original "developer edition". Laurent Guerby and a few
other people have these boards to make simple compile farms out of.
Some stuff plain doesn't work, though (ethernet on USB DR port), so we
track it as "unsupported" - if someone wants to fix it up with patches
they may. Until then we warn in dmesg that this is a weird board
revision so we can keep track and warn users not to "complain".

1.1 is the "TO2" original board on sale. They are useful, without
NEON, as compile boxes or so.

1.2 was an internal build featuring most 90% of the features of 1.3,
but with an i.MX515 TO2. They do exist: I have 4 or 5 sitting in my
office. They're pointless to use though as TO2 boards don't have
stable NEON and we didn't do a great deal of testing (1.3 was around
the corner and had fixed a bunch of stuff).

1.3 is the "TO3" board. We shipped it around April/May I think and
customers were offered replacements.

1.4 does not exist in production as of yet (and may not ever be) but
the PCBID is planned already.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.

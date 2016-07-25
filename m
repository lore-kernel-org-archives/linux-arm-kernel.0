From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 25 Jul 2016 10:03:14 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <20160725073204.GD7419@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
 <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
 <20160725073204.GD7419@lukather>
Message-ID: <CAOMqctQybJoOfUHGtpmpB_koQ=iY+GpQ_BOL2o0QBbwC_HXC0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 25 July 2016 at 09:32, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jun 17, 2016 at 12:34:44PM +0200, Michal Suchanek wrote:
>> Hello,
>>
>> On 13 June 2016 at 21:57, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
>> >> Hello,
>> >>
>> >> This is update of the sunxi spi patches that should give full-featured SPI
>> >> driver.
>> >>
>> >> First three patches fix issues with the current driver and can be of use for
>> >> stable kernels so adding cc for those.
>> >>
>> >> I merged the sun4i and sun6i driver because there several issues that need to
>> >> be fixed in both separately and they are even out of sync wrt some fixes.
>> >> I guess some of the merge patches can be squashed.
>> >>
>> >> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
>> >> tell if that side was broken by this patchset - especially the last patch that
>> >> adds DMA was afaik never tested on sun6i.
>> >
>> >
>> > For the record, I'm still very much opposed to such a merge.
>>
>> What is the reason against the merge? I did not find the original
>> discussion.
>
> I really prefer some code that is concise and clear but a little
> duplicated over some code that shares every possible lines of code but
> is a giant mess impossible to understand.

Yes, it's been tried. In the case of this driver there is more duplication
than differences. Also bitrot due to different variants receiving different
updates and fixes crept in already.

Adding the remap layer certainly does not make the driver easier to
understand but it's not becoming giant mess either.

>
> I just came across the reg_field stuff in regmap that would allow to
> partially address that problem though, there's still the bit indices
> issue to overcome though.
>
>> I tried to rename everything in the drivers from sun4i and sun6i to
>> sunxi to look at a clean diff and found about 5 differences 2 of which
>> look like a bug.
>
> It's hard to tell without testing.

I tested the merged (and separate) driver on a H3 board and found a
type bug in the remap layer.

I also found I can transfer at most 68 bytes without DMA although
the manuals claim 128 byte FIFO. DMA transfers weren't very reliable
which may or may not be a wiring issue. I have seen similar issues
intermittently with SPI on A10s.

Thanks

Michal

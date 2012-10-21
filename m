From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 21 Oct 2012 00:38:57 -0700
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CACRpkdY2=PLS_MT1h_nQJj+2ju26yXtt-aXSi=t9uUQ5+WJasA@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
 <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
 <CACRpkdYjA8QUh4HqvE1rsnXcGA4WafTkMq_wLNJ__gXEnEYrow@mail.gmail.com>
 <507794B6.2000107@st.com>
 <1350307104.4115.23.camel@sauron.fi.intel.com>
 <CAN8TOE-7d=YUSYsHFw9X5vnz8cpSJYv5uZfvBpDyhg+-F_LDiQ@mail.gmail.com>
 <CACRpkdao_9TkH7=ia7kXB-KsQhNZQ7EfSS5B1X0wFPgg5OsuHA@mail.gmail.com>
 <1350371685.5769.45.camel@sauron.fi.intel.com>
 <CACRpkdY2=PLS_MT1h_nQJj+2ju26yXtt-aXSi=t9uUQ5+WJasA@mail.gmail.com>
Message-ID: <CAN8TOE91TDewmo=w7585sDrsXcPmBnvOjmD7sTizPSJ8RH8_Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 3:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 16, 2012 at 9:14 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>> On Mon, 2012-10-15 at 21:51 +0200, Linus Walleij wrote:
>>> On Mon, Oct 15, 2012 at 6:27 PM, Brian Norris
>>> <computersforpeace@gmail.com> wrote:
>>>
>>> > I would prefer not building a solution that hopes kmalloc() can get a
>>> > large contiguous buffer (remember, eraseblock sizes come as large as
>>> > 2MB these days). A real solution like CMA or scatter-gather seems like
>>> > a better idea.
>>>
>>> +1 on that, and as I think I illustrated the MMC subsystem is using
>>> the block layer helpers to form scatter-gather lists for it's requests.
>>> I don't see why the MTD subsystem need to be very different?
>>
>> This is good idea, the problem is that it is a bit more work than
>> hacking the driver, so most people prefer the latter. By removing all
>> kmalloc()'s I basically wish to force people to go this way.

Did you mean vmalloc()'s?

>> What are the SC functions names you refer?
>
> I'm mainly thinking of blk_rq_map_sg()
> from block/blk-merge.c

I am also interested in the potential for the S-G approach. I'll see
what kind of work it takes to implement soon, hopefully.

As a side note, my hardware can, in fact, perform scatter-gather DMA.
If we were to support both S-G hardware like mine in addition to
standard, page-at-time access (nand_chip->write_page, for example),
could we introduce a DMA interface to nand_chip? Then this interface
would just be set to NULL for those that can't handle it.

Brian

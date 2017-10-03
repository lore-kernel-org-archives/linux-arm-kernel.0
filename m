From: joel@jms.id.au (Joel Stanley)
Date: Tue, 3 Oct 2017 15:17:17 +0930
Subject: [PATCH v2 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <20171002213742.GQ457@codeaurora.org>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-5-joel@jms.id.au>
 <20171002213742.GQ457@codeaurora.org>
Message-ID: <CACPK8XdrqmBC8M+=NDUVhYKPafw-Qc8fRikV+xJ84FyzG6BfxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 7:07 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/21, Joel Stanley wrote:
>> The majority of the clocks in the system are gates paired with a reset
>> controller that holds the IP in reset.
>>
>> This borrows from clk_hw_register_gate, but registers two 'gates', one
>> to control the clock enable register and the other to control the reset
>> IP. This allows us to enforce the ordering:
>>
>>  1. Place IP in reset
>>  2. Enable clock
>>  3. Delay
>>  4. Release reset
>>
>> There are some gates that do not have an associated reset; these are
>> handled by using -1 as the index for the reset.
>
> Half of these aren't clks, but reset bits? Perhaps you should
> register power domains for these things and then have the power
> domain assert the reset, enable the clock, delay, and then
> release the reset in the poweron callback. Then device drivers
> don't have to be aware of the ordering, and you can keep
> enforcing the ordering in one place, but we don't have to make
> fake gates and shoehorn the sequence into the clk framework.

I had a look. We've got 24 gates being registered, and half are just
gate+reset pairs, while the other half are both. Some of them have
clocks with divisors upstream of the gate, so in those cases we do
care what the rate is. For the others they are simply bringing the IP
online.

Note that we don't have drivers for all of the peripherals, so things
may change once those drivers are written.

I hadn't looked into the power domain stuff - when I brought this up
on the list recently Philip suggested that this should be contained in
a clk driver, so that's the direction we went:

 http://www.spinics.net/lists/linux-clk/msg18733.html

Cheers,

Joel

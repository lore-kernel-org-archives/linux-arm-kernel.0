From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 30 Jan 2013 15:18:37 +0530
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301300941.35886.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291621.59425.arnd@arndb.de>
 <CAKohpon30hB9S+MUyXwZpefAGQE4hvF36d-6jXNRk_XoK5dwww@mail.gmail.com>
 <201301300941.35886.arnd@arndb.de>
Message-ID: <CAOh2x==WZePgfTWwL0vPdE693n44vW05OS=DSqbnDCs2xzHXuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 3:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 30 January 2013, Viresh Kumar wrote:
>> I knew you will come to this :)
>> So, the hardware is like: there are 16 request line slots per master, a
>> platform can choose to connect same or separate devices to these.
>>
>> So, these are really 16 per master.
>
> Ok, I see. Do you know how these are numbered in the data sheet?
>
> If the convention is to have subsequent numbers for these in the
> hardware description, we should probably just have that single
> request number in the binding, too, and calculate the master number
> from that. If it lists pairs of request/master number, we should
> use pairs in the binding as well, in the same order.

Actually what would be better to have is:
- have this range from 0-15 only
- together with the master we want to use for peripheral

this should be enough.

Datasheet of dw_dmac doesn't tell much about it.. just four bits for programming
it and so values are from 0-15 :)

>> > Ok. Would it be enough to have only one master and one request
>> > field in the DT dma descriptor then, and have the code figure
>> > whether to use it as source or destination, based on the
>> > configuration? Which one should come first? Since you have
>> > multiple masters per controller, and multiple requests per
>> > master, it sounds like the cleanest descriptor form would
>> > be
>> >
>> >         <controller master request>;
>> >
>> > Or possibly
>> >
>> >         <controller master request direction>;
>> >
>> > if the direction needs to be known at the time the channel
>> > is requested.
>>
>> Its better to keep masters as is. So, that we can use appropriate
>> masters for peripheral and memory to make the transfer fast.
>
> So you mean keep the format as
>
>         <controller request src-master dst-master>;
>
> ?

Yes..

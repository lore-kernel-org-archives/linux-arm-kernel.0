From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 24 Sep 2014 10:27:19 +0200
Subject: [PATCH v13 0/9] Per-user clock constraints
In-Reply-To: <5421DF46.2010107@codeaurora.org>
References: <1411497613-24049-1-git-send-email-tomeu.vizoso@collabora.com>
 <5421DF46.2010107@codeaurora.org>
Message-ID: <54228067.3090600@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 10:59 PM, Stephen Boyd wrote:
> On 09/23/14 11:40, Tomeu Vizoso wrote:
>> Hello,
>>
>> this version of the patchset addresses some issues that Russell pointed out
>> yesterday:
>>
>> * Refactor the changes to clkdev.c to reduce the amount of ifdefs.
>>
>> * Properly release clocks when there isn't enough memory to create the per-user
>> wrapper.
>>
>> * Add clk_provider_put(struct clk_core*) for clock implementations to call
>> instead of clk_put(struct clk*) (instead of exposing __clk_put).
>>
>> As the previous versions, this is based on top of 3.17-rc4 and Mike's patch at
>> [0].
> 
> Any thoughts on my comments on patch set #10[1]? It seems like we can
> avoid having a flag day to support this.

I cannot say that I fully understand your proposal, but IMO the most
valuable thing in this patchset is precisely the API split (and thus,
the flag day is inherent to it).

I see a lot of value in clk consumers to use a defined set of functions
that all take and/or return struct clk, and for providers to use the
functions that take and/or return struct clk_core. Makes the API clearer
and allows it to have a more scalable growth in the future.

A less important feature of the patchset are per-user clocks, which (if
I understand correctly) your proposal would address without requiring a
flag day.

And then we have clock constraints, which is probably the least
important feature in the grand scheme of things, but it's actually what
I personally care about.

If we wanted to add a way for clk users to specify clock constraints
without any refactoring, we could easily do so by reusing the request
pattern that pm_qos uses:

void clk_add_constraint(struct clk_request *req,
                        int constraint_type,
                        unsigned long value);

void clk_update_constraint(struct clk_request *req,
                           unsigned long new_value);

void clk_remove_constraint(struct clk_request *req);

It wouldn't be that bad IMO, but the API refactoring was something that
was long desired and this was seen as a good opportunity to tackle it
before it gets worst.

Cheers,

Tomeu

> [1] https://lkml.org/lkml/2014/9/9/960
> 

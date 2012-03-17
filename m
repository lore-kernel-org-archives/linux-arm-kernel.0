From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 17 Mar 2012 11:06:15 -0700
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <CA+gwMcdzHpGhLXXh5QTYid+rBtj8cGqFS9Te4QB3rpR9B8hXUw@mail.gmail.com>
References: <1331919483.31118.23.camel@flow>
 <CAJOA=zN2dxgjQ8EZYAwE=OLO1GLdArqy1Xf18F82en9QvFi4cw@mail.gmail.com>
 <CA+gwMcdzHpGhLXXh5QTYid+rBtj8cGqFS9Te4QB3rpR9B8hXUw@mail.gmail.com>
Message-ID: <CAJOA=zOQ5x-idULPvM9acGNBL2onnT_+aZL9r1xUZ0MZ6jZo9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 3:24 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Hi Mike,
>
> On Fri, Mar 16, 2012 at 11:03 PM, Turquette, Mike <mturquette@ti.com> wrote:
>> On Fri, Mar 16, 2012 at 10:38 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
>>> ?#define DEFINE_CK(_name, _cken, _ops) ? ? ? ? ? ? ? ? ?\
>>> -struct clk clk_##_name = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>>> - ? ? ? ? ? ? ? .ops ? ?= _ops, ? ? ? ? ? ? ? ? ? ? ? ? \
>>> + ? ? ? struct clk clk_##_name; ? ? ? ? ? ? ? ? ? ? ? ? \
>>> + ? ? ? static struct clk_pxa clk_pxa_##_name = { ? ? ? \
>>> + ? ? ? ? ? ? ? .hw = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>>> + ? ? ? ? ? ? ? ? ? ? ? .clk = &clk_##_name, ? ? ? ? ? ?\
>>> + ? ? ? ? ? ? ? }, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>>> ? ? ? ? ? ? ? ?.cken ? = CKEN_##_cken, ? ? ? ? ? ? ? ? \
>>> + ? ? ? }; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>>> + ? ? ? static struct clk clk_##_name = { ? ? ? ? ? ? ? \
>>> + ? ? ? ? ? ? ? .name ? = #_name, ? ? ? ? ? ? ? ? ? ? ? \
>>> + ? ? ? ? ? ? ? .ops ? ?= _ops, ? ? ? ? ? ? ? ? ? ? ? ? \
>>> + ? ? ? ? ? ? ? .hw ? ? = &clk_pxa_##_name.hw, ? ? ? ? ?\
>>> ? ? ? ?}
>>
>> Hi Philipp,
>>
>> It looks like your macros do not initialize the .parent_names,
>> .num_parents or .flags members of struct clk. ?__clk_init expects
>> those to be initialized before being called. ?The kerneldoc for
>> __clk_init states this:
>> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=e2cce6fa604686ea3bca0496998322bacaed854d;hb=c5836d8acd9846ec1675b269d994d96a8ee44df4#l49
>
> Yes, thank you! That was the problem.

Awesome!  Glad that it's working for you now without the hacks.

>> You can use the macros for the basic clocks types as templates. ?The
>> gate and mux macros are good to look at since those show how to handle
>> a single-parent and multi-parent clock, respectively:
>> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=5e4312b6f5ccb1072273ce94e235874c74dd852d;hb=2508b44cd5c134691dc5d679f728bbf82af2abe0#l83
>> and
>> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=5e4312b6f5ccb1072273ce94e235874c74dd852d;hb=2508b44cd5c134691dc5d679f728bbf82af2abe0#l148
>
> If there was a fixed fractional divider clk element, a lot of the
> peripheral clocks could be derived from a fixed clk representing the
> 312 MHz PPLL on PXA27x (fixed -> divider -> gate), using just the
> basic clock templates.

We need more common clock types, no question.  I have code for
fixed-dividers and a standard "dummy" clock which I think will be
critical for DT clock bindings when wiring up discrete devices.
Sascha probably has what you need in his tree already.

All of these changes are welcome additions to the framework, but I
didn't want to slow down the merge process with feature creep.  Happy
to take any patches from you in the future.

Regards,
Mike

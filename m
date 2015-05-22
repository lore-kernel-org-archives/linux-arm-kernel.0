From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 May 2015 12:42:35 -0500
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAL_JsqK-P=mMsgH27==Mjs2_Ji=uLcYDrecnT7rsDVYk62zmpA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <555D750F.80304@ti.com> <20150522140457.GB7730@linux>
 <CAL_JsqK-P=mMsgH27==Mjs2_Ji=uLcYDrecnT7rsDVYk62zmpA@mail.gmail.com>
Message-ID: <555F6A8B.9010407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2015 11:04 AM, Rob Herring wrote:
> On Fri, May 22, 2015 at 9:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 21-05-15, 01:02, Nishanth Menon wrote:
>>> This argues that clock is an input to the cpu, this is not in-correct,
>>> but, it could also be argued that OPP tables are clock dependent.
> 
> What piece of h/w is the clock an input to then?

The case(from one of the SoCs I deal with) I had in my mind was
something as follows:
GPU can get it's clock from a tree derived out of DPLL X OR a clock
derived out of DPLL Y.

Frequencies a,b,c can only be supported on DPLL X, where as frequencies
d,e,f on DPLL Y based tree.

There are many ways to skin the cat in this case.. if the clk mux is
glitchless, then a-f can be supported, else, we have to have two opp
tables which are selected by driver based on clock parent.

With the case where we cannot switch between the DPLLs, the question was
interesting if we decided to hook up the clock into the opp table based
on the fact that the frequencies are based of the clock.

The final clock feeding in to GPU, is the mux clock - every thing else
gets hidden by CCF, unless the driver is aware of the clock topology
(which we dont like to see in driver, since the driver is supposed to
work across multiple SoCs) - Now, the OPP tables would obviously be
based on which DPLL the source is from.

Our interest was not to have SoC specificity inside the driver and help
try and describe everything within DT itself - including the choice of
DPLL X based or DPLL Y based selection being made based on board (each
board tends to be targetted for some unique performance needs based on
usecase the board is being planned to be used for).

Ofcourse, with some platform specific code, this might be very easy to
do as well.. so not really very hard reasoning for me to have clock in
OPP table description itself.

> 
>>> For example, with multiple clock source options that a device might
>>> choose to select from internally(by some means.. lets not just restrict
>>> ourselves to just CPUs here for a moment), the tables might be
>>> different. We can always debate that this then is the responsibility of
>>> the driver handling the description for that device and we might want
>>> possibility of vice versa as well - same OPP table used by different
>>> clock source selections as well.
>>
>> @Rob: Any inputs ?
> 
> If you are going to describe this clock mux in DT, then that mux
> should be part of the h/w block that controls it. You could always add
> entries that describe what parent clock must be used for a given OPP,
> but that is a new binding and not part of the existing clock binding.
> 
> If things get too complicated, then don't try to describe this in DT.
> That is always an option.

Yes, ofcourse... it is always an option, we just tend to like to have
all data in the same place if possible - DT is the preferred approach.

-- 
Regards,
Nishanth Menon

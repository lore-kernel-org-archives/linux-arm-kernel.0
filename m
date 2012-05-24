From: robherring2@gmail.com (Rob Herring)
Date: Thu, 24 May 2012 16:54:09 -0500
Subject: [GIT PULL] DT clk binding support
In-Reply-To: <4FBEA540.1010409@codeaurora.org>
References: <4FB80F32.5090309@gmail.com>
 <20120520030653.GB5810@S2100-06.ap.freescale.net>
 <4FB9A5E7.2070000@gmail.com>
 <20120521064901.GE8140@S2101-09.ap.freescale.net>
 <4FBA89E3.7010106@gmail.com>
 <20120521232616.GF8140@S2101-09.ap.freescale.net>
 <4FBAD545.7060803@gmail.com>
 <20120522021535.GG8140@S2101-09.ap.freescale.net>
 <4FBB134D.6050409@codeaurora.org> <4FBB9A08.2050803@gmail.com>
 <49cd509b59c8172c880b0c8a50c0f02c.squirrel@www.codeaurora.org>
 <4FBCED4D.1040908@gmail.com> <4FBEA540.1010409@codeaurora.org>
Message-ID: <4FBEAE01.7030905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2012 04:16 PM, Saravana Kannan wrote:
> On 05/23/2012 06:59 AM, Rob Herring wrote:
>> On 05/22/2012 08:38 PM, Saravana Kannan wrote:

snip

>>> If only the leaf nodes are defined in DT, then how is the clock platform
>>> driver implementer supposed to instantiate the rest of the tree and
>>> connect it up with the partial list of clocks in DT? So, they have to
>>> switch back and forth between DT and the .c file which defines the rest
>>> and make sure the parent<->child names match?
>>>
>>> To me it looks that it might better to decouple the description of the
>>> clock HW from the mapping of a clock leaf to a consumer device. If we
>>> just
>>> use a string to identify the clock that's consumed by a device, we can
>>> achieve this decoupling at a clean boundary -- clock consumers devices
>>> (UART) vs clock producer devices (clock controller in the SoC, in a
>>> PMIC,
>>> audio codec, etc).
>>>
>>> With the decoupling, we don't have the inconsistency of having some
>>> of the
>>> clocks of a clock producer device incompletely defined in DT and the
>>> rest
>>> of the clocks of the same clock producer device hard coded in the
>>> kernel.
>>> So, you either put your entire clock tree in the SoC in the DT or put
>>> all
>>> of it in the kernel but you aren't forced to put just some of them in
>>> the
>>> DT just to get DT working. I see no benefit in defining only some of the
>>> clocks in DT -- it just adds more confusion in the clock tree
>>> definition.
>>> What am I missing?
>>
>> I fail to see what would need changing in the binding itself. The
>> binding just describes connections. Whether that is a connection to a
>> clock controller node to a device or a clock gate/mux/divider node to a
>> device is really beyond the clock binding. This is really just policy.
>> You are free to put no clocks in DT, all clocks, or a nexus of clocks.
> 
> With the current approach you are taking can you please give an example
> of how a random device described in DT would hook itself up with a leaf
> clock if that leaf clock is not described in DT? So that it can do a
> call a DT version of clk_get() to get the clock it cares for.

No, because that's impossible with any binding. The only way that would
work is provide a string with a clock name and matching to the struct
clk name string. That means putting linux clock names into the h/w
description. That is the wrong direction and not how bindings work.
Defining bindings should not get tangled up with how the OS
implementation is done.

> And no, there is a huge difference between binding a clock controller
> node (by which I mean the block that provides many clocks) to a device
> vs. binding a clock leaf to a device. The former is useless wrt to
> clk_get() and similar functions. The latter is very useful to handle that.

The binding and clkdev changes support clk_get fully. Drivers don't have
to change at all. There is not a DT version of clk_get that all drivers
have to adopt. It's all handled within clk_get and should be transparent
to drivers. The only thing that has to change is callers of clk_get_sys
to use of_clk_get, but that's a small fraction of clocks.

Rob

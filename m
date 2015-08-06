From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 05 Aug 2015 18:44:13 -0700
Subject: [PATCH 5/7] clk: atlas7: fix the clock tree for bluetooth stuff
In-Reply-To: <CAGsJ_4wg1+5KrwTJRzE-iaSTvgvgFrM6cDyUTL16gx6Hk+tdPw@mail.gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
 <55B7FD22.10609@codeaurora.org>
 <CAGsJ_4wg1+5KrwTJRzE-iaSTvgvgFrM6cDyUTL16gx6Hk+tdPw@mail.gmail.com>
Message-ID: <55C2BBED.4050608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 07:52 AM, Barry Song wrote:
> 2015-07-29 6:07 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>> On 07/27/2015 11:27 PM, Barry Song wrote:
>>> From: Guo Zeng <guo.zeng@csr.com>
>>>
>>> normally dmac should depends on only one clock, to operate
>>> dmac internal register, but dmac4 is very special case, it
>>> normally dmac should depends on only one clock, to operate
>>> dmac internal register, but dmac4 is very special case, it
>> The sentence is duplicated twice here
>>
>>> depends on two additional clock, the reason is that dmac4
>>> is wrapped in hw into bt a7ca module, and accessing dmac4
>>> internal register would also require that the a7ca_io and
>>> related bt macro io clk also enabled.
>>> here workaround this by setting depend clk into parent of
>>> dmac4, and also related clks, to reflect dependency.
>> We don't put clocks as parents of other clocks just because the child
>> depends on the parent to be accessed. It isn't very clear from the
>> description, but it sounds like a7ca_io is just another clock that the
>> bluetooth driver needs to control? We want to express the true clk
>> hierarchy, not some psuedo dependency tree.
>>
> Stephen, generically i agree the codes should be a map of real
> hardware connection. here the problem is real hardware connection is
> very much difficult for its drivers implementation and these clocks
> are buggy designed in HW. they are not a tree, they are a "network".
>
> see attached diagram(hope LKML will not reject the attachment), we are
> not a tree,  that means btm_noc_clk depends on btm_io_clk, a7ca_io_clk
> depends on btm_io_clk, dmac4_io_clk depends on btm_noc_clk,
> a7ca_io_clk and btm_noc_clk....
> usp3_io_clk depends on uart6_io_clk, dmac4_io_clk, btm_noc_clk,
> a7ca_io_clk and btm_noc_clk.
>
> so in the driver, we have a choice as below:
> in uart6 driver, we take all of the clocks.
> in dmac4 driver, we take all of btm_noc_clk, a7ca_io_clk and btm_noc_clk.
> ...
> what a ugly code! that is what we did before.
>
> so here, we moved to do a not-real clock tree,  that means
> we makes
> 1.btm_io_clk the parent of btm_noc_clk
> 2. btm_noc_clk the parent of a7ca_io_clk
> 3. a7ca_io_clk the parent of dmac4_io_clk
> ...
>
> but it doesn't break any dependency of these clocks, and make all
> clients driver as clean as a simple tree.
> i strongly think we should keep this "workaround", otherwise, we have
> many pain in all of the related drivers.
>
>

Thanks for the nice PNG. It seems like you have a typical bus topology 
where UART and USP need to go through DMAC and the Data NOC to get out 
on the system bus. btm_io_clk is the true parent of all the clocks.

I can only guess that A7CA is some sort of device that you have to go 
through from the CPU side to access the UART, USP, and DMAC hardware 
blocks. Is that right? Can you please describe what each of these blocks 
do and if there are linux drivers for them?

One way to model this would be to make UART and USP children of the DMAC 
hardware block. And then make a driver/device up for the NOC and have 
the DMAC be a child of the NOC device. Then the NOC would probe and be 
runtime PM enabled to turn on the btm_noc_clk whenever it or its 
children are enabled. Then the DMAC device would do the same thing, but 
with the dmac4_io_clk, and the UART and USP devices would get the 
uart6_io_clk and usp3_io_clk respectively and enable/disable them when 
the device is active.

That leaves us with the a7ca_io_clk, which is really just the clock for 
a bus that register read/writes go through. In designs I've seen, I 
usually left that clock under the control of each individual device that 
sits on the bus. So in this case, the DMAC, USP and UART device drivers 
would all need to get the a7ca_io_clk as their "interface" clock and 
make sure to enable or disable it whenever the driver wants to 
read/write the registers. I'm not sure if something else is done on the 
APB for you, but that may be all that's necessary.

This actually points out a big problem we have right now in Linux, which 
is the lack of proper power management for the type of bus topology you 
see in embedded systems. Some of the genpd work going on may also be 
another solution to this problem, where we could group multiple devices 
into generic power domains that know to turn on 2 or 3 of the clocks. 
For example, the DMAC, USP, and UART device could all be in the APB 
power domain so that the a7ca_io_clk is enabled whenever one of those 
devices is active. And there could be another power domain for the NOC 
that encompasses all devices that are sitting on that NOC.

Long story short, solving these sorts of problems in the clk framework 
is typically the easy route that people take, although it's the wrong 
route. We're not expressing these sorts of complicated bus topologies in 
the clk framework. We're only expressing the clk tree (which is already 
quite complicated enough). Your drivers can still be simple, but don't 
make it more complicated than it has to be in the clk framework for that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

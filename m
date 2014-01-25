From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 25 Jan 2014 19:11:07 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <52E43046.1030105@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52E42D6A.5050508@elopez.com.ar> <52E43046.1030105@gmail.com>
Message-ID: <52E4367B.3090608@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

El 25/01/14 18:44, Sebastian Hesselbarth escribi?:
> On 01/25/2014 10:32 PM, Emilio L?pez wrote:
>> El 25/01/14 15:19, Sebastian Hesselbarth escribi?:
>>> This patch set fixes clk init order that went upside-down with
>>> v3.14. I haven't really investigated what caused this, but I assume
>>> it is related with DT node reordering by addresses.
>>
>> The framework should be able to deal with unordered registration. I am
>> not very familiar with the mvebu driver though, do you have a valid
>> reason to require a specific order?
>
> Emilio,
>
> I rather think that everthing registered with CLK_OF_DECLARE cannot
> deal with unordered registration. The callback passed to CLK_OF_DECLARE
> has to have void as return value, so there is no way to pass errors,
> e.g. -EPROBE_DEFER, back to of_clk_init.

Indeed. What I meant is that the framework works fine if you first 
register a child clock that refers to a not yet registered parent, and 
then register the parent. The registration need not be strictly ordered.

> The reason for this ordering is that the clock gates depend on core
> clocks. It is always that way, so merging both init functions isn't
> that odd.

If your only dependency is the parent name, and you can use DT or 
something else to get it, then you don't need to enforce an order.

>>> Anyway, with v3.14 for MVEBU SoCs, the clock gating driver gets
>>> registered before core clocks driver. Unfortunately, we cannot
>>> return -EPROBE_DEFER in drivers initialized by clk_of_init.
>>
>> Why would you need to do so? After a quick inspection on the code, I see
>> you may have problems on mvebu_clk_gating_setup() when getting the
>> default parent clock name, but I believe you could solve it in an easier
>> way by using of_clk_get_parent_name().
>
> Ok, I'll look if using of_clk_get_parent_name will help here. But again,
> I can see that clk-gating driver gets registered before core-clk driver.
> There may be no code to give you the parent name at that time.

After looking at some of the armada*.dtsi, I see you don't list the 
clock names on the coreclk node, so of_clk_get_parent_name may not be of 
much value after all.

Cheers,

Emilio

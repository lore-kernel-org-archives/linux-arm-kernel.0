From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 11:31:00 -0700
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to
 DT bindings
In-Reply-To: <20131202085257.GA17834@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
 <20131129114900.GN22771@ulmo.nvidia.com> <529B8888.3010801@wwwdotorg.org>
 <20131202085257.GA17834@ulmo.nvidia.com>
Message-ID: <529E2364.6000205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 01:52 AM, Thierry Reding wrote:
> On Sun, Dec 01, 2013 at 12:05:44PM -0700, Stephen Warren wrote:
>> On 11/29/2013 04:49 AM, Thierry Reding wrote:
>>> On Fri, Nov 15, 2013 at 01:53:56PM -0700, Stephen Warren wrote:
>>>  [...]
>>>> @@ -60,6 +81,12 @@ of the following host1x client modules: - 
>>>> compatible: "nvidia,tegra<chip>-dc" - reg: Physical base
>>>> address and length of the controller's registers. -
>>>> interrupts: The interrupt outputs from the controller. +  -
>>>> clocks : Must contain an entry for each entry in clock-names.
>>>> +    See ../clocks/clock-bindings.txt for details. +  -
>>>> clock-names : Must include the following entries: +    -
>>>> disp1 or disp2 (depending on the controller instance)
>>> 
>>> I'm not sure if this makes sense. The name could be the same 
>>> independent of which controller uses it. If it isn't then the 
>>> driver would need additional code to find out which instance it
>>> is and construct a dynamic string.
>>> 
>>> Any objection to just make this entry "disp", or "dc"?
>> 
>> This patch simply documents the binding that the various drivers 
>> already require and/or whatever is already in the DT files if
>> there are any clocks the drivers don't currently use. I did
>> consider fixing up all the current usage to actually be sane, but
>> that would require even more driver changes (in addition to those
>> required for the reset framework patches).
> 
> Okay, I understand. I still think we should change the usage for
> this particular use-case subsequently. In retrospect the entry in
> clock-names wasn't thought out very well. It seems like the reason
> for using disp1 and disp2 respectively was so that it would match
> the system-wide clock name, rather than the clock's label within
> the display controller's context.
> 
> Just to clarify what I mean, if we stick to the above, then we'll
> need to add code to the driver along the lines of:
> 
> char clock_name[6];
> 
> if (regs->start == 0x54200000) index = 1; else index = 2;
> 
> sprintf(clock_name, "disp%u", index);
> 
> clk = devm_clk_get(&pdev->dev, clock_name);
> 
> rather than the much more simple and elegant:
> 
> clk = devm_clk_get(&pdev->dev, "disp");
> 
> The whole purpose of the clock consumer ID is to be generic and as
> such independent of the specific IP block or instance thereof.

I think if the code needs this clock, I'd be tempted to do the following:

clk = clk_get(dev, "disp1");
if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFERRED)
    clk = clk_get(dev, "disp2");
if (IS_ERR(clk))
    return PTR_ERR(clk);

That avoids having to hard-code IP block base addresses and construct
clock names at run-time.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Jun 2014 17:24:47 -0600
Subject: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
In-Reply-To: <20140618231410.GG26514@mithrandir>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <53A069B6.6070902@wwwdotorg.org> <53A1CB23.5090307@collabora.com>
 <53A1D089.8010605@wwwdotorg.org> <20140618220343.GD26514@mithrandir>
 <53A20E02.5050900@wwwdotorg.org> <20140618231410.GG26514@mithrandir>
Message-ID: <53A21FBF.5090806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 05:14 PM, Thierry Reding wrote:
> On Wed, Jun 18, 2014 at 04:09:06PM -0600, Stephen Warren wrote:
>> On 06/18/2014 04:03 PM, Thierry Reding wrote:
...
>>> From what I remember, Mike was fairly strongly opposing the idea of
>>> virtual clocks, but what you're proposing here sounds like it would
>>> assume the existence of virtual clocks. clk_set_rate() per client
>>> doesn't work with the current API as I understand it.
>>>
>>> Or perhaps what you're proposing isn't about the individual clocks at
>>> all but rather about a mechanism to express constraints for a set of
>>> clocks?
>>
>> This doesn't have anything to do with virtual clocks. As you mention,
>> it's just about constraints.
>>
>> One user of clock "cpu" wants min rate 216MHz. Another wants max rate
>> 1GHz. cpufreq will request some rate between the 2, or be capped to
>> those limits. These set of imposed constraints would need to be stored
>> per client of the clock, not per HW clock, since many clients could set
>> different max rates (e.g. thermal throttle 1.5GHz due to temperature,
>> CPU policy 1GHz due to the user selecting low CPU power, etc.)
>>
>> Similarly for audio, of there are N clients of 1 clock/PLL, and they
>> each want the PLL to run at a different rate, something needs to detect
>> that and deny it.
> 
> I'm wondering how this should work with the current API. Could the clock
> core be modified to return a per-client struct clk * that references the
> hardware clock internally? Or do we need to add a new API?

I would assume the we can just change struct clk and hide the details
from any driver. Hopefully only clock-core and clock-drivers would need
any changes.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/e86187fa/attachment.sig>

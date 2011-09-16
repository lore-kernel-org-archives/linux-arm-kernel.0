From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2011 12:21:16 -0700
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <alpine.LFD.2.00.1109161345560.20358@xanadu.home>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
	<4E73858A.9050106@codeaurora.org>
	<alpine.LFD.2.00.1109161345560.20358@xanadu.home>
Message-ID: <4E73A1AC.20709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/11 11:09, Nicolas Pitre wrote:
> On Fri, 16 Sep 2011, Stephen Boyd wrote:
>
>
>> This looks like:
>>
>>     return clamp(bank_pfn_start(a) - bank_pfn_start(b), -1, 1);
> Won't work.  The pfn is of an unsigned type, hence the subtraction 
> result will also be unsigned.  The code above looks a bit odd, but there 
> is an implicit cast to a signed result with the result stored into a 
> long.
>
> What would have been even clearer, and possibly more efficient as well, 
> is something like this:
>
> 	if (bank_pfn_start(a) < bank_pfn_start(b))
> 		return -1;
> 	if (bank_pfn_start(a) > bank_pfn_start(b))
> 		return 1;
> 	return 0;

Ok so

    return clamp_t(long, bank_pfn_start(a) - bank_pfn_start(b), -1, 1); 


?

>
> But the goal here was to simply move the code, changing it would warrant 
> a separate patch.

Fair enough.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

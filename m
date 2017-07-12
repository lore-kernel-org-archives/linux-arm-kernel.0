From: slash.tmp@free.fr (Mason)
Date: Wed, 12 Jul 2017 11:58:53 +0200
Subject: cpufreq: frequency scaling spec in DT node
In-Reply-To: <20170712034150.GD17115@vireshk-i7>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
 <20170711102514.GC17115@vireshk-i7>
 <c0838592-5613-660d-56fc-e7022a38a86d@free.fr>
 <20170712034150.GD17115@vireshk-i7>
Message-ID: <9476e8ee-24ae-1676-067b-18a867892894@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2017 05:41, Viresh Kumar wrote:

> On 11-07-17, 13:09, Mason wrote:
>
>> What I meant is that the bootloader originally set the max frequency
>> to 1206 MHz. The OPP table in DTS was written based on that value.
>>
>> Later, someone changed the bootloader code to set a slightly higher
>> max frequency. When I flashed the new bootloader on my board, the
>> OPP table no longer matches the actual frequency.
>>
>> But I am not notified when bootloader authors change max frequencies,
>> which is why I wrote "changed the max freq behind my back".
>>
>> (The bootloader is not DT-aware, so it leaves the DT untouched.)
> 
> Here we go. Finally I have understood what the problem you are facing is :)
> And yes, it was really not clear to me until now. I though that someone just
> changed the max in DT and that's making things go bad :)
> 
> Anyway, how does the bootloader control the max frequency? For the boards I
> worked on, it's just a PLL that the kernel needs to set and kernel can choose to
> program it the way it wants to irrespective of the way bootloader has worked on it.

I would object to the characterization of "just a PLL" :-)

The PLL outputs "garbage" before actually "locking" a target
frequency. It is not possible for the CPU to blindly change
the PLL settings, because that crashes the system.

The bootloader implements the steps required to change said
settings, so the strategy has been: have Linux use whatever
PLL frequency the bootloader programs.

Behind the PLL, there is a glitch-free divider, which is able
to divide the PLL output without crashing the system. I've
been using that divider for DFS.

drivers/clk/clk-tango4.c

Regards.

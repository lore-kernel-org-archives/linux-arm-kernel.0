From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 21 May 2015 09:25:31 +0300
Subject: [GIT PULL 4/8] clk: tegra: Changes for v4.2-rc1
In-Reply-To: <20150520195459.GU31753@codeaurora.org>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-5-git-send-email-thierry.reding@gmail.com>
 <20150520195459.GU31753@codeaurora.org>
Message-ID: <555D7A5B.1070901@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2015 10:54 PM, Stephen Boyd wrote:
> On 05/13, Thierry Reding wrote:
>> Hi Mike, Stephen,
>>
>> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>>
>>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-clk
>>
>> for you to fetch changes up to 36b7be6d3ea8f434f1e0723f3fb0e85c3e00ebc2:
>>
>>   clk: tegra: Fix hda2codec_2x clock name for Tegra30 (2015-05-13 15:17:14 +0200)
>>
>> I've based this pull request on top of the tegra-for-4.2-ramcode pull
>> request, so pulling only this one should be sufficient to resolve the
>> dependency.
>>
>> Thanks,
>> Thierry
>>
>> ----------------------------------------------------------------
>> clk: tegra: Changes for v4.2-rc1
>>
>> This contains the EMC clock driver that's been exhaustively reviewed and
>> tested. It also includes a change to the clock core that allows a clock
>> provider to perform low-level reparenting of clocks. This is required by
>> the EMC clock driver because the reparenting needs to be done at a very
>> specific point in time during the EMC frequency switch.
> 
> Can someone please describe why we need to do software
> reparenting at a specific point in time during a frequency
> switch? I must have missed out on the conversation somewhere and
> looking at the commit that introduces the function, the argument
> for why the API is exposed:
> 
>       To be used by clock implementations for switching to a new
>       parent during rate change.
> 
> is lacking in any details about *why* we need it.
> 

Hi Stephen,

the way the EMC clock rate is set in hardware is similar to other
clocks, i.e. there's a register and you write the new divider and parent
id to it. However, with EMC, you cannot just do this any time you want;
writing to the register initiates a state machine in the clock hardware
that changes a large number of other parameters regarding DRAM timings
as well. These parameters need to be programmed into shadow registers
before the rate change write is done. This means that both the new
divisor and the parent must be written in the same register write.

The CCF has a callback, set_rate_and_parent, which allows for both to be
passed to the driver at the same time. However, it also requires
set_rate and set_parent to be implemented, which the EMC driver cannot do.

Furthermore, the CCF cannot help with parent selection for the EMC clock
at all. The parent for each rate is selected by the board designer.

There is also the issue that sometimes, the EMC driver cannot directly
switch to the target (rate, parent) pair; instead it is necessary to
switch first to another pair we call a backup timing. In this situation,
we temporarily have a parent that is neither the one we had before the
set_rate call or the one it will be after. Especially, if the switch to
the backup timing succeeds but the following switch to the target timing
fails, then without the reparent call the parent in hardware would be
left inconsistent with the software state.

This is why we've decided to implement the driver with only the set_rate
callback and decide the required transitions within the driver.
This also means that the driver needs to have a function to tell the CCF
that it has changed its parent.

Thanks,
Mikko.

nvpublic

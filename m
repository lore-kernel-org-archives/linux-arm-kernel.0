From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Sep 2011 16:06:02 +0530
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110929102213.GB7453@e102568-lin.cambridge.arm.com>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
	<4E8403BE.9050302@ti.com>
	<20110929102213.GB7453@e102568-lin.cambridge.arm.com>
Message-ID: <4E844A12.7050507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2011 03:52 PM, Lorenzo Pieralisi wrote:
> On Thu, Sep 29, 2011 at 06:35:58AM +0100, Santosh Shilimkar wrote:
>> Barry,
>>
>> On Monday 26 September 2011 08:56 AM, Barry Song wrote:
>>> we save the l2x0 registers at the first initialization, and platform codes
>>> can get them to restore l2x0 status after wakeup.
>>>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
> 
> [...]
> 
>>> +
>>> +struct l2x0_regs {
>>> +	unsigned long aux_ctrl;
>>> +	/*
>>> +	 * Whether the following registers need to be saved/restored
>>> +	 * depends on platform
>>> +	 */
>>> +	unsigned long tag_latency;
>>> +	unsigned long data_latency;
>>> +	unsigned long filter_start;
>>> +	unsigned long filter_end;
>>> +};
>>> +
>> You are missing POR register here which is available on
>> PL310 versions. You should add that.
>>
> 
> In latest versions there are Prefetch and Power control registers, but
> it depends on the revision. What should we do in this case Santosh ?
> PCR is a superset of POR from r3p0 onwards, but Power control ? Leave it
> to platform code ?
> 
Good point Lorenzo.
C code resume can be fixed by marking the validity based
on PL310 revision register.
The asm code restore with MMU OFF code, would be handled
with platform code with this patch and platform code can choose
restore of only supported registers.

Regards
Santosh

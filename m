From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 May 2015 15:09:24 +0100
Subject: [PATCH] irqchip: GICv3: ITS: don't assume 64K page size in
 its_alloc_tables
In-Reply-To: <CY1PR0301MB074884E252ADE216BD8C472887C40@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1431644545-31904-1-git-send-email-stuart.yoder@freescale.com>
 <5559E7CE.1050003@arm.com>
 <CY1PR0301MB074884E252ADE216BD8C472887C40@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <5559F294.5070701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/15 14:38, Stuart Yoder wrote:
> 
> 
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>> Sent: Monday, May 18, 2015 8:23 AM
>> To: Yoder Stuart-B08248; tglx at linutronix.de
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] irqchip: GICv3: ITS: don't assume 64K page size in its_alloc_tables
>>
>> Hi Stuart,
>>
>> On 15/05/15 00:02, Stuart Yoder wrote:
>>> its_alloc_tables() needs to account for page sizes other than
>>> 64KB.  Without this change, when PAGE_SIZE=4KB its_alloc_tables()
>>> gets stuck in an infinite loop.
>>>
>>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>>> ---
>>>
>>> think this should go into 4.1 if at all possible...without it I am
>>> unable to boot a 4.1 kernel on the LS2085 SoC
>>
>> What you are suggesting here is a effectively a revert of commit
>> 790b57a, which would break other implementations.
>>
>> Can you please explain the actual issue? I'm failing to see how you end
>> up in an infinite loop here (the system page size and the ITS base
>> granule should be completely unrelated...).
> 
> Here is the problem line:
> 
>       val |= (alloc_size / psz) - 1;
> 
> In our case:
>    alloc_size=16K
>    psz=64K
> 
> ...so (alloc_size / psz) = 0, and thus val becomes -1, and everything
> is screwed up.  We get stuck in a loop to retry_baser:

If alloc_size is 16k, you have an order of 2, and I have to assume this
is an allocation for a device table (otherwise order would be 4). So
things fail because we've computed an alloc_size smaller than what we
want to allocate as a minimum.

Isn't that exactly what Minghuan's patch fixes?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

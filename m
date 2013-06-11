From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Jun 2013 12:41:06 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130611172342.GJ3439@mudshark.cambridge.arm.com>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
Message-ID: <51B76F42.2020704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 11:23 AM, Will Deacon wrote:
> Hi Stephen,
> 
> On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> machine_shutdown() is a hook for kexec. Add a comment saying so, since
>> it isn't obvious from the function name.

>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index 282de48..dbe1692 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
>>  {
>>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>>  
>> +	BUG_ON(num_online_cpus() > 1);
> 
> I think this is overkill, and we could actually scream and try to return an
> error here (we've not yet switched stack, and the upper layers of kexec look
> like they can do something with an error code).

Oh, that's the BUG_ON I added to soft_restart() not the one I added into
machine_shutdown().

I added this one to make sure nobody was using soft_restart() on an SMP
machine; Russell had asked to validate that all SMP systems provided a
HW restart implementation.

I assume your comments re: aborting the kexec by returning an error code
apply more to machine_shutdown() which happens a bunch earlier.

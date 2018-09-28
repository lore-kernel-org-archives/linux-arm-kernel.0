From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Sep 2018 11:33:48 +0100
Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
In-Reply-To: <44ac1fad-8df4-4738-0f25-8a7a2de8f6df@codeaurora.org>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <44ac1fad-8df4-4738-0f25-8a7a2de8f6df@codeaurora.org>
Message-ID: <911a666a-9f11-5c23-77a4-658afba02644@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 27/09/18 22:10, Richard Ruigrok wrote:
> Hi Marc
> 
> On 9/21/2018 1:59 PM, Marc Zyngier wrote:
>> The GICv3 architecture has the remarkable feature that once LPI tables
>> have been assigned to redistributors and that LPI delivery is enabled,
>> there is no guarantee that LPIs can be turned off (and most
>> implementations do not allow it), nor can it be reprogrammed to use
>> other tables.
>>
>> This is a bit of a problem for kexec, where the secondary kernel
>> completely looses track of the previous allocations. If the secondary
>> kernel doesn't allocate the tables exactly the same way, no LPIs will
>> be delivered by the GIC (which continues to use the old tables), and
>> memory previously allocated for the pending tables will be slowly
>> corrupted, one bit at a time.
>>
>> The workaround for this is based on a series[1] by Ard Biesheuvel,
>> which adds the required infrastructure for memory reservations to be
>> passed from one kernel to another using an EFI table.
>>
>> This infrastructure is then used to register the allocation of GIC
>> tables with EFI, and allow the GIC driver to safely reuse the existing
>> programming if it detects that the tables have been correctly
>> registered. On non-EFI systems, there is not much we can do.
>>
>> This has been tested on a TX2 system both as a host and a guest. I'd
>> welcome additional testing of different HW. For convenience, I've
>> stashed a branch containing the whole thing at [2].
> I tested [2] from the 4.19-rc4 set which included this series and [1].
> Tested kexec on Centriq system with ITS support (46 core).? On-board was a MLX CX5 NIC, verified MSIs are active in /proc/interrupts.
> Prior to this we used a workaround from Shanker to reuse the same tables in the kexec'ed kernel.

Yes, I remember seeing this workaround. Hopefully we're in a better 
place now that we can guarantee that the tables are not reused.

> Let me know if further testing is needed, and thanks for adding this support.

Good to know, thanks for having tested it. I've now put this code into 
-next for some more soaking. Hopefully nothing horrible will happen ;-)

	M.
-- 
Jazz is not dead. It just smells funny...

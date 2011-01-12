From: dima@android.com (Dima Zavin)
Date: Wed, 12 Jan 2011 15:17:38 -0800
Subject: [PATCH] ARM: use memblock memory regions for "System RAM" I/O
	resources
In-Reply-To: <20110112231138.GL11039@n2100.arm.linux.org.uk>
References: <1294871757-11391-1-git-send-email-dima@android.com>
	<20110112231138.GL11039@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin6oZKrq-z6yEQqGhAcknfDkW0PEaYMfGS7gJq8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yes. I'll respin the patch.

On Wed, Jan 12, 2011 at 3:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 12, 2011 at 02:35:57PM -0800, Dima Zavin wrote:
>> Do not use memory bank info to request the "system ram" resources as
>> they do not track holes created by memblock_remove inside
>> machine's reserve callback. If the removed memory is passed as
>> platform_device's ioresource, then drivers that call
>> request_mem_region would fail due to a conflict with the incorrectly
>> configured system ram resource.
>>
>> Instead, iterate through the regions of memblock.memory and add
>> those as "System RAM" resources.
>>
>> Signed-off-by: Dima Zavin <dima@android.com>
>> ---
>> ?arch/arm/kernel/setup.c | ? 10 ++++------
>> ?1 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 336f14e..c3aa394 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -520,6 +520,7 @@ setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
>> ?static void __init
>> ?request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
>
> Doesn't this means we can get rid of the 'mi' argument?
>

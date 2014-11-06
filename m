From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 6 Nov 2014 19:56:36 +0000
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141106155823.213f8811@free-electrons.com>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141106155823.213f8811@free-electrons.com>
Message-ID: <545BD274.6050103@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11/07/2014 03:58 AM, Thomas Petazzoni wrote:
> Dear Chris Packham,
>
> On Thu,  6 Nov 2014 17:49:56 +1300, Chris Packham wrote:
>> The machine specific SMP operations can be configured either via
>> setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
>> both of these are called and setup_arch wins because it is called last.
>> This means that it is not possible to substitute a different set of SMP
>> operations via the device-tree.
>>
>> All of the ARMADA_370_XP_DT compatible devices are either single core or
>> declare an enable-method in the dts (via one of armada-xp-mv78230.dtsi,
>> armada-xp-mv78260.dtsi or armada-xp-mv78460.dtsi). Remove the smp
>> assignment from board-v7.c so that the SMP operations set via the
>> device-tree aren't discarded.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>> Hi,
>>
>> (This is the first patch I've sent to the arm-lkml so beware of my newbie-ness)
>>
>> I'm working on a new board that uses a integrated CPU that according to the
>> vendor is "based on the ARMADA-XP", more on that to come in the future
>> hopefully. For the most part things just work if I use a .dts based on the
>> mv78260.
>>
>> One difference I've encountered is in the way the secondary CPU is initialised,
>> which requires me to supply a slightly different set of machine specific SMP
>> operations so I can bring up the 2nd core. It looks like I should be able to
>> supply a different /cpus/enable-method in the .dts and once I define the
>> corresponding set of operations it should be picked up.
>>
>> Which leads me to what I think could be a bug (or just a lack of clear
>> specification). The smp ops are set by both arm_dt_init_cpu_maps (from the
>> enable-method) and setup_arch (from mdesc). The latter always wins because it
>> is called last and doesn't check to see if smp_ops has already been set.
>>
>> This is my attempt at fixing the problem by not setting mdesc.smp for the
>> ARMADA_370_XP_DT machines thus preventing setup_arch from overriding what has
>> been setup by arm_dt_init_cpu_maps.
>>
>> Thanks,
>> Chris
>>
>>   arch/arm/mach-mvebu/board-v7.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
>> index 6478626..894974b 100644
>> --- a/arch/arm/mach-mvebu/board-v7.c
>> +++ b/arch/arm/mach-mvebu/board-v7.c
>> @@ -206,7 +206,6 @@ static const char * const armada_370_xp_dt_compat[] = {
>>   DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>>   	.l2c_aux_val	= 0,
>>   	.l2c_aux_mask	= ~0,
>> -	.smp		= smp_ops(armada_xp_smp_ops),
>>   	.init_machine	= mvebu_dt_init,
>>   	.init_irq       = mvebu_init_irq,
>>   	.restart	= mvebu_restart,
> There is a very good reason to keep this .smp initialization. The
> Device Tree for Armada XP used to *not* have the enable-method
> property, since the SMP enable-method binding did not exist at the
> time we introduced the Armada XP SMP support. Therefore, if we want to
> keep backward compatibility with the old Armada XP DTs and continue to
> have SMP support working with those, we need to keep this .smp
> initialization essentially forever.
>
> Yes, backward compatibility sometimes sucks :-/
Darn. I thought that might be the case but I wanted to keep the scope of 
my change small. How about making setup_arch check if smp_ops is already 
set? I didn't do that initially because I thought that might affect too 
many platforms. Alternatively if we gave ARMADA_370_XP_DT a smp_init 
function that returned non-zero if smp_ops is already set then I think 
it'd be backwards compatible and keep the scope of the change restricted 
to the 370-XP platforms.

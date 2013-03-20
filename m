From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 20 Mar 2013 13:28:47 -0500
Subject: [PATCH] mach_omap2: use PTR_RET instead of IS_ERR + PTR_ERR
In-Reply-To: <20130312110557.GF30923@n2100.arm.linux.org.uk>
References: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com>
 <20130312110557.GF30923@n2100.arm.linux.org.uk>
Message-ID: <5149FFDF.6050501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/12/2013 06:05 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 12, 2013 at 09:58:29AM +0200, Silviu-Mihai Popescu wrote:
>> This uses PTR_RET instead of IS_ERR and PTR_ERR in order to increase
>> readability.
>>
>> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
>> ---
>>  arch/arm/mach-omap2/devices.c |    4 ++--
>>  arch/arm/mach-omap2/fb.c      |    5 +----
>>  arch/arm/mach-omap2/gpmc.c    |    2 +-
>>  arch/arm/mach-omap2/pmu.c     |    5 +----
>>  4 files changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 1ec7f05..2a0816e 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -66,7 +66,7 @@ static int __init omap3_l3_init(void)
>>  
>>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>>  
>> -	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
>> +	return PTR_RET(pdev);
> 
> This is incorrect.
> 
> The return value will be tested for < 0.  Kernel pointers in general are
> all above 3GB, and so are all "< 0".
> 
> I'm afraid none of these changes stuff is an improvement - they all
> introduce bugs.

Sorry I am now not sure I follow you here. Someone just pointed out to
me that PTR_RET() is defined as ...

static inline int __must_check PTR_RET(const void *ptr)
{
	if (IS_ERR(ptr))
		return PTR_ERR(ptr);
	else
		return 0;
}

So the above change appears to be equivalent. Is there something that is
wrong with the current implementation that needs to be fixed?

Jon

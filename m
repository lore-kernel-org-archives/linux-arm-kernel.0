From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Oct 2013 13:53:28 -0600
Subject: [PATCH] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <CAL_JsqLF4WbmuW5PQUKV0nb2GS=iiXnJzO=VmP1g=AT2d7o-WQ@mail.gmail.com>
References: <1381352107-32464-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqLF4WbmuW5PQUKV0nb2GS=iiXnJzO=VmP1g=AT2d7o-WQ@mail.gmail.com>
Message-ID: <526EC0B8.2080307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2013 09:34 AM, Rob Herring wrote:
> On Wed, Oct 9, 2013 at 3:55 PM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> As part of the effort to ultimately remove struct machine_desc, the
>> machine name is not really needed. It is only used for /proc/cpuinfo
>> "Hardware" field. Get this information from the DT instead and remove
>> the name string in the machine descriptor for DT machine descriptors. The
>> model or machine compatible property from the DT is used instead.
>>
>> This likely changes the name reported by /proc/cpuinfo. There could be
>> some userspace dependencies on the old name. Debian libdebian-installer
>> used to use this to determine kernel flavour, but now uses the DT
>> directly. It is not really a good idea for userspace to depend on this
>> anyway.

>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 0e1e2b3..b0747bb 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -611,7 +611,7 @@ void __init dump_machine_table(void)
>>
>>         early_print("Available machine support:\n\nID (hex)\tNAME\n");
>>         for_each_machine_desc(p)
>> -               early_print("%08x\t%s\n", p->nr, p->name);
>> +               early_print("%08x\t%s\n", p->nr, p->name ? p->name : *p->dt_compat);

Does it make sense to iterate over all the entries in p->dt_compat here?
Tegra's machine descriptor supports 4 different compatible values, and I
think that'll only print one of them.

From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 14:12:50 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140606210151.GK23430@n2100.arm.linux.org.uk>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <CAM4voa=1FY5bfk095BU=3X=vzqjnCSfdLoXpCix5tOwDgOoioQ@mail.gmail.com>
 <CAD=FV=UwgPQVm_KvHbpoJNs-5EtpyaYJ2rp2f-466uhnob=ixA@mail.gmail.com>
 <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
 <CAD=FV=U6HuQj3MxZ-yF-MYdjzqjT5bu=K26JuHZP1hjJzkSqbg@mail.gmail.com>
 <20140606210151.GK23430@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=WnMJtagh6rvNdirU-PEc6nz8i_9xX6z-HPz0ZEc4k-7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 6, 2014 at 2:01 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jun 06, 2014 at 01:49:11PM -0700, Doug Anderson wrote:
>> This works and IMHO is much cleaner because it totally removes the
>> U-Boot dependency.  I'll cleanup to not be so insane and post:
>>
>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
>> b/arch/arm/mach-exynos/mcpm-exynos.c
>> index 0498d0b..9c5df7b 100644
>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> @@ -290,6 +290,14 @@ static void __naked
>> exynos_pm_power_up_setup(unsigned int affinity_level)
>>         "b      cci_enable_port_for_self");
>>  }
>>
>> +static void __naked exynos_mcpm_secondary_cpu_start(void)
>> +{
>> +       asm volatile ("\n"
>> +       "ldr    r0, [pc, #0]\n"
>> +       "bx     r0\n"
>> +       ".word  0" );
>> +}
>> +
>
> So does it matter whether the above code gets assembled as thumb or
> ARM?  How does your caller know which ISA mode to enter this fragment
> in?

I'm going to take Olof's suggestion and just hardcode the instructions like:

__raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
__raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);

The caller always jumps to this code with "bx" but always jumps into
ARM mode.  Specifically U-Boot will have:

  branch_bx(CONFIG_EXYNOS_RELOCATE_CODE_BASE);

-Doug

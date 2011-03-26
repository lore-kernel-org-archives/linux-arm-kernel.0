From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 26 Mar 2011 00:44:08 -0600
Subject: [PATCH v4 3/7] arm/dt: consolidate atags setup into
	setup_machine_atags
In-Reply-To: <20110226152734.GA2672@S2100-06.ap.freescale.net>
References: <20110223021524.18318.71902.stgit@localhost6.localdomain6>
	<20110223022218.18318.9687.stgit@localhost6.localdomain6>
	<20110226152734.GA2672@S2100-06.ap.freescale.net>
Message-ID: <AANLkTinHn-FO7YCMqYKFGk_ob+CKUmbbX-P83kbTmhpe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 26, 2011 at 8:27 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Grant,
>
> One minor nitpicking below ...
>
> On Tue, Feb 22, 2011 at 07:22:19PM -0700, Grant Likely wrote:
>> In preparation for adding device tree support, this patch consolidates
>> all of the atag-specific setup into a single function.
>>
>> v4: - adapt to the removal of lookup_machine_type()
>> ? ? - break out dump of machine_desc table into dump_machine_table()
>> ? ? ? because the device tree probe code will use it.
>> ? ? - Add for_each_machine_desc() macro
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> ?arch/arm/include/asm/mach/arch.h | ? ?7 ++++
>> ?arch/arm/kernel/setup.c ? ? ? ? ?| ? 74 +++++++++++++++++++++++---------------
>> ?2 files changed, 51 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
>> index 3a0893a..ed9a10c 100644
>> --- a/arch/arm/include/asm/mach/arch.h
>> +++ b/arch/arm/include/asm/mach/arch.h
>> @@ -52,6 +52,13 @@ struct machine_desc {
>> ?extern struct machine_desc *machine_desc;
>>
>> ?/*
>> + * Machine type table - also only accessible during boot
>> + */
>> +extern struct machine_desc __arch_info_begin[], __arch_info_end[];
>> +#define for_each_machine_desc(p) ? ? ? ? ? ? ? ? ? ? \
>> + ? ? for (p = __arch_info_begin; p < __arch_info_end; p++)
>> +
>> +/*
>> ? * Set of macros to define architecture features. ?This is built into
>> ? * a table by the linker.
>> ? */
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 8e046f1..e420565 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -439,25 +439,12 @@ void cpu_init(void)
>> ? ? ? ? ? : "r14");
>> ?}
>>
>> -static struct machine_desc * __init setup_machine(unsigned int nr)
>> +static void __init dump_machine_table(void)
>> ?{
>> - ? ? extern struct machine_desc __arch_info_begin[], __arch_info_end[];
>> ? ? ? struct machine_desc *p;
>>
>> - ? ? /*
>> - ? ? ?* locate machine in the list of supported machines.
>> - ? ? ?*/
>> - ? ? for (p = __arch_info_begin; p < __arch_info_end; p++)
>> - ? ? ? ? ? ? if (nr == p->nr) {
>> - ? ? ? ? ? ? ? ? ? ? printk("Machine: %s\n", p->name);
>> - ? ? ? ? ? ? ? ? ? ? return p;
>> - ? ? ? ? ? ? }
>> -
>> - ? ? early_print("\n"
>> - ? ? ? ? ? ? "Error: unrecognized/unsupported machine ID (r1 = 0x%08x).\n\n"
>> - ? ? ? ? ? ? "Available machine support:\n\nID (hex)\tNAME\n", nr);
>> -
>> - ? ? for (p = __arch_info_begin; p < __arch_info_end; p++)
>> + ? ? early_print("Available machine support:\n\nID (hex)\tNAME\n");
>> + ? ? for_each_machine_desc(p)
>> ? ? ? ? ? ? ? early_print("%08x\t%s\n", p->nr, p->name);
>>
>> ? ? ? early_print("\nPlease check your kernel config and/or bootloader.\n");
>> @@ -819,21 +806,29 @@ static void __init squash_mem_tags(struct tag *tag)
>> ? ? ? ? ? ? ? ? ? ? ? tag->hdr.tag = ATAG_NONE;
>> ?}
>>
>> -void __init setup_arch(char **cmdline_p)
>> +static struct machine_desc * __init setup_machine_tags(unsigned int nr)
>> ?{
>> ? ? ? struct tag *tags = (struct tag *)&init_tags;
>> - ? ? struct machine_desc *mdesc;
>> + ? ? struct machine_desc *mdesc = NULL, *p;
>> ? ? ? char *from = default_command_line;
>>
>> - ? ? unwind_init();
>> + ? ? /*
>> + ? ? ?* locate machine in the list of supported machines.
>> + ? ? ?*/
>> + ? ? for_each_machine_desc(p)
>> + ? ? ? ? ? ? if (nr == p->nr) {
>> + ? ? ? ? ? ? ? ? ? ? printk("Machine: %s\n", p->name);
>
> Print once ...
>
>> + ? ? ? ? ? ? ? ? ? ? mdesc = p;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>>
>> - ? ? setup_processor();
>> - ? ? mdesc = setup_machine(machine_arch_type);
>> - ? ? machine_desc = mdesc;
>> - ? ? machine_name = mdesc->name;
>> + ? ? if (!mdesc) {
>> + ? ? ? ? ? ? early_print("\nError: unrecognized/unsupported machine ID"
>> + ? ? ? ? ? ? ? ? ? ? " (r1 = 0x%08x).\n\n", nr);
>> + ? ? ? ? ? ? dump_machine_table(); /* does not return */
>> + ? ? }
>>
>> - ? ? if (mdesc->soft_reboot)
>> - ? ? ? ? ? ? reboot_setup("s");
>> + ? ? printk("Machine: %s\n", mdesc->name);
>>
> twice, which give something like:
>
> Uncompressing Linux... done, booting the kernel.
> [...]
> CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: Freescale MX51 Babbage Board
> Machine: Freescale MX51 Babbage Board
> Memory policy: ECC disabled, Data cache writeback

Fixed, thanks.

g.

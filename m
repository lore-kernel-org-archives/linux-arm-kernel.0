From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Nov 2014 18:29:08 -0800
Subject: [PATCH 6/8] ARM: add machine name to stack dump output
In-Reply-To: <E1XqSw6-0002EZ-Kc@rmk-PC.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
 <E1XqSw6-0002EZ-Kc@rmk-PC.arm.linux.org.uk>
Message-ID: <546C0074.4040101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2014 12:30 PM, Russell King wrote:
> The generic dump_stack() code provides the facility to include the
> machine name in the stack dump, which can be useful information.  Add
> a call to dump_stack_set_arch_desc() for the generic code to print
> this information.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index c03106378b49..8361652b6dab 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -900,6 +900,7 @@ void __init setup_arch(char **cmdline_p)
>  		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>  	machine_desc = mdesc;
>  	machine_name = mdesc->name;
> +	dump_stack_set_arch_desc("%s", mdesc->name);
>  

Would it be possible to use the DT machine name here if we're on a DT
platform? If we're using the generic DT machine descriptor this won't
show much of anything besides "Generic DT based system".

---8<----

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c03106378b49..3a49baf4f54c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -893,6 +893,7 @@ void __init hyp_mode_check(void)
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
+	const char *name;
 
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
@@ -900,6 +901,11 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	if (mdesc->nr == ~0)
+		name = of_flat_dt_get_machine_name();
+	else
+		name = mdesc->name;
+	dump_stack_set_arch_desc("%s", name);
 
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

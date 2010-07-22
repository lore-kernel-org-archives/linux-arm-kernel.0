From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Jul 2010 14:46:03 +0200
Subject: [PATCH] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <20100722134047.grwg79pz9wo84sok@v1539.ncsrv.de>
References: <AANLkTikWs2j8mSmiAdOPIY2uOfO9Q08kbuihkak7GCG8@mail.gmail.com>
	<20100722131145.q1mqlhg2888cks0w@v1539.ncsrv.de>
	<AANLkTinvLsDl3smP7C9LmHeKF9b0-dSNXhJMsy6Tp7JI@mail.gmail.com>
	<20100722134047.grwg79pz9wo84sok@v1539.ncsrv.de>
Message-ID: <AANLkTim6LLS_KhKfkr7bHK7wVc8Dlv1HJ_C4aXWKrfuX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 1:40 PM, Hendrik Sattler
<post@hendrik-sattler.de> wrote:
> Zitat von Eric Miao <eric.y.miao@gmail.com>:
>
>> On Thu, Jul 22, 2010 at 1:11 PM, Hendrik Sattler
>> <post@hendrik-sattler.de> wrote:
>>>
>>> Zitat von Eric Miao <eric.miao@canonical.com>:
>>>>
>>>> @@ -772,8 +774,13 @@ void __init setup_arch(char **cmdline_p)
>>>>
>>>> ? ? ? ?if (__atags_pointer)
>>>> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
>>>> - ? ? ? else if (mdesc->boot_params)
>>>> - ? ? ? ? ? ? ? tags = phys_to_virt(mdesc->boot_params);
>>>> + ? ? ? else {
>>>> + ? ? ? ? ? ? ? unsigned long boot_params = mdesc->boot_params ?
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mdesc->boot_params :
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(class ? class->boot_params:
>>>> 0);
>>>> + ? ? ? ? ? ? ? if (boot_params)
>>>> + ? ? ? ? ? ? ? ? ? ? ? tags = phys_to_virt(boot_params);
>>>> + ? ? ? }
>>>
>>> Isn't
>>> ? ? ? ?if (__atags_pointer)
>>> ? ? ? ? ? ? ? ?tags = phys_to_virt(__atags_pointer);
>>> ? ? ? ?else if (mdesc->boot_params)
>>> ? ? ? ? ? ? ? ?tags = phys_to_virt(mdesc->boot_params);
>>> + ? ? ? else if (class)
>>> + ? ? ? ? ? ? ? tags = phys_to_virt(class->boot_params);
>>>
>>> equivalent and much simpler?
>>>
>>
>> The idea is for mdesc->boot_params to override class->boot_params
>> if it's non-zero. Eventually this can be removed as the old way of
>> passing parameters from the bootloader at .boot_params will just
>> go away.
>
> Just expand that your snippet to:
> ?unsigned long boot_params = 0;
> ?if (mdesc->boot_params)
> ? ?boot_params = mdesc->boot_params;
> ?else {
> ? ?if (class)
> ? ? ?boot_params = class->boot_params;
> ?}
> ?if (boot_params)
> ? ?tags = phys_to_virt(boot_params);
>
> That is just more complicated than adding that simple else case but does the
> same.

Hmm... I see. What the updated patch below then:

    [ARM] Introduce 'struct machine_class' for SoC level abstraction

    'struct machine_class' groups the common elements shared by a class of
    machines. Elements in 'struct machine_desc' will override if provided.
    (Note zero is considered invalid for fields like boot_params, and if
    they are zero, the version in 'class' will be used)

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 8a0dd18..a8db47a 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -14,6 +14,21 @@ struct tag;
 struct meminfo;
 struct sys_timer;

+/*
+ * 'struct machine_class' groups the common elements shared by a class of
+ * machines. Elements in 'struct machine_desc' will override if provided.
+ * (Note zero is considered invalid for fields like boot_params, and if
+ * they are zero, the version in 'class' will be used)
+ */
+struct machine_class {
+	const char		*name;		/* machine class name	*/
+	unsigned long		boot_params;	/* tagged list		*/
+
+	void			(*map_io)(void);/* IO mapping function */
+	void			(*init_irq)(void);
+	struct sys_timer	*timer;
+};
+
 struct machine_desc {
 	/*
 	 * Note! The first four elements are used
@@ -26,6 +41,7 @@ struct machine_desc {
 						 * page tabe entry	*/

 	const char		*name;		/* architecture name	*/
+	struct machine_class	*class;		/* machine class */
 	unsigned long		boot_params;	/* tagged list		*/

 	unsigned int		video_start;	/* start of video RAM	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 776ea1a..9c8c96c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -759,12 +759,14 @@ void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
+	struct machine_class *class;
 	char *from = default_command_line;

 	unwind_init();

 	setup_processor();
 	mdesc = setup_machine(machine_arch_type);
+	class = mdesc->class;
 	machine_name = mdesc->name;

 	if (mdesc->soft_reboot)
@@ -774,6 +776,8 @@ void __init setup_arch(char **cmdline_p)
 		tags = phys_to_virt(__atags_pointer);
 	else if (mdesc->boot_params)
 		tags = phys_to_virt(mdesc->boot_params);
+	else if (class && class->boot_params)
+		tags = phys_to_virt(class->boot_params);

 	/*
 	 * If we have the old style parameters, convert them to
@@ -825,8 +829,8 @@ void __init setup_arch(char **cmdline_p)
 	 * Set up various architecture-specific pointers
 	 */
 	arch_nr_irqs = mdesc->nr_irqs;
-	init_arch_irq = mdesc->init_irq;
-	system_timer = mdesc->timer;
+	init_arch_irq = mdesc->init_irq ? : (class ? class->init_irq : NULL);
+	system_timer = mdesc->timer ? : (class ? class->timer : NULL);
 	init_machine = mdesc->init_machine;

 #ifdef CONFIG_VT
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9ee3c75..7bc25c7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -881,6 +881,7 @@ void __init arm_mm_memblock_reserve(void)
  */
 static void __init devicemaps_init(struct machine_desc *mdesc)
 {
+	struct machine_class *class = mdesc->class;
 	struct map_desc map;
 	unsigned long addr;
 	void *vectors;
@@ -945,6 +946,10 @@ static void __init devicemaps_init(struct
machine_desc *mdesc)
 	 */
 	if (mdesc->map_io)
 		mdesc->map_io();
+	else {
+		if (class && class->map_io)
+			class->map_io();
+	}

 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a

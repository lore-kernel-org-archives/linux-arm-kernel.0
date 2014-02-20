From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Thu, 20 Feb 2014 17:52:14 +0530
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <20140220114222.GG3615@mudshark.cambridge.arm.com>
References: <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
 <20140217130149.GA5856@arm.com>
 <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
 <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
 <20140219113157.GG30457@arm.com> <20140219160359.GB22252@arm.com>
 <20140219161236.GG28173@mudshark.cambridge.arm.com>
 <CALicx6t7RSS_Zo9RGr76LMnNth1gQ7pukUtAmDY4gWRN5KGVKQ@mail.gmail.com>
 <20140220114222.GG3615@mudshark.cambridge.arm.com>
Message-ID: <CALicx6sB-tucxv=-0J9LKw5E3wA1hmYyYN_z99ugnpmxvZTMng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 5:12 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Feb 20, 2014 at 06:58:25AM +0000, Vijay Kilari wrote:
>> Hi Will,
>
> Hi Vijay,
>
>> On Wed, Feb 19, 2014 at 9:42 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > The reply from Vijay suggested that everything is confined to a single CPU.
>>
>>   This issue is seen only when kgdb test is triggered on secondary cpu's.
>> when executed on cpu0 issue is not seen. Though cpu0 triggers kgdb tests
>> the do_fork test might trigger debug exception on other cpu's as well,
>> which fails.
>>
>> For the patch 1 you suggested me to call local_dbg_enable() from
>> clear_os_mask() function
>> as below
>>
>> static void clear_os_lock(void *unused)
>> {
>>         asm volatile("msr oslar_el1, %0" : : "r" (0));
>>         isb();
>>         local_dbg_enable();
>> }
>>
>> This is an SMP call. So when more than one core is enabled, this
>> local_dbg_enable() is called
>> from SMP call context, which is el1_irq context for secondary cpu's.
>> So PSTATE.D flag is unmasked
>> only in irq context but not in normal context.
>
> Aha, well spotted!
>
>> For CPU0 this clear_os_lock() is not called from smp call. it is
>> directly called in debug_monitors_init()
>> call. So PSTATE.D is unmasked for CPU0 and hence kgdb tests passed
>> when triggered only on
>> cpu0.
>>
>> static int debug_monitors_init(void)
>> {
>>         /* Clear the OS lock. */
>>         smp_call_function(clear_os_lock, NULL, 1);
>>         clear_os_lock(NULL);
>>
>>         /* Register hotplug handler. */
>>         register_cpu_notifier(&os_lock_nb);
>>         return 0;
>> }
>>
>> When I made below patch it works. I have tested with 4 cores on foundation model
>
> The main change here is that we enable debug exceptions before we unlock the
> os lock. That should be fine, since everything apart from software
> breakpoint exceptions are masked when the lock is locked.
>
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -160,6 +160,8 @@ asmlinkage void secondary_start_kernel(void)
>>         set_cpu_online(cpu, true);
>>         complete(&cpu_running);
>>
>> +       local_dbg_enable();
>>         local_irq_enable();
>>         local_async_enable();
>
> The only thing to add then moving the isb(); local_dbg_enable() out of
> clear_os_lock and into debug_monitors_init. You can probably make the
> smp_call_function an on_each_cpu too.
>
> Does that make sense?

Its ok for me.  Isn't require to have isb() after clearing os lock for
every cpu?
Just having isb on cpu0 after clearing os lock is enough?

--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -137,8 +137,6 @@ void disable_debug_monitors(enum debug_el el)
 static void clear_os_lock(void *unused)
 {
        asm volatile("msr oslar_el1, %0" : : "r" (0));
-       isb();
-       local_dbg_enable();
 }

 static int os_lock_notify(struct notifier_block *self,
@@ -157,8 +155,9 @@ static struct notifier_block os_lock_nb = {
 static int debug_monitors_init(void)
 {
        /* Clear the OS lock. */
-       smp_call_function(clear_os_lock, NULL, 1);
-       clear_os_lock(NULL);
+       on_each_cpu(clear_os_lock, NULL, 1);
+       isb();
+       local_dbg_enable();

        /* Register hotplug handler. */
        register_cpu_notifier(&os_lock_nb);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7cfb92a..5070dc3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -160,6 +160,7 @@ asmlinkage void secondary_start_kernel(void)
        set_cpu_online(cpu, true);
        complete(&cpu_running);

+       local_dbg_enable();
        local_irq_enable();
        local_async_enable();

Is this ok?

>
> Will

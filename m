From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Fri, 21 Feb 2014 10:49:25 +0530
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <20140220162710.GA7651@arm.com>
References: <CALicx6uHqyJ-n+b-zfua6P=UsJ+a2_2h-H6krx-DBJYWfF=7jg@mail.gmail.com>
 <20140218120249.GD11049@arm.com>
 <CALicx6v6=WdRPoZ-vcxf7zusooB5r1V9WnjBf3QjOiO7yik3sw@mail.gmail.com>
 <20140219113157.GG30457@arm.com> <20140219160359.GB22252@arm.com>
 <20140219161236.GG28173@mudshark.cambridge.arm.com>
 <CALicx6t7RSS_Zo9RGr76LMnNth1gQ7pukUtAmDY4gWRN5KGVKQ@mail.gmail.com>
 <20140220114222.GG3615@mudshark.cambridge.arm.com>
 <CALicx6sB-tucxv=-0J9LKw5E3wA1hmYyYN_z99ugnpmxvZTMng@mail.gmail.com>
 <20140220155600.GJ3615@mudshark.cambridge.arm.com>
 <20140220162710.GA7651@arm.com>
Message-ID: <CALicx6vTyv7=GQuEmveqNVG8TDL_eHqz+ZzknpwBTWq8m_D+=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Feb 20, 2014 at 9:57 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Feb 20, 2014 at 03:56:00PM +0000, Will Deacon wrote:
>> On Thu, Feb 20, 2014 at 12:22:14PM +0000, Vijay Kilari wrote:
>> > On Thu, Feb 20, 2014 at 5:12 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > > On Thu, Feb 20, 2014 at 06:58:25AM +0000, Vijay Kilari wrote:
>> > >> --- a/arch/arm64/kernel/smp.c
>> > >> +++ b/arch/arm64/kernel/smp.c
>> > >> @@ -160,6 +160,8 @@ asmlinkage void secondary_start_kernel(void)
>> > >>         set_cpu_online(cpu, true);
>> > >>         complete(&cpu_running);
>> > >>
>> > >> +       local_dbg_enable();
>> > >>         local_irq_enable();
>> > >>         local_async_enable();
>> > >
>> > > The only thing to add then moving the isb(); local_dbg_enable() out of
>> > > clear_os_lock and into debug_monitors_init. You can probably make the
>> > > smp_call_function an on_each_cpu too.
>> > >
>> > > Does that make sense?
>> >
>> > Its ok for me.  Isn't require to have isb() after clearing os lock for
>> > every cpu?
>> > Just having isb on cpu0 after clearing os lock is enough?
>>
>> They'll synchronise on return from the IPI.
>>
>> > --- a/arch/arm64/kernel/debug-monitors.c
>> > +++ b/arch/arm64/kernel/debug-monitors.c
>> > @@ -137,8 +137,6 @@ void disable_debug_monitors(enum debug_el el)
>> >  static void clear_os_lock(void *unused)
>> >  {
>> >         asm volatile("msr oslar_el1, %0" : : "r" (0));
>> > -       isb();
>> > -       local_dbg_enable();
>> >  }
>> >
>> >  static int os_lock_notify(struct notifier_block *self,
>> > @@ -157,8 +155,9 @@ static struct notifier_block os_lock_nb = {
>> >  static int debug_monitors_init(void)
>> >  {
>> >         /* Clear the OS lock. */
>> > -       smp_call_function(clear_os_lock, NULL, 1);
>> > -       clear_os_lock(NULL);
>> > +       on_each_cpu(clear_os_lock, NULL, 1);
>> > +       isb();
>> > +       local_dbg_enable();
>> >
>> >         /* Register hotplug handler. */
>> >         register_cpu_notifier(&os_lock_nb);
>> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> > index 7cfb92a..5070dc3 100644
>> > --- a/arch/arm64/kernel/smp.c
>> > +++ b/arch/arm64/kernel/smp.c
>> > @@ -160,6 +160,7 @@ asmlinkage void secondary_start_kernel(void)
>> >         set_cpu_online(cpu, true);
>> >         complete(&cpu_running);
>> >
>> > +       local_dbg_enable();
>> >         local_irq_enable();
>> >         local_async_enable();
>> >
>> > Is this ok?
>>
>> Looks good to me:
>>
>>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> Vijay, could you please post a commit log together with the above patch
> (and Will's ack) so that I can merge it on top of your other patches?
>

  I have sent a patch for this fix named, " [PATCH 1/1] arm64: enable processor
debug state for secondary cpus".
Please apply this on top of other patches.

Thanks
- Vijay
> Thanks.
>
> --
> Catalin

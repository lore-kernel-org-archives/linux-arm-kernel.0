From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue, 12 Jul 2011 08:31:28 +0800
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <201107112352.40424.arnd@arndb.de>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAK5ve-+Pr8EDa8mfhZVbf8ADc2YDU0EyTPL3Fwwipj237tgKQg@mail.gmail.com>
	<20110711210950.GE8486@n2100.arm.linux.org.uk>
	<201107112352.40424.arnd@arndb.de>
Message-ID: <CAK5ve-LNDCN0P6L_5-L4PT11n1Tiv0qz=8=rgmv-v7WsEDotBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 5:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 11 July 2011, Russell King - ARM Linux wrote:
>> On Mon, Jul 11, 2011 at 10:36:49PM +0800, Bryan Wu wrote:
>> > Right, I got it. So if we are going to run a single binary for all the
>> > sa1100 machines, how about we check the machine in each fs_initcall
>> >
>> > static int __init assabet_leds_init(void)
>> > {
>> > ? ? ?int i;
>> >
>> > ? ? ?if (!machine_is_assabet())
>> > ? ? ? ? ? return -ENODEV,
>> >
>> > ? ? ?for (i = 0; i < ARRAY_SIZE(assabet_leds); i++) {
>> > ? ? ? ? ? ? ?struct assabet_led *led;
>>
>> Yes, that'll do, thanks.
>>
>
> Do you think it's worth copying the logic from powerpc for this?
>
>
> arch/powerpc/include/asm/machdep.h:
> #define __define_machine_initcall(mach,level,fn,id) \
> ? ? ? ?static int __init __machine_initcall_##mach##_##fn(void) { \
> ? ? ? ? ? ? ? ?if (machine_is(mach)) return fn(); \
> ? ? ? ? ? ? ? ?return 0; \
> ? ? ? ?} \
> ? ? ? ?__define_initcall(level,__machine_initcall_##mach##_##fn,id);
> #define machine_core_initcall(mach,fn) ? ? ? ? ?__define_machine_initcall(mach,"1",fn,1)
> #define machine_core_initcall_sync(mach,fn) ? ? __define_machine_initcall(mach,"1s",fn,1s)
> #define machine_postcore_initcall(mach,fn) ? ? ?__define_machine_initcall(mach,"2",fn,2)
> #define machine_postcore_initcall_sync(mach,fn) __define_machine_initcall(mach,"2s",fn,2s)
> #define machine_arch_initcall(mach,fn) ? ? ? ? ?__define_machine_initcall(mach,"3",fn,3)
> #define machine_arch_initcall_sync(mach,fn) ? ? __define_machine_initcall(mach,"3s",fn,3s)
> #define machine_subsys_initcall(mach,fn) ? ? ? ?__define_machine_initcall(mach,"4",fn,4)
> #define machine_subsys_initcall_sync(mach,fn) ? __define_machine_initcall(mach,"4s",fn,4s)
> #define machine_fs_initcall(mach,fn) ? ? ? ? ? ?__define_machine_initcall(mach,"5",fn,5)
> #define machine_fs_initcall_sync(mach,fn) ? ? ? __define_machine_initcall(mach,"5s",fn,5s)
> #define machine_rootfs_initcall(mach,fn) ? ? ? ?__define_machine_initcall(mach,"rootfs",fn,rootfs)
> #define machine_device_initcall(mach,fn) ? ? ? ?__define_machine_initcall(mach,"6",fn,6)
> #define machine_device_initcall_sync(mach,fn) ? __define_machine_initcall(mach,"6s",fn,6s)
> #define machine_late_initcall(mach,fn) ? ? ? ? ?__define_machine_initcall(mach,"7",fn,7)
> #define machine_late_initcall_sync(mach,fn) ? ? __define_machine_initcall(mach,"7s",fn,7s)
>
> I don't really like the magic macros, but my feeling is that it's easier
> to do the conversion without introducing subtle bugs this way.
>

I think this is a great idea. what about moving it to include/asm-generic/

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com

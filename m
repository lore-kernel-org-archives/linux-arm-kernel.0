From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 18 Nov 2015 11:07:26 +0100
Subject: [PATCH v6 15/19] arm64: ilp32: force IPC_64 in msgctl, shmctl,
 semctl
In-Reply-To: <32420376.JEdtXfitGi@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <26387039.NNJ6EnRrv8@wuerfel> <mvmoaersohn.fsf@hawking.suse.de>
 <32420376.JEdtXfitGi@wuerfel>
Message-ID: <CAMuHMdVBCq4ZuDPoQ2TLpSH28jWHkNftqf4tNN=Rbo8a0y+_yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 10:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 November 2015 09:25:40 Andreas Schwab wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> > On Wednesday 18 November 2015 00:16:55 Yury Norov wrote:
>> >>
>> >> +/* IPC_64 */
>> >> +asmlinkage long ilp32_sys_msgctl(int first, int second, void __user *uptr)
>> >> +{
>> >> +       return compat_sys_msgctl(first, second | IPC_64, uptr);
>> >> +}
>> >> +#define compat_sys_msgctl              ilp32_sys_msgctl
>> >> +
>> >> +asmlinkage long ilp32_sys_shmctl(int first, int second, void __user *uptr)
>> >> +{
>> >> +       return compat_sys_shmctl(first, second | IPC_64, uptr);
>> >> +}
>> >> +#define compat_sys_shmctl              ilp32_sys_shmctl
>> >> +
>> >> +asmlinkage long ilp32_sys_semctl(int first, int second, int third, int arg)
>> >> +{
>> >> +       return compat_sys_semctl(first, second, third | IPC_64, arg);
>> >> +}
>> >> +#define compat_sys_semctl      ilp32_sys_semctl
>> >>
>> >
>> > I wonder if this would be any simpler by changing compat_ipc_parse_version()
>>
>> This cries for a generic solution.  Other archs migrating to separate
>> ipc syscalls will want to avoid the whole IPC_64 business for them, even
>> if they need to retain [compat_]ipc_parse_version for sys_ipc
>> compatibility.
>
> Agreed. I think all architectures are moving that way now, so we should
> really try to get all cases right now.
>
> I've done a complete list of what the architectures (see
> https://docs.google.com/spreadsheets/d/18GxXEHE2ywnSr-SPoGFd1ABz6wEM1ex-JMu5lEraaH8/ )
>
> We have these categories:
>
> 1. uses IPC_PARSE_VERSION with sys_ipc, and has just introduced
>    separate syscalls:
>
>     arm, avr32, powerpc, x86-32

x86-32, where?

> 2. uses IPC_PARSE_VERSION with sys_ipc, and has not yet introduced
>    separate syscalls (currently producing a compile warning):
>
>    cris, frv, m32r, m68k, mips (o32), mn10300, s390, sh32, sparc
>
> 3. uses IPC_PARSE_VERSION with separate syscalls:
>
>    alpha, blackfin, microblaze, mips (n32/64), xtensa
>
> 4a. only new-style IPC with separate syscalls:
>
>     ia64, parisc, sh64

and x86-64?

> 4b. only new-style IPC with separate syscalls, using generic syscall
>     table:
>
>     arc, arm64, c6x, h8300, hexagon, metag, nios2, openrisc, score,
>     tile, unicore32
>
> So we should probably fix 1. and 2. before it's too late, but make
> sure we don't break 3. in the process.

(Fortunately?) x86-32 doesn't seem to be converted in next yet?

I was hoping for them to do the heavy lifting for the generic solution ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

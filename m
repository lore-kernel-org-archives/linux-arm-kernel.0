From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 20 Apr 2015 12:46:51 +0200
Subject: qemu:arm test failure due to commit 8053871d0f7f (smp: Fix
 smp_call_function_single_async() locking)
In-Reply-To: <5533B6D7.9050101@roeck-us.net>
References: <20150418232325.GA22411@roeck-us.net>
 <20150418234050.GA5987@roeck-us.net>
 <CA+55aFz1934X3wu7FdGerwYMJ_BAkrFsajOQFtU3_ogsUX3_eQ@mail.gmail.com>
 <55330B32.4010907@roeck-us.net> <20150419033940.GA25145@debian>
 <CA+55aFw4FSja+VBuCYJ7wLXKVRQZ7w6vOUaUJ4B=FXyBmNkrUg@mail.gmail.com>
 <CA+55aFwTMJ7CAtBaL-uGsgVf9-oyGwqLZwz_pwjX=umbS-2CNQ@mail.gmail.com>
 <20150419093112.GA6139@gmail.com> <5533B6D7.9050101@roeck-us.net>
Message-ID: <CAMuHMdWn-XsRX8O+LOSTFv3vZ6VjXZFU2WEkZsgz-NgsHRpmVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 19, 2015 at 4:08 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/19/2015 02:31 AM, Ingo Molnar wrote:
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>> On Sun, Apr 19, 2015 at 4:48 AM, Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>>
>>>> Does that smaller patch work equally well?
>>>
>>>
>>> .. and here's a properly formatted email and patch.
>>>
>>>             Linus
>>
>>
>>>   kernel/smp.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/smp.c b/kernel/smp.c
>>> index 2aaac2c47683..07854477c164 100644
>>> --- a/kernel/smp.c
>>> +++ b/kernel/smp.c
>>> @@ -159,8 +159,10 @@ static int generic_exec_single(int cpu, struct
>>> call_single_data *csd,
>>>         }
>>>
>>>
>>> -       if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu))
>>> +       if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {
>>> +               csd_unlock(csd);
>>>                 return -ENXIO;
>>> +       }
>>
>>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

I've bisected a boot regression on a real system to the same commit
8053871d0f7f ("smp: Fix smp_call_function_single_async() locking").

Linus' patch fixes it, so

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> Btw., in this case we should probably also generate a WARN_ONCE()
>> warning?
>>
>> I _think_ most such callers calling an SMP function call for offline
>> or out of range CPUs are at minimum racy.
>>
> Not really; at least the online cpu part is an absolutely normal use
> case for qemu-arm.
>
> Sure, you can argue that "this isn't the real system", and that
> qemu-arm should be "fixed", but there are reasons - the emulation
> is (much) slower if the number of CPUs is set to 4, and not everyone
> who wants to use qemu has a system with as many CPUs as the emulated
> system would normally have.

In my case boot failed on r8a73a4/ape6evm, where I had added nodes for all
CPU cores to the .dtsi, while the SoC code doesn't have SMP bringup code yet.
This worked fine before.

With CONFIG_DEBUG_LL=y, the boot hung after:

    Calibrating delay loop (skipped), value calculated using timer
frequency.. 26.00 BogoMIPS (lpj=130000)
    pid_max: default: 32768 minimum: 301
    Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
    Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
    CPU: Testing write buffer coherency: ok
    CPU0: update cpu_capacity 1516
    CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
    Setting up static identity map for 0x40009000 - 0x40009058

With the fix, it continues as expected with:

    Brought up 1 CPUs
    SMP: Total of 1 processors activated (26.00 BogoMIPS).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

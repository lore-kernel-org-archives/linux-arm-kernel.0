From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 12 Dec 2017 17:00:33 +0100
Subject: arm64: unhandled level 0 translation fault
In-Reply-To: <CAMuHMdVoqyWU3SRJ3zSdNNf_pJz9t_9fNYZ2EQr4JECTHRREJQ@mail.gmail.com>
References: <CAMuHMdXh_6FaV-SFGWxcBb1-NNGYngDrYnnWA=9Y6xmRAkcxqg@mail.gmail.com>
 <20171212103635.GD28301@arm.com>
 <CAMuHMdVoqyWU3SRJ3zSdNNf_pJz9t_9fNYZ2EQr4JECTHRREJQ@mail.gmail.com>
Message-ID: <CAMuHMdVnFyFv0Q6PaBEb6RpfJYkSzpvNUy8XtEWczES+uEO=6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Dec 12, 2017 at 4:11 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Dec 12, 2017 at 11:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Dec 12, 2017 at 11:20:09AM +0100, Geert Uytterhoeven wrote:
>>> During userspace (Debian jessie NFS root) boot on arm64:
>>>
>>> rpcbind[1083]: unhandled level 0 translation fault (11) at 0x00000008,
>>> esr 0x92000004, in dash[aaaaadf77000+1a000]
>>> CPU: 0 PID: 1083 Comm: rpcbind Not tainted
>>> 4.15.0-rc3-arm64-renesas-02176-g14f9a1826e48e355 #51
>>> Hardware name: Renesas Salvator-X 2nd version board based on r8a7795 ES2.0+ (DT)
>>> pstate: 80000000 (Nzcv daif -PAN -UAO)
>>> pc : 0xaaaaadf8a51c
>>> lr : 0xaaaaadf8ac08
>>> sp : 0000ffffcffeac00
>>> x29: 0000ffffcffeac00 x28: 0000aaaaadfa1000
>>> x27: 0000ffffcffebf7c x26: 0000ffffcffead20
>>> x25: 0000aaaacea1c5f0 x24: 0000000000000000
>>> x23: 0000aaaaadfa1000 x22: 0000aaaaadfa1000
>>> x21: 0000000000000000 x20: 0000000000000008
>>> x19: 0000000000000000 x18: 0000ffffcffeb500
>>> x17: 0000ffffa22babfc x16: 0000aaaaadfa1ae8
>>> x15: 0000ffffa2363588 x14: ffffffffffffffff
>>> x13: 0000000000000020 x12: 0000000000000010
>>> x11: 0101010101010101 x10: 0000aaaaadfa1000
>>> x9 : 00000000ffffff81 x8 : 0000aaaaadfa2000
>>> x7 : 0000000000000000 x6 : 0000000000000000
>>> x5 : 0000aaaaadfa2338 x4 : 0000aaaaadfa2000
>>> x3 : 0000aaaaadfa2338 x2 : 0000000000000000
>>> x1 : 0000aaaaadfa28b0 x0 : 0000aaaaadfa4c30
>>>
>>> Sometimes it happens with other processes, but the main address, esr, and
>>> pstate values are always the same.
>>>
>>> I regularly run arm64/for-next/core (through bi-weekly renesas-drivers
>>> releases, so the last time was two weeks ago), but never saw the issue
>>> before until today, so probably v4.15-rc1 is OK.
>>> Unfortunately it doesn't happen during every boot, which makes it
>>> cumbersome to bisect.
>>>
>>> My first guess was UNMAP_KERNEL_AT_EL0, but even after disabling that,
>>> and even without today's arm64/for-next/core merged in, I still managed to
>>> reproduce the issue, so I believe it was introduced in v4.15-rc2 or
>>> v4.15-rc3.
>>
>> Urgh, this looks nasty. Thanks for the report! A few questions:
>>
>>  - Can you share your .config somewhere please?
>
> I managed to reproduce it on plain v4.15-rc3 using both arm64_defconfig, and
> renesas_defconfig (from Simon's repo).

v4.15-rc2 is affected, too.

>>  - What was your last known-good kernel?
>
> v4.15-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

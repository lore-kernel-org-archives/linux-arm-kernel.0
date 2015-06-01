From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Jun 2015 12:41:01 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
Message-ID: <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 9:36 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, May 19, 2015 at 6:12 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
>> All ARMv5 and older CPUs invalidate their caches in the early assembly
>> setup function, prior to enabling the MMU.  This is because the L1
>> cache should not contain any data relevant to the execution of the
>> kernel at this point; all data should have been flushed out to memory.
>>
>> This requirement should also be true for ARMv6 and ARMv7 CPUs - indeed,
>> these typically do not search their caches when caching is disabled (as
>> it needs to be when the MMU is disabled) so this change should be safe.
>>
>> ARMv7 allows there to be CPUs which search their caches while caching is
>> disabled, and it's permitted that the cache is uninitialised at boot;
>> for these, the architecture reference manual requires that an
>> implementation specific code sequence is used immediately after reset
>> to ensure that the cache is placed into a sane state.  Such
>> functionality is definitely outside the remit of the Linux kernel, and
>> must be done by the SoC's firmware before _any_ CPU gets to the Linux
>> kernel.
>>
>> Changing the data cache clean+invalidate to a mere invalidate allows us
>> to get rid of a lot of platform specific hacks around this issue for
>> their secondary CPU bringup paths - some of which were buggy.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> For various shmobile:
>   - sh73a0/kzm9g
>   - r8a7740/armadillo
>   - r8a73a4/ape6evm
>   - r8a7791/koelsch
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

FWIW, I have the feeling this has a slight influence on boot reliability on
two of my boards:
  - r8a7740/armadillo, which is known to suffer from a cache-related bug in
    its bootloader, seems to have a higher change of booting successfully on
    cold boot,
  - sh73a0/kzm9g, which has known cache-issues with secondary CPU boot up,
    seems to have a lower chance of booting successfully.

No time to spend all week turning this into a statistical significant test
project... The reset button is my friend...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

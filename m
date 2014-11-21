From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Nov 2014 09:06:09 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <7hppchpcfm.fsf@deeprootsystems.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
 <2900095.WIocOu7ue2@wuerfel>
 <CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
 <546DD87B.3080806@ti.com>
 <CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
 <CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
 <546E0970.5090301@ti.com> <7hh9xtr5ac.fsf@deeprootsystems.com>
 <CAMuHMdV7zASj8_NtLRir1VubXEKTkq0vBGMXeYXDACu8UC2tZA@mail.gmail.com>
 <7hbno1r1af.fsf@deeprootsystems.com>
 <CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
 <7hppchpcfm.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdU6G35SP-P7bt6RJQk59CrGcKE2XM4N3o8Dv3qxZU7gxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, Nov 21, 2014 at 2:30 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> On Thu, Nov 20, 2014 at 10:48 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>>> So what exactly are we talking about with "PM" clocks, and why are they
>>>>> "special" when it comes to PM domains?  IOW, why are the clocks to be
>>>>> managed during PM domain transitions for a given device any different
>>>>> than the clocks that need to be managed for a runtime suspend/resume (or
>>>>> system suspend/resume) sequence for the same device?
>>>>
>>>> (Speaking for my case, shmobile)
>>>>
>>>> They're not. The clocks to be managed during PM domain transitions are the
>>>> same as the clocks that need to be managed for a runtime suspend/resume
>>>> (or system suspend/resume) sequence.
>>>>
>>>> The special thing is that this is more a platform than a driver thing: the same
>>>> module may have a "PM/functional" clock (that is documented to enable/disable
>>>> the module) on one Soc, but noet on another.
>>>
>>> So why isn't the presence or absence of the clock described in the .dtsi
>>> for the SoC instead of being handled by special PM domain logic?
>>
>> It is. Cfr. the presence/absence of clocks for renesas,rcar-gpio nodes.
>
> Hmm, OK, Good.
>
> So now I'm confused about why the PM domain has to do anything special
> if the presence/absence of the clocks is already handled by the DT.

Just adding a clock property to a device node in DT doesn't enable the clock
automatically, nor make it runtime-managed automatically.
Compare this to e.g. pinctrl, where adding pinctrl properties to DT does enable
them automatically, without the driver for the device having to care about it.

Drivers interfacing external hardware typically do care about clocks, as they
have to program clock generators for the external hardware interface (e.g.
driving spi or i2c buses at specific frequencies).

Other random drivers don't care about clocks, so they don't handle them.
But as long as they make basic pm_runtime_{enable,get_sync,put}() calls,
the (optional) clocks (and hardware PM domains) will "work" fine, if handled
by the PM (clock) domain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

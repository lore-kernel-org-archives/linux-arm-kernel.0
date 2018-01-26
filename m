From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 26 Jan 2018 13:44:05 +0000
Subject: [RFC 01/37] ARM: shmobile: Add watchdog support
In-Reply-To: <CAMuHMdUOoMHqu3WD8GUbGFTfeAsw9d5vKtkzdMQjMfTEknos-A@mail.gmail.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWVvMJR5NHMFn6zx39jw2XdP5nteU3actUcen0dmoT-LQ@mail.gmail.com>
 <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdUOoMHqu3WD8GUbGFTfeAsw9d5vKtkzdMQjMfTEknos-A@mail.gmail.com>
Message-ID: <TY1PR06MB08958F9DA01F254443024333C0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

> Subject: Re: [RFC 01/37] ARM: shmobile: Add watchdog support
>
> Hi Fabrizio,
>
> On Fri, Jan 26, 2018 at 12:52 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> >> Subject: Re: [RFC 01/37] ARM: shmobile: Add watchdog support
> >> On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
> >> <fabrizio.castro@bp.renesas.com> wrote:
> >> > On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
> >> > boot CPUs run a routine designed to bring up SMP and deal with hot plug.
> >> > The value contained in the SBAR registers is not initialized by a WDT
> >> > triggered reset, which means that after a WDT triggered reset we jump
> >> > to the SMP bring up routine, preventing the system from executing the
> >> > bootrom code.
> >>
> >> Thanks for your patch!
> >
> > Thank you for looking into this!
> >
> > I am not going to reply to your comments on the other patches for now, as we need to find a solution for this particular patch we are
> all happy with first.
> > A change to this patch may impact the other patches as well.
> >
> >> > The purpose of this patch is to jump to the bootrom code in case of a
> >> > WDT triggered reset, and keep the SMP functionality untouched.
> >> > In order to tell if the code had been called due to the WDT overflowing
> >> > we need to inspect flag WOVF from register RWTCSRA, however for this
> >> > to work smoothly we need to make sure that RWDT clock is ON.
> >> > Since it's not wise to interfere with the clock configuration from
> >> > within this routine, a flag has been put in place
> >> > (shmobile_wdt_clock_status) so that the watchdog driver can tell
> >> > shmobile_boot_vector when the clock is ON, and therefore there is no
> >> > need for shmobile_boot_vector to mess up with the clock registers.
> >> >
> >> > Bit WOVF survives a watchdog triggered reset, and it is usually cleared
> >> > by the bootloader. Checking the MMU enable bit from register SCTLR
> >> > allows us to make the code a little bit more robust (just in case the
> >> > bit wasn't cleared up), as right after a reset the MMU is disabled,
> >> > and when Linux is running the MMU is enabled. Also, accessing RWTCSRA
> >> > physical address is safe when the MMU is down.
> >>
> >> Checking a hardware register is indeed a better solution than my original
> >> idea to let SMP bringup set a flag in RAM, as the former is less racy.
> >
> > Also, such a flag would not be accessible after the reset gets triggered.
>
> It would, if it's stored in e.g. ICRAM.

Yes, of course. It reminds me of shmobile_wdt_clock_status...     :-D

>
> >> However, as you can probably imagine, I don't like the
> >> shmobile_wdt_clock_status part ;-)
> >
> > Neither do I!      :-D
>
> Good ;-)
>
> >> Isn't is sufficient to check the MMU enable bit?
> >
> > I am afraid it isn't, when bringing up SMP the cores will read the MMU flag as disabled, to make things worse at that precise point in
> time the rwdt clock is disabled.
> > If the system just restarted due to the watchdog, then when you read WOVF chances are you are going to read '1', hence the
> system will fail to bring up SMP.
>
> OK, so I was mislead by the MMU check.
>
> >> However, that would precludes uClinux (do we care?).
> >
> > The MMU will be constantly disabled in this case, wouldn't it? Therefore the reset vector will always proceed with the testing of
> variable "shmobile_wdt_clock_status", and it'll finally test WOVF only when it's safe to do so. If WOVF is set, then we still jump to the
> bootrom code. if WOVF is not set, then we jump to shmobile_boot_fn. Could you please elaborate your thoughts a little bit more?
> >
> >> Is there any other register/bit that's reset when the watchdog is
> >> triggered, and always set by Linux?
> >
> > Not that I know of, but you may know better ;-P
> > Any suggestion?
>
> Any chance WDTRSTCR.RWDT_RSTMSK is reinitialized to 1 on watchdog reset?
> Probably not, as the Hardware User's Manual says the register is
> initialized on power on reset caused by PRESET#.

I think its value is retained, as you pointed out.

So basically, I still think testing WOVF is the best way to tell if we jumped into the reset vector because of a watchdog triggered reset, or because of SMP.
We "just" need to guarantee we read from RWTCSRA when it's safe to do so. Can you think of any other alternative to the flag in ICRAM1 to achieve this safely?

Thanks,
Fab

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

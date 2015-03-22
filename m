From: dianders@chromium.org (Doug Anderson)
Date: Sun, 22 Mar 2015 14:59:27 -0700
Subject: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
In-Reply-To: <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
References: <1426874420-25103-1-git-send-email-dianders@chromium.org>
 <CAGOxZ52OWucMh_HjWnZnhN=c7C3TXeQ4aV-GAe5XXtRbu0r2Kg@mail.gmail.com>
Message-ID: <CAD=FV=VUG54vk9xD9zEnaP_rQcL4cWLOHuy76aMRta0OOsLn1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alim,

On Sun, Mar 22, 2015 at 5:16 AM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>         case MMC_POWER_OFF:
>> -               /* Turn clock off before power goes down */
>> -               dw_mci_setup_bus(slot, false);
>> +               /* Turn clock off before power goes down; only if powered */
>> +               if (slot->host->vqmmc_enabled)
>> +                       dw_mci_setup_bus(slot, false);
>>
> vqmmc_enabled is always _true_ when entering MMC_POWER_OFF case..right?
> Is this done for extra protection? Or do you have a case where vqmmc
> is OFF and driver still calls dw_mci_setup_bus from here?

Hmm.  I know I got it into the debugger in at least one reboot case
where it was failing to turn the clock off.  I thought I confirmed it
was the core trying to call MMC_POWER_OFF when the power was already
off, but now I'm less certain.  I looked back at my debug session and
I don't see where I got that evidence.  :-/  Certainly if I put a
printout here right now I can't see my code making a difference.

Unfortunately the crash was a very rare one, so I may have to go back
to the drawing board here...

-Doug

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Aug 2014 10:38:00 +0200
Subject: [PATCH] pwm: Fix period and polarity in pwm_get() for non-perfect
 matches
In-Reply-To: <20140818082039.GA31171@ulmo>
References: <1407943133-18170-1-git-send-email-geert+renesas@glider.be>
 <20140818082039.GA31171@ulmo>
Message-ID: <CAMuHMdVLA4xRGKrsyGTokZvRWkNAFyNv+_JycavfpibO8GXkkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Mon, Aug 18, 2014 at 10:20 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Could we achieve the same by storing a pointer to the best match and
> then use that instead of p? Perhaps something like this:
>
>         struct pwm_lookup *entry;
>
>         ...
>
>                 if (match > best) {
>                         chip = pwmchip_find_by_name(p->provider);
>                         entry = p;
>
>                         if (match != 3)
>                                 best = match;
>                         else
>                                 break;
>                 }
>
>         ...
>
>         if (chip)
>                 pwm = pwm_request_from_chip(chip, entry->index,
>                                             con_id ?: dev_id);
>         if (IS_ERR(pwm))
>                 return pwm;
>
>         pwm_set_period(pwm, entry->period);
>         pwm_set_polarity(pwm, entry->polarity);
>
> ?

That's possible. But that will add complexity, as you have to move the
"mutex_unlock(&pwm_lookup_lock);" after the last user of "entry" again,
and add a goto for the IS_ERR(pwm) case.
So I'm not sure it's worth the effort.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

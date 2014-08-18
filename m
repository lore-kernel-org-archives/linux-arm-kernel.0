From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Aug 2014 10:57:24 +0200
Subject: [PATCH] pwm: Fix period and polarity in pwm_get() for
 non-perfect matches
In-Reply-To: <CAMuHMdVLA4xRGKrsyGTokZvRWkNAFyNv+_JycavfpibO8GXkkQ@mail.gmail.com>
References: <1407943133-18170-1-git-send-email-geert+renesas@glider.be>
 <20140818082039.GA31171@ulmo>
 <CAMuHMdVLA4xRGKrsyGTokZvRWkNAFyNv+_JycavfpibO8GXkkQ@mail.gmail.com>
Message-ID: <20140818085722.GE31171@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:38:00AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
> 
> On Mon, Aug 18, 2014 at 10:20 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > Could we achieve the same by storing a pointer to the best match and
> > then use that instead of p? Perhaps something like this:
> >
> >         struct pwm_lookup *entry;
> >
> >         ...
> >
> >                 if (match > best) {
> >                         chip = pwmchip_find_by_name(p->provider);
> >                         entry = p;
> >
> >                         if (match != 3)
> >                                 best = match;
> >                         else
> >                                 break;
> >                 }
> >
> >         ...
> >
> >         if (chip)
> >                 pwm = pwm_request_from_chip(chip, entry->index,
> >                                             con_id ?: dev_id);
> >         if (IS_ERR(pwm))
> >                 return pwm;
> >
> >         pwm_set_period(pwm, entry->period);
> >         pwm_set_polarity(pwm, entry->polarity);
> >
> > ?
> 
> That's possible. But that will add complexity, as you have to move the
> "mutex_unlock(&pwm_lookup_lock);" after the last user of "entry" again,
> and add a goto for the IS_ERR(pwm) case.
> So I'm not sure it's worth the effort.

Oh, right. It would've been nice to avoid all the temporary variables,
but we can always refactor if that turns out to become too messy. I'll
apply this one for now.

I'll shorten the SHA-1 in the Fixes: line to 12 characters if you don't
mind to match the guidelines in Documentation/SubmittingPatches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/9c917173/attachment-0001.sig>

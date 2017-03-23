From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Mar 2017 13:03:56 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
References: <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
Message-ID: <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Mar 23, 2017 at 12:11 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>> Make sure to enable all drivers and subsystems you need when building
>> your kernel. That's always true. And may indeed be hard to debug (e.g. what
>> kernel options do I need to make systemd work?).
>
> It's worse here. If you forget to enable a driver the device isn't bound
> and that's obvious to diagnose. When ignoring an optional GPIO there
> might be a device that claims to work but fails to do so. (e.g. you
> write to memory, write() returns 0, but the data never landed there.)
>
>> > write(2) and close(2) succeed most of the time, too. Still it's not a
>> > good idea to not check the return value. Or let the kernel return
>> > success unconditionally.
>>
>> Writing all bytes passed in the buffer is "optional" in another sense than
>> an "optional" GPIO: you must retry the write, while you can continue if
>> an optional GPIO is not present.
>
> And that is the point. You can continue *iff* the optional GPIO is not
> present. The patch in question removes the ability to determine if that
> GPIO is present and claims it is not present.

If you forget to enable a driver/subsystem, you sometimes cannot determine
if the device is present or not neither.

Hence it boils down to "knowing" if there is a GPIO or not.
So, when can there be a GPIO?
  1. The GPIO is described in DT.
     => Not an issue, as DT GPIO implies GPIOLIB,
  2. The GPIO is described in legacy platform data.
     => The platform code should make sure GPIOLIB is selected when needed.

Issue solved?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

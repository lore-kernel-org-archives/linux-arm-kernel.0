From: aisheng.dong@nxp.com (A.S. Dong)
Date: Fri, 9 Jun 2017 14:20:41 +0000
Subject: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
In-Reply-To: <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
 <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com>
Message-ID: <AM3PR04MB30678CBD87777C6816DEFA580CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> Sent: Friday, June 09, 2017 5:26 PM
> To: A.S. Dong
> Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm
> Mailing List; Greg Kroah-Hartman; Jiri Slaby; Andy Duan; Stefan Agner;
> Mingkai Hu; Y.B. Lu; Dong Aisheng
> Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud
> rate calculation method
> 
> On Fri, Jun 9, 2017 at 11:01 AM, A.S. Dong <aisheng.dong@nxp.com> wrote:
> 
> >> >> > +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
> >> >> > +       u32 clk = sport->port.uartclk;
> >> >> > +
> >> >> > +       /*
> >> >> > +        * The idea is to use the best OSR (over-sampling rate)
> >> possible.
> >> >> > +        * Note, OSR is typically hard-set to 16 in other LPUART
> >> >> instantiations.
> >> >> > +        * Loop to find the best OSR value possible, one that
> >> >> > + generates
> >> >> minimum
> >> >> > +        * baud_diff iterate through the rest of the supported
> >> >> > + values of
> >> >> OSR.
> >> >> > +        *
> >> >> > +        * Calculation Formula:
> >> >> > +        *  Baud Rate = baud clock / ((OSR+1) ? SBR)
> >> >> > +        */
> >> >> > +       baud_diff = baudrate;
> >> >> > +       osr = 0;
> >> >> > +       sbr = 0;
> >> >> > +
> >> >>
> >> >> > +       for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {
> >>
> >> I missed one thing, what happened by default to OSR? What is the
> >> value in use?
> >>
> >
> > No valid default value. (osc/sbr are 0 by default) If no proper osc
> > and sbr calculated, a WARNING will show.
> 
> Okay, so, it means the maximum supported speed is UART clock / 4. Correct?
> 

Yes.

> >> So, the algo is the following:
> >>
> >> Assume the ranges like this:
> >> OSR = [4 ... 32]
> >> SBR = [2 ... 8192]
> >>
> >
> > Baud Rate = baud clock / ((OSR+1) ? SBR)
> >
> > In HW:
> > OSR range : 3 ? 31
> > SBR range: 1 ? 8191
> 
> I've read that, but think outside the box.
> 
> >> Then:
> >>
> >> 1. Get ratio factor as
> >>       ratio = CLK / desired baud rate 2. If ratio < 8192 * 9 / 2,
> >> just use (ratio / 4, 4) as (OSR, SBR) setting.
> >> (Needs clarification on OSR < 4)
> >
> > Sorry that I'm a bit mess here.
> > What is 8192 * 9 /2 meaning?
> 
> I forgot the details...
> 
> > And for (ratio / 4, 4) as (OSR,SBR), take 115200 as an example:
> > Assuming baud clock 24Mhz.
> >
> > Ratio = 24000000 / 115200 = 208
> > OSR = Ratio / 4 = 52
> > Then OSR is out of range which seems wrong.
> 
> ...yes...
> 
> >> 3. if ratio >= 8192 * 31, just use those two numbers (8192, 31). You
> >> can't do anything better there.
> >
> > This actually may not happen.
> > Even take a 9600 as example, the clk becomes:
> > 8191 * 31 * 9600 = 2.4GHz
> > Which is theoretically not exist.
> >
> >> 4. Otherwise, get a minimum required factor of OSR
> >>       osr_min = ratio / 8192
> >> 5. Start your loop from osr_min + 1 to 31.
> >>
> >> 6 (optional). Of course you may not consider baud_diff > osr_min,
> >> it's I suppose obvious
> >>
> >> P.S. Note, all divisions by 2^n are just simple right shifts. Diffs
> >> are calculated as multiplication of OSR and SBR in comparison to
> >> ratio. One division so far.
> 
> > I'm not quite understand the approach.
> 
> ...lemme prepare a python script demonstrating it.
> 

Great, thanks

> > How about you send a separate baud algorithm improvement patch later?
> 
> Why not to do it right a way?
> 

Because I thought that could be a separate patch which is doing algorithm
improvement, then we can have the full history and a clear comparison.

And also we are still not sure whether it works, we don't want to block on it
too long.

But if you're pretty sure about it, I would wait for some more time.

However, personally I would still rather keep them in two separate Patches
for clearer history and comparison.

> Just describe it in a comment if you afraid of reader can't understand
> from the code.
> 

That is good.

Regards
Dong Aisheng

> --
> With Best Regards,
> Andy Shevchenko

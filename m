From: aisheng.dong@nxp.com (A.S. Dong)
Date: Fri, 9 Jun 2017 08:01:40 +0000
Subject: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
In-Reply-To: <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
Message-ID: <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> Sent: Saturday, June 03, 2017 1:11 AM
> To: A.S. Dong
> Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm
> Mailing List; Greg Kroah-Hartman; Jiri Slaby; Andy Duan; Stefan Agner;
> Mingkai Hu; Y.B. Lu
> Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud
> rate calculation method
> 
> On Wed, May 31, 2017 at 5:18 PM, A.S. Dong <aisheng.dong@nxp.com> wrote:
> >> On Tue, May 9, 2017 at 10:50 AM, Dong Aisheng <aisheng.dong@nxp.com>
> wrote:
> 
> By some reason my previous message went privately.
> It didn't have anything major anyway and here I'm suggesting optimization
> of finding factors of the formula in use. See below.
> 
> >> > +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
> >> > +       u32 clk = sport->port.uartclk;
> >> > +
> >> > +       /*
> >> > +        * The idea is to use the best OSR (over-sampling rate)
> possible.
> >> > +        * Note, OSR is typically hard-set to 16 in other LPUART
> >> instantiations.
> >> > +        * Loop to find the best OSR value possible, one that
> >> > + generates
> >> minimum
> >> > +        * baud_diff iterate through the rest of the supported
> >> > + values of
> >> OSR.
> >> > +        *
> >> > +        * Calculation Formula:
> >> > +        *  Baud Rate = baud clock / ((OSR+1) ? SBR)
> >> > +        */
> >> > +       baud_diff = baudrate;
> >> > +       osr = 0;
> >> > +       sbr = 0;
> >> > +
> >>
> >> > +       for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {
> 
> I missed one thing, what happened by default to OSR? What is the value in
> use?
> 

No valid default value. (osc/sbr are 0 by default)
If no proper osc and sbr calculated, a WARNING will show.

> >> I _think_ you may simplify this and avoid for-loop if you reconsider
> >> approach.
> 
> > But there is indeed a optimization way, see below.
> 
> > To optimize the looping, we probably could do:
> > If (!baud_diff)
> >         Break;
> 
> It's a small one, we may have more interesting approach.
> 
> So, the algo is the following:
> 
> Assume the ranges like this:
> OSR = [4 ... 32]
> SBR = [2 ... 8192]
> 

Baud Rate = baud clock / ((OSR+1) ? SBR)

In HW:
OSR range : 3 ? 31
SBR range: 1 ? 8191

> Then:
> 
> 1. Get ratio factor as
>       ratio = CLK / desired baud rate
> 2. If ratio < 8192 * 9 / 2, just use (ratio / 4, 4) as (OSR, SBR) setting.
> (Needs clarification on OSR < 4) 

Sorry that I'm a bit mess here.
What is 8192 * 9 /2 meaning?

And for (ratio / 4, 4) as (OSR,SBR), take 115200 as an example:
Assuming baud clock 24Mhz.

Ratio = 24000000 / 115200 = 208
OSR = Ratio / 4 = 52 
Then OSR is out of range which seems wrong.

> 3. if ratio >= 8192 * 31, just use those
> two numbers (8192, 31). You can't do anything better there.

This actually may not happen.
Even take a 9600 as example, the clk becomes:
8191 * 31 * 9600 = 2.4GHz
Which is theoretically not exist.

> 4. Otherwise, get a minimum required factor of OSR
>       osr_min = ratio / 8192
> 5. Start your loop from osr_min + 1 to 31.
> 
> 6 (optional). Of course you may not consider baud_diff > osr_min, it's I
> suppose obvious
> 
> P.S. Note, all divisions by 2^n are just simple right shifts. Diffs are
> calculated as multiplication of OSR and SBR in comparison to ratio. One
> division so far.
> 

I'm not quite understand the approach.

How about you send a separate baud algorithm improvement patch later?
Then it first can provide us a good patch history and also better to
understand for review.

Last, very appreciate for your kind and professional review.

Regards
Dong Aisheng

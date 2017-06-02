From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 2 Jun 2017 20:11:24 +0300
Subject: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
In-Reply-To: <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 5:18 PM, A.S. Dong <aisheng.dong@nxp.com> wrote:
>> On Tue, May 9, 2017 at 10:50 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

By some reason my previous message went privately.
It didn't have anything major anyway and here I'm suggesting
optimization of finding factors of the formula in use. See below.

>> > +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
>> > +       u32 clk = sport->port.uartclk;
>> > +
>> > +       /*
>> > +        * The idea is to use the best OSR (over-sampling rate) possible.
>> > +        * Note, OSR is typically hard-set to 16 in other LPUART
>> instantiations.
>> > +        * Loop to find the best OSR value possible, one that generates
>> minimum
>> > +        * baud_diff iterate through the rest of the supported values of
>> OSR.
>> > +        *
>> > +        * Calculation Formula:
>> > +        *  Baud Rate = baud clock / ((OSR+1) ? SBR)
>> > +        */
>> > +       baud_diff = baudrate;
>> > +       osr = 0;
>> > +       sbr = 0;
>> > +
>>
>> > +       for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {

I missed one thing, what happened by default to OSR? What is the value in use?

>> I _think_ you may simplify this and avoid for-loop if you reconsider
>> approach.

> But there is indeed a optimization way, see below.

> To optimize the looping, we probably could do:
> If (!baud_diff)
>         Break;

It's a small one, we may have more interesting approach.

So, the algo is the following:

Assume the ranges like this:
OSR = [4 ... 32]
SBR = [2 ... 8192]

Then:

1. Get ratio factor as
      ratio = CLK / desired baud rate
2. If ratio < 8192 * 9 / 2, just use (ratio / 4, 4) as (OSR, SBR)
setting. (Needs clarification on OSR < 4)
3. if ratio >= 8192 * 31, just use those two numbers (8192, 31). You
can't do anything better there.
4. Otherwise, get a minimum required factor of OSR
      osr_min = ratio / 8192
5. Start your loop from osr_min + 1 to 31.

6 (optional). Of course you may not consider baud_diff > osr_min, it's
I suppose obvious

P.S. Note, all divisions by 2^n are just simple right shifts. Diffs
are calculated as multiplication of OSR and SBR in comparison to
ratio. One division so far.

-- 
With Best Regards,
Andy Shevchenko

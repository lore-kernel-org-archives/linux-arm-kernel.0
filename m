From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 8 Sep 2016 21:06:25 +0200
Subject: [RFC PATCH 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <CAFcVECJxJgJUeO4=yudwTj5NkxDob5tCZaom9YTqWWmtt7ajFw@mail.gmail.com>
References: <1472820817-21874-1-git-send-email-andrei.pistirica@microchip.com>
 <20160906154809.GA7012@localhost.localdomain>
 <CAFcVECJxJgJUeO4=yudwTj5NkxDob5tCZaom9YTqWWmtt7ajFw@mail.gmail.com>
Message-ID: <20160908190624.GA5237@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 10:22:43AM +0530, Harini Katakam wrote:
> >> +     /* get GEM internal time */
> >> +     sech = gem_readl(bp, TSH);
> >> +     secl = gem_readl(bp, TSL);
> >
> > Does reading TSH latch the time?  The TRM is silent about that, and
> > most other designs latch on reading the LSB.
> 
> No, it does not latch the time.
> When doing a read + adjust + write, this will
> mean there's room for some error.

It also means that you will have to handle when the TSL value
overflows into TSH.  That means reading TSH twice, once before and
once after reading TSL and retrying if needed.

The code as written above will produce apparent jumps backwards in
time, whenever the overflow occurs between the two read operations.

Thanks,
Richard

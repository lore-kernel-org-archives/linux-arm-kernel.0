From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 09:53:53 +0200
Subject: [PATCH 4/5] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <CAGb2v647bc0VdYTQDyEjAerKnfjtkDYGdhnUgpTU-Tuns6FYYA@mail.gmail.com>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-5-wens@csie.org>
 <20170214095819.utsftcvti5zdmlmi@lukather>
 <CAGb2v66PxbhUdqSwFc5iFN2wDVQbOsibDkckXpFsxXW1WJNe3w@mail.gmail.com>
 <20170215094954.h3wyaxlqkeb342yu@lukather>
 <CAGb2v67ey1Ppc3wf1154QKoCX-xsOjWDEsXi5gxPbL4MY37zHw@mail.gmail.com>
 <20170326205124.vdjbmjukfysgbefc@lukather>
 <CAGb2v647bc0VdYTQDyEjAerKnfjtkDYGdhnUgpTU-Tuns6FYYA@mail.gmail.com>
Message-ID: <20170403075353.ep4yoadxjpw5c5vf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 04:53:05PM +0800, Chen-Yu Tsai wrote:
> >> To me it seems the "factors" bits are mostly the same. Differences
> >> are mostly with parent-specific pre-dividers, clock post-dividers,
> >> and non-standard factors. The first is nicely handled by the new mux
> >> wrapper, the second is currently only used with NK types, and the
> >> last is currently only supported by single factor divider or
> >> multiplier clocks with tables.
> >>
> >> Non-standard factors are probably the trickiest one, but given we will
> >> support full factor tables for some of the tricky CPU PLLs, this is
> >> probably solved, even if not implemented yet.
> >>
> >> I'll start with the NP style clocks, which only use P when the output
> >> is under a certain frequency.
> >
> > Do we need to use a P factor? I mean, we can just create a custom
> > clock for that, I'd realy don't want to cripple the generic code for a
> > completely non-generic problem.
> 
> I'm not sure. AFAIK the vendor BSP cpufreq doesn't use frequencies
> low enough to require the P divider, so we could just ignore it. But
> then we need to make sure it's set to 1 at probe time, while keeping
> the output frequency usable, which would kind of bloat the probe
> function. FYI I'm in favor of doing it this way.

Hmmm, I don't know why I replied that anymore, I thought you were
still talking about MMC, while you were clearly talking about
CPU_PLLs...

The question still remains though. If we're not using P yet, and if
the BSP doesn't either, then we can just hardcode it.

We can always come up with something later if we need to use it,
either an NP-class, or a table. The only thing we need to care about
would be to pay attention to what the P factor already is, before
forcing it to 1. If it's set to 4, that would mean multiplying the CPU
clock by 4, which is probably not such a great idea.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/59f79643/attachment-0001.sig>

From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Mar 2017 16:53:05 +0800
Subject: [PATCH 4/5] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170326205124.vdjbmjukfysgbefc@lukather>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-5-wens@csie.org>
 <20170214095819.utsftcvti5zdmlmi@lukather>
 <CAGb2v66PxbhUdqSwFc5iFN2wDVQbOsibDkckXpFsxXW1WJNe3w@mail.gmail.com>
 <20170215094954.h3wyaxlqkeb342yu@lukather>
 <CAGb2v67ey1Ppc3wf1154QKoCX-xsOjWDEsXi5gxPbL4MY37zHw@mail.gmail.com>
 <20170326205124.vdjbmjukfysgbefc@lukather>
Message-ID: <CAGb2v647bc0VdYTQDyEjAerKnfjtkDYGdhnUgpTU-Tuns6FYYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 4:51 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Wed, Mar 22, 2017 at 02:50:31PM +0800, Chen-Yu Tsai wrote:
>> On Wed, Feb 15, 2017 at 5:49 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Tue, Feb 14, 2017 at 06:26:39PM +0800, Chen-Yu Tsai wrote:
>> >> On Tue, Feb 14, 2017 at 5:58 PM, Maxime Ripard
>> >> <maxime.ripard@free-electrons.com> wrote:
>> >> > On Tue, Feb 14, 2017 at 11:35:25AM +0800, Chen-Yu Tsai wrote:
>> >> >> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
>> >> >
>> >> > Is that even working?
>> >>
>> >> Looking at the nkmp clock code, only .recalc_rate will work properly though.
>> >> Maybe I could fix up the code so it handles zero width factors.
>> >>
>> >> > I'm not quite sure we want to do that. We might model it as a NP clock
>> >> > with a variable prediv?
>> >>
>> >> There's no NP clock type yet. And a problem with a variable prediv is that
>> >> it doesn't participate in factor calculation. It's effectively fixed.
>> >>
>> >> I did this for the A80 as well though. Fixing up the NKMP clock might be
>> >> easier.
>> >
>> > Then maybe we just need a NMP clock type then. What I'm really afraid
>> > of is that we'll just end up in a clk-factors situation that was
>> > simply impossible to maintain without breaking anything, hence why we
>> > had different clock types then.
>>
>> Upon further review, I think it will work. I did notice a discrepancy
>> between .set_rate and .round_rate though. Will send fixes later.
>>
>> About the old clk-factors situation, I'm not exactly sure what part
>> you're referring to.
>
> We need to be able to support old DTs, which will still use the old
> clock code. Whatever solution we come up with need to take that into
> account.
>
>> To me it seems the "factors" bits are mostly the same. Differences
>> are mostly with parent-specific pre-dividers, clock post-dividers,
>> and non-standard factors. The first is nicely handled by the new mux
>> wrapper, the second is currently only used with NK types, and the
>> last is currently only supported by single factor divider or
>> multiplier clocks with tables.
>>
>> Non-standard factors are probably the trickiest one, but given we will
>> support full factor tables for some of the tricky CPU PLLs, this is
>> probably solved, even if not implemented yet.
>>
>> I'll start with the NP style clocks, which only use P when the output
>> is under a certain frequency.
>
> Do we need to use a P factor? I mean, we can just create a custom
> clock for that, I'd realy don't want to cripple the generic code for a
> completely non-generic problem.

I'm not sure. AFAIK the vendor BSP cpufreq doesn't use frequencies
low enough to require the P divider, so we could just ignore it. But
then we need to make sure it's set to 1 at probe time, while keeping
the output frequency usable, which would kind of bloat the probe
function. FYI I'm in favor of doing it this way.

ChenYu

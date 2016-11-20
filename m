From: dianders@chromium.org (Doug Anderson)
Date: Sun, 20 Nov 2016 11:18:48 -0800
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <58309A02.4030804@free.fr>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk> <582F0DD2.3030805@free.fr>
 <20161119071702.GA25647@afzalpc> <20161119110301.GQ1041@n2100.armlinux.org.uk>
 <58309A02.4030804@free.fr>
Message-ID: <CAD=FV=WQCfpvVrn64LjxfeG2S7peU5ZWKVGsRyU83-zNCVZmxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 19, 2016 at 10:29 AM, Mason <slash.tmp@free.fr> wrote:
>> Exactly - and the reason for that (as I've explained several times in
>> the past) the "standard" software delay loop calibrated against the
>> timer interrupt is _always_ going to be short.
>
> OK, so loop-based delays are known to be short. Would you or Linus
> accept a patch that adds a X% cushion *in the implementation* ?
>
> You are saying "people shouldn't expect udelay(10) to delay at least
> 10 ?s, thus they should write udelay(10+N)".
>
> Why not hide that implementation detail inside the implementation,
> so as not to force the pessimization on every other implementation
> behind the udelay/ndelay wrapper?
>
> void loop_based_udelay(long us) {
>   spin_for_some_us(us + us/8);
> }

IMHO this would be an extremely sane thing to do.

Then, if you happened to be on a platform where udelay _was_ accurate
then you could eliminate the pointless overhead.  ...and also if you
were writing code to a datasheet and it said "delay for 50 us between
A and B" you could actually write udelay(50) instead of everyone
needing to know that they should write "udelay(53)".

-Doug

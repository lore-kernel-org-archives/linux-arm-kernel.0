From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Jul 2015 08:50:17 +0200
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <20150724000001.642.84690@quantum>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
 <20150523074930.GI8557@lukather> <20150724000001.642.84690@quantum>
Message-ID: <20150724065017.GJ2373@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Jul 23, 2015 at 05:00:01PM -0700, Michael Turquette wrote:
> Quoting Maxime Ripard (2015-05-23 00:49:30)
> > On Fri, May 22, 2015 at 12:35:35PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > > 
> > > On Fri, May 22, 2015 at 4:54 AM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > > > Some clocks are using a factor component, however, unlike their mux, gate
> > > > or divider counterpart, these factors don't have a basic clock
> > > > implementation.
> > > 
> > > I think "multiplier" would be a better name here, considering it is the
> > > counterpart of "divider". "factor" implies you can multiply and/or divide
> > > the clock rate.
> > 
> > You're probably right, I didn't though of it that way :)
> 
> I also prefer multiplier over factor.

Ok. Note that I re-submitted it some time this week and forgot to
change it, but I'm perfectly fine with the name.

> Jim Quinlan submitted a similar patch. See here:
> 
> http://www.spinics.net/lists/linux-clk/msg00691.html

It looks very similar indeed.

> I nacked that patch because Stephen and I are trying to figure out how
> the basic clock types should work going forward. Code reuse is good, but
> they are not very maintainable.

What are the issues with maintaining them? The only drawback I'm
seeing with introducing such a driver is that you can't really have a
clock that is both a divider and a multiplier, but that can be solved
by splitting it into two sub-clocks.

>From a pure maintainance point of view, refusing it would mean that
each and every platform would have to come up with its own
implementation. For example, we do have clk-factors.c for sunxi that
does just that, and implies some cooperation from each clock driver
that have to provide some code to determine the various components of
the output formula. This can prove to be very challenging (and bug
prone) for clocks like the audio one we have where we have 1
multiplier and 2 dividers that needs some adjusting.

Splitting it into sub-clocks for each of these components would allow
to have less bugs, while keeping the whole thing very simple, and the
implementation on the driver side very trivial.

Overall, the clk-factors code we have (client side) is approximately a
thousand lines of code logic that could be replaced by (less) trivial
probing code for such a driver.

> Since there are two potential users of this code, I should reconsider.

Like I said, eventually, I'd like to leverage that code a lot more
than for the single clock alone, and I think it could benefit other
platforms too (like Jim has proven).

> Can you two come up with a common implementation that works for both of
> you?

Yes, sure. Jim, how do you want to go with this? Do you want to
resubmit your patch on top of 4.2-rc something so that I could give it
a try? Otherwise, I posted such a patch this week

https://lkml.kernel.org/r/1437235304-2208-1-git-send-email-maxime.ripard at free-electrons.com

Can you give it a try and your feedback?

> Please do not put any CLK_OF_DECLARE stuff in there (there isn't
> any now, but I wanted to be clear).

That's never been my intention ;)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/5dffba06/attachment-0001.sig>

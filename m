From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Nov 2013 10:11:43 +0100
Subject: [PATCH] clocksource: sirf/marco+prima2: drop usage of
 CLOCK_TICK_RATE
In-Reply-To: <5296F213.9030006@linaro.org>
References: <1384201236-8689-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5283DA74.9080402@linaro.org>
 <20131114090705.GX14892@pengutronix.de>
 <20131126135513.GI28642@pengutronix.de>
 <5296F213.9030006@linaro.org>
Message-ID: <20131128091143.GT28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Thu, Nov 28, 2013 at 08:34:43AM +0100, Daniel Lezcano wrote:
> On 11/26/2013 02:55 PM, Uwe Kleine-K?nig wrote:
> >Hi Danial,
ooops, sorry for the typo here,

> >>	Since CSR SiRF was converted to multi platform in cf82e0e (ARM:
> >>	sirf: enable multiplatform support) the symbol CLOCK_TICK_RATE
> >>	isn't the platform specific definition any more, but a global
> >>	dummy value. There was no harm introduced in cf82e0e because the
> >>	global value happens to match the old platform specific one,
> >>	still this dummy value isn't intended to be used and will
> >>	hopefully disappear soon, so introduce a local #define and use
> >>	that instead.
> >>
> >>So it's not urgent, but would be a nice cleanup for 3.14-rc1.
> >I'd like to depend on this patch to drop CLOCK_TICK_RATE for
> >mach-prima2. Would it be ok for you when I include it in a pull request
> >to the arm-soc people? If not, do you intend to take that patch, or do
> >you still have objections? In that case I'd back out mach-prima2 from my
> >CLOCK_TICK_RATE change.
Note that this would make prima2 the only platform that would need
special handling as all other patches are ready now. So I'd really like
to get that resolved soon.
 
> I think it would be better to keep the macro name consistent and
> redefine it in the file with a comment.
> 
> /* over riding default value because bla bla */
> #ifdef CLOCK_TICK_RATE
> #undef CLOCK_TICK_RATE
> #define CLOCK_TICK_RATE 100000
> #endif
Hmm, I don't like that. Redefining symbols might easily result in
surprises. Moreover I want to completely get rid of CLOCK_TICK_RATE (for
ARM at least), doing that redefinition makes this driver result in false
positives when grepping for sites still using CLOCK_TICK_RATE.

> So people reading the code won't have to scratch their head to
> understand why CLOCK_FREQ is used instead of CLOCK_TICK_RATE. And
> that will limit the impact in the code.
IMHO this is shortsighted. Seeing only a snipplet of code using
CLOCK_TICK_RATE might be easy to understand for someone who knows about
CLOCK_TICK_RATE. But in fact thats an illusion because the code looks
like using a global constant, but in fact it isn't. If the reader
doesn't see the redefinition the value might differ from his
expectations; also worse. Now add that the global CLOCK_TICK_RATE will
die, so it will become less common that people know about
CLOCK_TICK_RATE. Probably using a name that doesn't suggest it might be
global (like MARCO_CLOCK_FREQ) is still better.
 
> Alternatively, I am wondering if that shouldn't fall into the DT,
> without the declaration in the DT, it defaults to 100000.
I didn't check how the constant is used, but I agree it should be an
overwritable default. Given that I don't care much about that driver but
my intention is to get rid of <mach/timex.h> for all ARM platforms my
motivation to add features to a driver I cannot even test is low.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

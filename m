From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Oct 2015 08:43:04 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <CAAEAJfCfYo+J32PuW8k2p1S5eFxeCL6qTPeTLCGrNQrA0yC1kQ@mail.gmail.com>
References: <20151026080537.GW4931@pengutronix.de>
 <CAAEAJfB0yywtQ2MrYf2ih5+a3fZJXAy0hFSXWA038wQMQswa7g@mail.gmail.com>
 <CAAEAJfD29_PSTw+srx7d2YrF+Akx-_94Wv9ifKzT+8HTfH5tGA@mail.gmail.com>
 <562FA053.6010208@st.com>
 <CALszF6C4B-S-o3E1OHK3+bKpDQ8a64Ly-ABNQwfSfj95y7qFyA@mail.gmail.com>
 <85aea33b93066d0959d98b56f8787ba3@agner.ch>
 <CALszF6Di3LWLu_W67Zdn2LyKKRF_5U241eKFKMmJ-0s+0boFag@mail.gmail.com>
 <CAAEAJfCL8veLOi9zi8kARL2kBcYQfxwKS13-mkGbQ_U6Ojg9LA@mail.gmail.com>
 <CALszF6Aodf0nXwsrE+Rtrg6UQw-1OMGY+BdadtK-dtHYv-Bqnw@mail.gmail.com>
 <CAAEAJfCfYo+J32PuW8k2p1S5eFxeCL6qTPeTLCGrNQrA0yC1kQ@mail.gmail.com>
Message-ID: <20151028074304.GN4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ezequiel,

On Tue, Oct 27, 2015 at 07:08:46PM -0300, Ezequiel Garcia wrote:
> On 27 October 2015 at 18:52, Maxime Coquelin <mcoquelin.stm32@gmail.com> wrote:
> > 2015-10-27 22:46 GMT+01:00 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>:
> >> On 27 October 2015 at 18:33, Maxime Coquelin <mcoquelin.stm32@gmail.com> wrote:
> >>> 2015-10-27 21:33 GMT+01:00 Stefan Agner <stefan@agner.ch>:
> > ...
> >>>> Anyway, I guess Ezequiel's fix is the right thing to do...
> >>> Or, maybe we should put the stack in RAM as Uwe suggest?
> >>>
> >>
> >> It seems the current fix would be used as-is (no need to
> >> set a temporary stack before the SVC call).
> >>
> >> And on top of that, we need a to set a proper stack as soon
> >> as the kernel takes control.
> >>
> >> Am I right?
> > IMHO, yes, that's how I understand it.
> >
> 
> After some deeper code parsing, it seems the stack
> is set in __mmap_switched.
> 
> Although it seems that happens after __v7m_setup,
> ARM noMMU has worked like this since ages now, is v7-M
> really different to need a special treatment?

Yeah, v7-M needs stack in it's setup function, while earlier no-MMU
machines don't. (I didn't check that though.)

So the current situation is that in svc something is written to
__v7m_setup_stack which doesn't seem to hurt in practise on most
machines, but on your's is provokes a hang.

With your patch the same something is written to whereever sp points to
when the kernel is entered. This is hardly better.

So the right fix is to move __v7m_setup_stack to .data I guess.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

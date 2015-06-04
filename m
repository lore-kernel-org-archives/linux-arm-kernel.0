From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 04 Jun 2015 22:39:31 +0200
Subject: [PATCH 00/21] On-demand device registration
In-Reply-To: <556F5C24.1030101@linaro.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com>
 <556F5C24.1030101@linaro.org>
Message-ID: <5570B783.1050808@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.06.2015 um 21:57 schrieb Grygorii.Strashko at linaro.org:

...

> So few comments from above:
> - registering devices later during the System boot may improve boot time.
>   But resolving of all deferred probes may NOT improve boot time ;) 
>   Have you seen smth like this?

If someone is out for boot time reduction, I think one of the best ways
would by making driver initialization parallel. Keep in mind that all
linked in drivers currently are initialized in series.

As it seems to have been forgotten or overread, I've mentioned in my
series of patches last year that, with a few changes, it's possible to
let the algorithm I've used (dfs) to spit out all drivers which can be
initialized in parallel.

But as I'm not paid for the work I've done and just did it out of
curiosity, interest or how ever you want name it, I haven't spend any
more time into that topic, especially as I'm missing the necessary
connections to get patches into the kernel. ;)

But, as said, it's easy (at least if aren't getting panic when it comes
to a bit of algorithm theory) to get a list drivers you can start in
parallel if you have such a complete list of dependencies as DT already
offers. Just look at the pictures generate by dtc (using my patches),
you will see, they already show which drivers can be initialized in
parallel.

So it would be easy to use e.g. all cores already very early at boot to
initialize drivers, not just after init got started. Besides that the
w?rgaround of defered init (which, btw. leads devs to supress error
messages, which is especially bad if you are searching a problem) isn't
needed anymore if you have a list of dependecies (however you get it,
I've used DT because the dependencies already are all there).

Regards,

Alexander Holler

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2012 10:22:31 +0100
Subject: [PATCH] arm: sched: stop sched_clock() during suspend
In-Reply-To: <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
Message-ID: <20121023092231.GE28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:28:32AM +0200, Linus Walleij wrote:
> On Mon, Oct 22, 2012 at 7:05 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> 
> > However, in light of RT throttling, this a correctness issue for process
> > accounting, so I agree that this should be done for all platforms
> > instead of providing an optional 'needs suspend' version of the API,
> > even though it means printk times no longer reflect time spent
> > suspended.
> 
> Maybe we should get printk() to use the best clocksource
> instead.
> 
> The reason AFAICT that printk() is using sched_clock() is that
> it's supposed to be fast. But now it seems that it's not going
> to return what printk() needs anymore.

No, printk() does not need this.  You think it does, but it doesn't.  What
we have is a difference between ARM and x86, and this difference is breaking
the scheduler.

The fact that the printk timestamp increments while suspended is a bug.  It
doesn't on x86.

There's three other functions in the kernel which do return updated time.
I'm sure one of those can be used to printk() the time passed in suspend
at resume time, which would give the information required.

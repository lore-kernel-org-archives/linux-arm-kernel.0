From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 Sep 2013 22:30:15 +0200 (CEST)
Subject: [PATCH 1/2] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <1379004640-15117-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379004640-15117-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <alpine.DEB.2.02.1309122224420.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Sep 2013, Soren Brinkmann wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> On most ARM systems the per-cpu clockevents are truly per-cpu in
> the sense that they can't be controlled on any other CPU besides
> the CPU that they interrupt. If one of these clockevents were to
> become a broadcast source we will run into a lot of trouble
> because the broadcast source is enabled on the first CPU to go
> into deep idle (if that CPU suffers from FEAT_C3_STOP) and that
> could be a different CPU than what the clockevent is interrupting
> (or even worse the CPU that the clockevent interrupts could be
> offline).
> 
> Theoretically it's possible to support per-cpu clockevents as the
> broadcast source but so far we haven't needed this and supporting
> it is rather complicated. Let's just deny the possibility for now
> until this becomes a reality (let's hope it never does!).

Well, we can't do it this way. There are globally accessible clock
event devices which deliver only to cpu0. So the mask check might be
causing failure here.

Just add a feature flag CLOCK_EVT_FEAT_PERCPU to the clock event
device and check for it.

Thanks,

	tglx

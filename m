From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 01:22:13 +0100
Subject: [RFC] IDLE/DEEP IDLE scheduler modification for power savings
In-Reply-To: <s2q1b68c6791004120555qb0ab21ffm9a641ec3f2423597@mail.gmail.com>
References: <000001cada24$01a5ee90$04f1cbb0$%majewski@samsung.com>
	<s2q1b68c6791004120555qb0ab21ffm9a641ec3f2423597@mail.gmail.com>
Message-ID: <20100511002212.GA26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 09:55:28PM +0900, jassi brar wrote:
> On Mon, Apr 12, 2010 at 6:39 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > One approach to solve the problem, and therefore deliver power savings,
> > is to modify the ALSA driver and provide a switch to inform the CPU IDLE
> > framework that it should now use the DEEP IDLE instead of IDLE when entering
> > the Low Power Audio playback mode is expected. ?This change may be performed
> > by replacing the method for entering the IDLE mode to DEEP IDLE. Moreover
> > some sources immune to power gating (like e.g. RTC timer) have to be used
> > for waking up. The biggest problem for this approach is the kernel's policy
> > violation, that no user program should directly change scheduling/idle
> > policy.
> Actually any power saving mode is transparent to the LPAM(LowPowerAudioMode).
> "LPAM h/w" is simply an I2S controller with an additional 'overlay'
> stereo channel
> which is h/w-mix'ed with the first two of the 6 channels. And these overlay
> channels works just as well in normal power mode. LPAM is but one
> ramification of
> of the platform using the interrupt as a wakeup source. It is also used for
> low latency playback like 'alerts' and 'alarms'.
> Our LPAM doesn't work right away not because of the power management stack
> but because ASoC can't yet handle a
> codec-active-in-system-suspended-mode scenario.
> So, I too think it's a bad idea to hack core PM for things like LPAM.
> 
> > So what is your opinion about integrating use of the DEEP IDLE state mode
> > in the scheduler (either as new scheduling policy or modifying scheduler
> > code)?
> imho, such 'variation' in suspend had better be implemented in
> platform specific manner.
> Just because samsung's manual call it deep-IDLE doesn't make it an 'IDLE' mode.
> It is closer to suspend than idle, at least to me.

It does seem to be a form of suspend, as it halts the SDRAM and powers
down the ARM core... this means that there's a whole pile of stuff that
needs to be considered before allowing the system to go into such a state.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

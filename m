From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Dec 2010 17:21:05 +0000
Subject: [PATCH] ARM: perf: use raw_spinlock_t for pmu_lock
In-Reply-To: <004e01cb9177$2760c460$76224d20$@deacon@arm.com>
References: <1291137443-13821-1-git-send-email-will.deacon@arm.com>
	<20101201163547.GE2898@pulham.picochip.com>
	<004e01cb9177$2760c460$76224d20$@deacon@arm.com>
Message-ID: <20101201172105.GB29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 04:45:25PM -0000, Will Deacon wrote:
> Hi Jamie,
> 
> > Subject: Re: [PATCH] ARM: perf: use raw_spinlock_t for pmu_lock
> 
> [...]
> 
> > Looks fine to me and tested on my board (not with PREEMPT_RT at the moment
> > though). Btw, it may be my mail reader (mutt) but trying to save your mail to
> > an mbox gave lots of extra characters in the patch like:
> > 
> > diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v=
> > 6.c
> > index 3f427aa..c058bfc 100644
> > --- a/arch/arm/kernel/perf_event_v6.c
> > +++ b/arch/arm/kernel/perf_event_v6.c
> > @@ -426,12 +426,12 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
> >  =09 * Mask out the current event and set the counter to count the event
> >  =09 * that we're interested in.
> >  =09 */
> > -=09spin_lock_irqsave(&pmu_lock, flags);
> > +=09raw_spin_lock_irqsave(&pmu_lock, flags);
> 
> Oh dear...
>  
> > Possibly an Exchange thing? Saving the message body worked and your
> > hw_breakpoint patches are fine.
> 
> Hmm, I just use an smtp server for sending messages so the message *should*
> be ok. It's the receiving side of things where I get into trouble. If I look
> at the .patch I gave to git send-email with hexdump it has:
> 
> 000007d0  69 74 65 28 76 61 6c 29  3b 0a 2d 09 73 70 69 6e  |ite(val);.-.spin|
> 000007e0  5f 75 6e 6c 6f 63 6b 5f  69 72 71 72 65 73 74 6f  |_unlock_irqresto|
> 000007f0  72 65 28 26 70 6d 75 5f  6c 6f 63 6b 2c 20 66 6c  |re(&pmu_lock, fl|
> 00000800  61 67 73 29 3b 0a 2b 09  72 61 77 5f 73 70 69 6e  |ags);.+.raw_spin|
> 00000810  5f 75 6e 6c 6f 63 6b 5f  69 72 71 72 65 73 74 6f  |_unlock_irqresto|
> 00000820  72 65 28 26 70 6d 75 5f  6c 6f 63 6b 2c 20 66 6c  |re(&pmu_lock, fl|
> 00000830  61 67 73 29 3b 0a 20 7d  0a 20 0a 20 73 74 61 74  |ags);. }. . stat|
> 
> So it looks like tabs (ascii code 0x09) are being converted to =09 somewhere
> on your end. Mutt should be fine, what are you connecting it to?

That's called 'quoted-printable' encoding.

I suspect something in Jamie's path is reformatting the body of the
message (which I believe MTAs are allowed to do if they receive
something in 8-bit MIME and need to convert it to 7-bit to pass it
along - but there wasn't anything which was 8-bit in your original
message.)

For reference, your original message came through to me without being
converted to QP, so its not the mailing list doing it.  I use mutt too
and am not seeing a problem.

For reference, you can't get away from QP mime encodings, especially
if we're going to allow high-bit-set characters in the source code
(eg, UTF-8 in comments).  You need a mailer which deals with them.
Mutt does this if you save out the body (hit 'v' when viewing the
message) rather than saving it in mbox format (using C or s in the
index.)

From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 17:35:31 +0100
Subject: [PATCH 1/6] ARM: prefetch: remove redundant "cc" clobber
In-Reply-To: <alpine.LFD.2.03.1307241205050.15022@syhkavp.arg>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231547010.15022@syhkavp.arg>
 <20130724101950.GG9629@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307241205050.15022@syhkavp.arg>
Message-ID: <20130724163530.GV11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 05:16:59PM +0100, Nicolas Pitre wrote:
> On Wed, 24 Jul 2013, Will Deacon wrote:
> > On Tue, Jul 23, 2013 at 08:48:11PM +0100, Nicolas Pitre wrote:
> > > You know the legacy reason why the cc clobber was there, right?
> > > It certainly doesn't apply anymore.
> > 
> > I was under the impression that it was due to ancient GCC behaviour and the "cc"
> > was there to prevent re-ordering. For interest, what are the specifics?
> 
> In the old days, you had to take care of the predicate for conditional 
> instructions in your inline asm code.  So for example, if you had:
> 
> 	if (foo)
> 		inline asm ("mov %0, #1" : "=r" (bar));
> 
> That wouldn't work most of the time because even if the if condition was 
> false, gcc would not branch over the inline asm code but expect you to 
> take care of the condition code.  That means the above needed to be 
> written as:
> 
> 	if (foo)
> 		inline asm ("mov%? %0, #1" : "=r" (bar));
> 
> Because having %? added all over the place was cumbersome, the 
> alternative was to add "cc" to the clobber list so gcc would then branch 
> across the inline asm when the condition is false.
> 
> But of course many people forgot about those subtle details quite often, 
> and then gcc was changed so inline asm was made non predicated.

Holy sh*t....

Next time I complain to the tools guys about inline asm, I'll count my
blessings so they don't try and resurrect anything as horrendous as what
you've just described.

Thanks for the insight!

Will

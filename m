From: davidb@codeaurora.org (David Brown)
Date: Sun, 02 Jan 2011 10:49:32 -0800
Subject: [PATCH 1/3] hvc_dcc: Fix bad code generation by marking assembly
	volatile
In-Reply-To: <20110102090019.GC32469@atrey.karlin.mff.cuni.cz> (Pavel Machek's
	message of "Sun, 2 Jan 2011 10:00:19 +0100")
References: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-2-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1012201638150.10437@xanadu.home>
	<20110102090019.GC32469@atrey.karlin.mff.cuni.cz>
Message-ID: <8yazkrjkuo3.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 02 2011, Pavel Machek wrote:

>> > diff --git a/drivers/char/hvc_dcc.c b/drivers/char/hvc_dcc.c
>> > index 6470f63..155ec10 100644
>> > --- a/drivers/char/hvc_dcc.c
>> > +++ b/drivers/char/hvc_dcc.c
>> > @@ -33,8 +33,7 @@
>> >  static inline u32 __dcc_getstatus(void)
>> >  {
>> >  	u32 __ret;
>> > -
>> > -	asm("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
>> > +	asm volatile("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
>> >  		: "=r" (__ret) : : "cc");
>> >  
>> >  	return __ret;
>
> Is volatile needed here? If __dcc_getstatus() return value is
> discarded, we want assembly discarded, right?

That's not really the issue being fixed.  Without the volatile, the
compiler is free to cache and reuse a previously loaded status value.
It is important that the status be read each time.

I don't think there is a way of indicating that assembly needs to happen
for each use, but that it is OK to discard if the value isn't used.
'volatile' is a bit overloaded.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

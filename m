From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Sep 2013 15:32:13 +0100
Subject: [PATCH] arm: Fix build error with context tracking calls
In-Reply-To: <20130913170331.GA8453@somewhere>
References: <522CB0DE.2010102@roeck-us.net>
 <20130909105115.GL25647@n2100.arm.linux.org.uk>
 <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
 <20130909160348.GB18975@roeck-us.net>
 <20130909203141.GM25647@n2100.arm.linux.org.uk>
 <20130909210203.GC28416@roeck-us.net>
 <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg> <87y574g1fi.fsf@linaro.org>
 <20130913170331.GA8453@somewhere>
Message-ID: <20130914143213.GN25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 07:03:34PM +0200, Frederic Weisbecker wrote:
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 247091b..859c8df 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -51,6 +51,15 @@ void context_tracking_user_enter(void)
>  	unsigned long flags;
>  
>  	/*
> +	 * Repeat the user_enter() check here because some archs may be calling
> +	 * this from asm and if no CPU needs context tracking, they shouldn't
> +	 * go further. We can remove that check here once these archs support the static key
> +	 * check.

The only (minor) comment on this is that the above would fail checkpatch,
but that's not a good enough reason to respin it if you've already applied
it IMHO.

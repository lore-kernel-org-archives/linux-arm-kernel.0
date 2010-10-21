From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 21 Oct 2010 16:10:52 +0200
Subject: [PATCH 1/2] [ARM] Kirkwood: enhance TLCK detection
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FD18F0B40AB@IL-MB01.marvell.com>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287647127-1434-1-git-send-email-simon@sequanux.org>
	<20101021075318.GB22363@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B3FA2@IL-MB01.marvell.com>
	<20101021095802.GE22363@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B40AB@IL-MB01.marvell.com>
Message-ID: <20101021141052.GF22363@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 01:03:26PM +0200, Saeed Bishara wrote:

> >> >> -	if ((dev == MV88F6281_DEV_ID && (rev == MV88F6281_REV_A0 ||
> >> >> -					rev == MV88F6281_REV_A1)) ||
> >> >> -	    (dev == MV88F6282_DEV_ID))
> >> >> -		return 200000000;
> >> >> +	if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
> >> >> +		if ((readl(SAMPLE_AT_RESET) >> 21 & 1) == 0)
> >> >> +			return 200000000;
> >> >>  
> >> >>  	return 166666667;
> >> >>  }
> >> >
> >> >Can we not just make this:
> >> >
> >> >	if ((readl(SAMPLE_AT_RESET) >> 21 & 1) == 0)
> >> >		return 200000000;
> >> >	else
> >> >		return 166666667;
> >> >
> >> >(I don't have the necessary docs, Saeed might have to 
> >answer this one.)
> >>
> >> Lennert, the docs and our reference code shows that the 
> >original code of Simor is correct
> >
> >So what does it mean if bit 21 is 0 on 6180/6192?
> >
> >If [21] == 0 is not supported on 6180/6192 because those parts
> >officially only support 166 MHz TCLK operation, then that doesn't
> >need a test for the part number, I think.
>
> The spec says that bit 21 for 6180 is for internal testing, so lets
> don't assume any thing about it.

OK, I agree.

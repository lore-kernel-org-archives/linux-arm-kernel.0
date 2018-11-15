From: schmitzmic@gmail.com (Michael Schmitz)
Date: Thu, 15 Nov 2018 14:34:22 +1300
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181114075817.GQ30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
 <20181114075817.GQ30658@n2100.armlinux.org.uk>
Message-ID: <b70ae231-19f2-ef7c-f7ca-0a6486d2cb6b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 14/11/18 8:58 PM, Russell King - ARM Linux wrote:
>
>> Are you saying that's not possible on arm, because the current timer rundown
>> counter can't be read while the timer is running?
>>
>> If I were to run a second timer at higher rate for clocksource, but keeping
>> the 10 ms timer as clock event (could easily do that by using timer D on
>> Atari Falcon) - how would that improve my timekeeping? Clock events still
>> only happen 10 ms apart ...
> Ah, I think you're talking about something else.
>
> You seem to be talking about what happens when time keeping interrupts
> happen.
That's what I understood your comment was about.
> I'm talking about the resolution of gettimeofday() and the other
> interfaces that are used (eg) for packet capture timestamping and
> the like - the _user_ visible effects of the timekeeping system.
>
> With the existing implementation, all these have better-than-jiffy
> resolution - in the case of RPC, that's 500ns, rather than 10ms
> which would be the case without gettimeoffset().  Removing
> gettimeoffset() as Finn has proposed without preserving that
> resolution is simply completely unacceptable.

I agree - but Finn had also offered to supply patches to arm that would 
have added a clocksource_read() function very much like for those m68k 
platforms that had used gettimeoffset(). I wondered what reason there 
was for these not to work on arm

I now realize you'd never seen that offer.

The proposal to drop architectures still relying on arch_gettimeoffset() 
had been raising enough of a response on linux-m68k to make me conclude 
that same proposal had been kicked on to other arch MLs affected as 
well. I'm a bit naive that way.

Now your criticism of arch_gettimeoffset() (missing timer rollover 
because the timer interrupt has been cleared by the interrupt handler) 
still stands. I just can't find the offset() functions shown in the 
5cfc8ee0bb51 patch. Any hints?

Cheers,

 ??? Michael

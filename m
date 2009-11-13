From: andy@warmcat.com (Andy Green)
Date: Fri, 13 Nov 2009 12:42:17 +0000
Subject: ARM: big performance waste in memcpy_{from,to}io
In-Reply-To: <20091113122438.GB29008@n2100.arm.linux.org.uk>
References: <200911121749.49676.h.feurstein@gmail.com>	<ol1us6-035.ln1@chipmunk.wormnet.eu>	<200911131232.41716.h.feurstein@gmail.com>
	<20091113122438.GB29008@n2100.arm.linux.org.uk>
Message-ID: <4AFD5429.8000307@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/09 12:24, Somebody in the thread at some point said:
> On Fri, Nov 13, 2009 at 12:32:41PM +0100, Hubert Feurstein wrote:
>> The memcpy_{to,from}io-function don't has to care about the bus-width of the
>> attached peripheral, because this is already handled correctly by the static
>> memory controller of your arm-derivate (Of course this one has to be
>> configured correctly to the peripherals bus width). In the rare case where you
>> have to take care about that it is anyway a bad idea to use a memcpy_xxio-
>> function.
>
> I believe there are SoCs where using 32-bit reads on lesser-width buses
> generate faults.  There are certainly SoCs which do abort reads/writes
> to certain peripherals which aren't the right size.

Not much help to the discussion about memcpy, but I saw an example of 
this death by bus size mismatch is iMX31's internal watchdog.  I failed 
to notice the registers were (unusually) specified to be 16-bit.

Using a u32 * to access the first register, which was 32-bit aligned OK, 
gave an "imprecise external abort" until I read the datasheet closer and 
used a u16 *.

-Andy

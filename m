From: linux@bohmer.net (Remy Bohmer)
Date: Sun, 31 Oct 2010 12:19:38 +0100
Subject: at91: input overruns question
In-Reply-To: <AANLkTimHnxLydJC3u58kAuukjR80EEgRDj7ZEedNMKfd@mail.gmail.com>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
	<AANLkTimHnxLydJC3u58kAuukjR80EEgRDj7ZEedNMKfd@mail.gmail.com>
Message-ID: <AANLkTi=AhMxUjN=0PfW+XKVDJBhok=f4YwpF6bf67Eza@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2010/10/28 Aras Vaichas <arasv@magellan-technology.com>:
> On 26 October 2010 17:19, Aras Vaichas <arasv@magellan-technology.com> wrote:
>> Hi,
>>
>> I'm updating our production kernel to 2.6.33.7-rt29 for an at91rm9200.
>> This is the newest version supported by RT.
>>
>> I've noticed that the age-old debug serial input overrun(s) issue has
>> gotten far worse and I can no longer use the cursor keys at all. i.e.
>> no history on serial console or vi.
>>
>> As the kernel version numbers have gone up, the problem seems to have
>> gotten worse.
>>
>> Is there anything that I can do to make it a bit more usable?
>>
>> Any .config changes?
>
> Configuration settings CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS cause
> the overrun(s) problems to get worse.

Indeed. high-res timers and no-hz have a longer interrupt handling
compared to the old fashioned ticking kernel.

> If I disable these two settings I still get overrun(s) but not quite
> as frequent.

> Can someone explain why these settings would cause the CPU to be
> unable to process 2 serial characters in a row?
> Something must be causing the DBGU serial receive interrupt to stall
> for more than 86us in order to miss a complete 115200 baud serial
> character.

The DBGU has a 1 byte FIFO, thus not a FIFO at all. As you already
mention, the time between 2 interrupts on 115200 baud must be about
86us. On rm9200 the timer interrupt handler itself can cost about 50us
to more than 100usec in itself (measured through ETM
trace), combined with a worst case interrupt latency of about 75us.
This is even worse on a HRT or NOHZ enabled kernel.
So, mathematically you can already prove that it cannot keep up to the
115200 properly.

Enabling DMA for DBGU is no option either since IIRC it would only
generate an interrupt once the DMA buffer is full, not when the first
character arrives in the buffer. Thus not very useful for a terminal.

See for more info about the timer interrupt:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-03/msg01954.html
and
http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-03/pnga98YRFl9x7.png
(ETM trace screendump of the timer interrupt handler)

Kind regards,

Remy

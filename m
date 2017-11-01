From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 1 Nov 2017 19:36:52 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
Message-ID: <20171101193652.602366f7@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > serialized link. Writes get delayed, they can bunch together, busses do
> > posting and queueing.  
> 
> Are you talking about the actual delay operation, or the pokes around it?

All of it. A write from the CPU except on the lowest end ones isn't
neccessarily going to occur in strict sequential order as expressed by
the program. The write even with cache bypassing goes to whatever bus
interface unit is involved and then the signal goes on (eventually) to
the device. The chances are the state machine for the external bus isn't
the same as the internal one and already does things like posting so the
CPU isn't stalled for the write to complete on the slow external bus.

All your bus clocks have errors, even more so if spread spectrum is in
use to reduce the noise. For some bus encoding transferring the data
takes a subtly different amount of time accordig to the value.

The reality for most machines is that writing to a device rather more
resembles one of those games where your ball descends at an unpredictable
rate bouncing off pillars to score points, than is implied by the
diagrams.

> I don't think "accurate" is the proper term.
> Over-delays are fine, under-delays are problematic.

Not often. The people who characterized the silicon will have added a
safety margin to. They are always quoting +/- something if you dig in the
small print or ask.

> > For that matter given the bad blocks don't randomly change why not cache
> > them ?  
> 
> That's a good question, I'll ask the NAND framework maintainer.
> Store them where, by the way? On the NAND chip itself?

I guess the ideal case would be to store it with magic numbers on one of
a certain number of blocks (in case the default one to hold it is itself
a bad block) ?
> 
> >> My current NAND chips are tiny (2 x 512 MB) but with larger chips,
> >> the number of calls to ndelay would climb to 10^6 and the delay
> >> increase to 1 second, with is starting to be a problem.

And this is another reason I think that worrying about ndelay is not the
answer. If you've got multiple threads you can bring it up
asynchronously, if you've got multiple buses (ok you don't) then you can
halve or quarter the time needed. If you've got them cached you can
nearly eliminate it.

Compared with those scraping a few percent by fine tuning ndelay doesn't
look such a good return ?

Alan

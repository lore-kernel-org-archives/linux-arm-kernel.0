From: alan@linux.intel.com (Alan Cox)
Date: Wed, 12 Sep 2012 10:44:20 +0100
Subject: [RFC] tty/serial/kgdboc: Add and wire up clear_irqs callback
In-Reply-To: <20120912040657.GA3880@lizard>
References: <20120911093042.GA12471@lizard>
 <1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
 <20120911151540.362001c6@pyramind.ukuu.org.uk>
 <20120912033209.GA32156@lizard>
 <CAMbhsRTmZyxFE-vAa-UvNE8KJ2f0cfXP7mncXKcpUiNF6C9PUQ@mail.gmail.com>
 <20120912040657.GA3880@lizard>
Message-ID: <20120912104420.06a88957@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Of course, if Alan is OK with this, I'm more than OK too. :-)

It may well be better.

> (But the polling routines would need to clear all interrupts, not
> just rx/tx. For example, if the controller indicated some error, and
> nobody clears it, then we'll start reentering infinitely.)

For a lot of devices and platforms you'd probably mask them instead ?

> 
> > If you use a clear_irqs callback, you can drop characters if
> > one arrives between the last character buffer read and calling
> > clear_irqs.
> 
> Only if we call clear_irqs() after reading the characters, but we do
> it before. So if new characters are available, we will reenter NMI,
> which is OK.

Recursively or not... again you get platform specific magic in places
we don't want.

In the driver poll method for most uarts is going to be at least buried
in what is usually arch specific uarts.

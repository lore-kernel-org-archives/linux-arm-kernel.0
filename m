From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 11:06:03 +0000
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
	<AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
Message-ID: <20110127110603.GA25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 01:53:06PM +0100, Linus Walleij wrote:
> 2011/1/20 Linus Walleij <linus.ml.walleij@gmail.com>:
> > But if the transfer is complete, MCIDataCnt should be valid
> > as well. I'll read the datasheet(s) closer and see if I get some
> > useful clues about which one is more reliable in the error
> > case.
> 
> I've looked into this. It appears AFAICT that the FIFOCNT is
> reset to zero whenever Tx or Rx is not active, i.e. on an error. So
> this register is not helpful for determining the number of blocks
> left at an error, it will always be zero at that point.
> 
> MCIDATACNT on the other hand comes from the datapath
> state machine which in turn controls the FIFO. It is a totally
> separate counter inside the state machine, loaded from the
> same length register, but updated from the datapath control
> machinery.

Something occurs to me - isn't DATACNT a byte counter rather than a word
counter?  I think that's something which needs to be confirmed.  The TRM
is a little confusing:

| Data counter register, MCIDataCnt The MCIDataCnt register loads the value
| from the data length register (see Data length register, MCIDataLength on
| page 3-11) when the DPSM moves from the IDLE state to the WAIT_R or WAIT_S
| state. As data is transferred, the counter decrements the value until it
| reaches 0.

The first sentence implies that the value which appears here initially
is the value which was written to the data length register, which is a
byte count.  The second sentence _could_ be interpreted as it decrementing
by one each time data is transferred to/from the FIFO (which are 32-bit
words).

I think this requires some experimentation...

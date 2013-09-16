From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Sep 2013 00:04:40 +0100
Subject: RFD on DMA_BIT_MASK and LPAE
In-Reply-To: <CAMChaFwWjxUPzqbwXQqkgeaH4gpdanGF80BBvPBzQ+bVxUcL=g@mail.gmail.com>
References: <CAMChaFwWjxUPzqbwXQqkgeaH4gpdanGF80BBvPBzQ+bVxUcL=g@mail.gmail.com>
Message-ID: <20130916230440.GP12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 02:52:28AM +0400, Alexander Tarasikov wrote:
> Hello, linux hackers!
> 
> I've tried enabling LPAE (for the purpose of using KVM on A15) and have
> found out that many drivers break because of the DMA_BIT_MASK. I've found
> some patches and a discussion on the mailing list, but have not found what
> the final verdict on the problem was.

The problem is that Linux insists that system memory will start at physical
address zero.

That is not true on a lot of ARM platforms, especially with LPAE.  This
assumption needs to be fixed.

I have a large patch series which I posted a few months back - now that
-rc1 is out, I will be re-posting it and if it gets mostly ignored again,
I'll drop it into linux-next for more exposure and as a candidiate for
merging at the next window.

Even with LPAE, even with memory all above the 4GB mark, if you have
32-bit DMA controllers a 32-bit DMA mask should _still_ work.

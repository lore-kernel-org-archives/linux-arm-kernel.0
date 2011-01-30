From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 30 Jan 2011 08:48:27 -0800
Subject: [PATCH 2/2] DMA: PL08x: fix channel pausing to timeout rather
	than lockup
In-Reply-To: <20110127123744.GA28855@n2100.arm.linux.org.uk>
References: <20110127123253.GC25968@n2100.arm.linux.org.uk>
	<20110127123744.GA28855@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinF0hfp81n_6jo3bGFVJadtKQUV8vc4Hxn5JSc2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 4:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> If a transfer is initiated from memory to a peripheral, then data is
> fetched and the channel is marked busy. ?This busy status persists until
> the HALT bit is set and the queued data has been transfered to the
> peripheral. ?Waiting indefinitely after setting the HALT bit results in
> system lockups. ?Timeout this operation, and print an error when this
> happens.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This happens when a M->P transfer is started, but the peripheral doesn't
> take the data. ?The DMA controller will mark itself active and fetch data
> from memory, in anticipation of the peripheral wanting the data. ?This
> advances the source address.
>
> An alternative approach here is to just set the HALT bit and return
> immediately, without waiting for the primecell to show that it is no
> longer active. ?In any case, resuming the channel will allow the
> transfer to continue without data loss.
>

Ok, and the other infinite busy wait in pl08x_start_txd() is
guaranteed to be after a resume operation, or does it also need a
timeout?

--
Dan

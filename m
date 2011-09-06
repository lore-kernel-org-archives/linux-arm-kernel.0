From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Sep 2011 15:48:51 +0100
Subject: [PATCH 2/3] define ARM-specific dma_coherent_write_sync
In-Reply-To: <1315319837.2313.1.camel@deneb.redhat.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-3-git-send-email-msalter@redhat.com>
	<CAHkRjk7ZMDQh8sYf7N_4LLS12JU2ps8dkC34gNWNH+-Zp0p8Rg@mail.gmail.com>
	<1315319837.2313.1.camel@deneb.redhat.com>
Message-ID: <CAHkRjk6TD4Qg-b3nkCE_wwj-tWr-_5evndxo3f+_6gtXEV6gNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2011 15:37, Mark Salter <msalter@redhat.com> wrote:
> On Tue, 2011-09-06 at 15:32 +0100, Catalin Marinas wrote:
>> That's what mb() and wmb() do already, at least on ARM. Why do we need
>> another API? IIRC from past discussions on linux-arch around barriers,
>> the mb() should be sufficient in the case of DMA coherent buffers.
>> That's why macros like writel() on ARM have the mb() added by default
>> (for cases where you start the DMA transfer by writing to a device
>> register).
>
> For USB EHCI, the driver does not necessarily write to a register after
> writing to DMA coherent memory. In some cases, the controller polls for
> information written by the driver.

So as I understand, you would like to force the eviction from the
write buffer rather than waiting for it to be drained. On ARM, the
write buffer is eventually flushed, so there is no strict timing
guarantee. It could take longer if the processor immediately starts
polling some memory location for example, but in this case a simple
barrier would do.

-- 
Catalin

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Aug 2014 15:47:51 +0200
Subject: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC
 hardware descriptor list support)
In-Reply-To: <20140801143020.GQ30282@n2100.arm.linux.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <28702317.aD0C1Ga3DS@avalon> <20140724045248.GB8181@intel.com>
 <18522523.T2zy7HfoJ2@avalon>
 <20140801143020.GQ30282@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdWSe8m2yRV5fhLfZ=gbGUev6ExD+0eQ_nKK84SRs1DEwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Aug 1, 2014 at 4:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Aug 01, 2014 at 10:51:26AM +0200, Laurent Pinchart wrote:
>> I'll take this opportunity to question why we have a separation between
>> tx_submit and issue_pending. What's the rationale for that, especially given
>> that dma_issue_pending_all() might kick in at any point and issue pending
>> transfers for all devices. A driver could thus see its submitted but not
>> issued transactions being issued before it explicitly calls
>> dma_async_issue_pending().
>
> A prepared but not submitted transaction is not a pending transaction.
>
> The split is necessary so that a callback can be attached to the
> transaction.  This partially comes from the async-tx API, and also
> gets a lot of use with the slave API.
>
> The prepare function allocates the descriptor and does the initial
> setup, but does not mark the descriptor as a pending transaction.
> It returns the descriptor, and the caller is then free to add a
> callback function and data pointer to the descriptor before finally
> submitting it.  This sequence must occur in a timely manner as some
> DMA engine implementations hold a lock between the prepare and submit
> callbacks (Dan explicitly permits this as part of the API.)

I think you misunderstood the question: Laurent asked about
dmaengine_submit() (step 2) and dma_async_issue_pending() (step 3),
while your answer is about dmaengine_prep_slave_*() (step 1) and
dmaengine_submit() (step 2).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

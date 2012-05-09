From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 11:27:17 +0200
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120502162702.GE3548@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 6:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> > What is the desired behaviour of the callback for cyclic DMA?
>>
>> Typically cyclic DMA is used in the case of sound. This is where alsa
>> expects the "period" callback for every DMA period.
>> Generally, such notification serves the purpose of letting client know
>> that one "block" has been completed.
>
> Yes, though as we have this interface as something generic I didn't want
> to call it "the alsa dma interface".

There is a DMAengine helper in ALSA SoC these days,
sound/soc/soc-dmaengine-pcm.c which does not yet include
get position calls, but I expect that's where the ALSA glue will
end up.

>> From what I understand (Dan please correct me as you may know this much
>> better than me), the tx_status tells you wrt passed cookie what is the
>> status. Further, (as you pointed), it also tells you which is last
>> completed cookie and what is the current "running". And wrt the
>> currently "running" cookie it tells you how may bytes are left.
>
> That means we have a number of buggy drivers on both sides of the API...
> PL08x for example always total up all the pending bytes from the position
> in the current descriptor to the last issued descriptor. ?Many other
> implementations simply always return zero.

My bad, when I implemented it, I imagined the semantic to be
the residue on the *channel* which is not smart, it's better to use
the cookie as reference, so patch at will.

>> IIRC had pointed Lars to this API, but quick check of code reveals that
>> this is unused. I think returning residue as remaining bytes of current
>> "block" makes sense. This easily gives knowledge of where DMA pointer is
>> wrt current ongoing transaction. Was that your meaning of end of cyclic
>> buffer, not sure what end means here?
>
> I think the residue thing was something Linus created, which is why he's
> included in this thread...

Lars-Peter Clausen is the person writing the ALSA SoC wrapper.
Lars-Peter: do you have plans to implement residue calls for
getting buffer position?

It was originally created to be able to use DMA for ALSA SoC on
the U300. I still don't know if there is some other viable usecase
but I expect that things like multimedia codecs would use a DMA
engine much the same way.

Yours,
Linus Walleij

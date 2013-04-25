From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 10:55:46 +0200
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <201304251036.52284.arnd@arndb.de>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
 <201304251036.52284.arnd@arndb.de>
Message-ID: <CACRpkdY96CKOtE6ByMuz_RAkyOY44RSrfz6Z3OFV6pcFTK3KwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 10:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 25 April 2013, Linus Walleij wrote:
>> Are we now sacrificing that ability on the altar of simplification?
>>
>> I actually think not, but that we should do periph-to-periph transfers
>> in some other way, and that the .dir attribute should go away from
>> the struct stedma40_chan_cfg as well but I'm not entirely sure.
>> Someone else?
>
> The dma-engine core has no support for device-to-device transfers,

It has this: DMA_DEV_TO_DEV (enum dma_transfer_direction)
so it has been thought of. Alas, it is unused for now.

> and as far as I understand that is neither considered a useful
> feature in real life, nor easy to add, so I don't think it matters
> much here.

It is a very useful feature in real life, we used that for PCM transfer
in U300. (I have heard this from other handset vendors too, so it
is a common thing.)

Consider a high-speed on-chip link from a
modem providing audio in (telephony) from the microphone in
one endpoint and audio out on another endpoint.

We just set that up so we connect a hose from the modem
RX to the PCM sink (D/A-codec) and vice versa as long as
the phone conversation is on.

This gives outstanding power performance since the CPU itself
can actually sleep during the enture voicecall, only the DMA
engine if awake.

We just never got around to modifying the DMAengine framework
to support this and integrate it... it is bound to come back to us,
especially with things like ever more accelerators on chips that
provide such autonomous data streams. (I think.)

Yours,
Linus Walleij

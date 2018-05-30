From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 16:44:28 -0500
Subject: [PATCH v2] spi: bcm2835aux: ensure interrupts are enabled for
 shared handler
In-Reply-To: <87sh69nelw.fsf@anholt.net>
References: <20180523205220.7394-1-robh@kernel.org> <87sh69nelw.fsf@anholt.net>
Message-ID: <CAL_JsqLxG3TH9=tkxMevKnEKceQYJWg4x9Oeup7YmpS-YSBCkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 2:11 PM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
>> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
>> DT change which breaks compatibility with older kernels. The AUX irqchip
>> was already rejected for upstream[1] and the DT change would break
>> working systems if the DTB is updated to a newer one. The latter issue
>> was brought to my attention by Alex Graf.
>>
>> The root cause however is a bug in the shared handler. A shared handler
>> must correctly identify it actually handled an interrupt. The handler
>> here was processing data whether interrupts were enabled or not.
>> It would return IRQ_HANDLED if there was any data and not only when
>> there was an actual interrupt pending. The result is that another
>> device's IRQ could cause the SPI's IRQ handler to run and process data
>> when the the SPI driver working in polled mode. Fix this by adding a
>> check in the IRQ handler that the TXEMPTY or IDLE interrupts are enabled
>> and always return IRQ_NONE when they are not.
>
> FWIW, I see v1 already applied in -next.

Sigh, indeed. I thought I had checked that. Though Mark had comments
on the commit msg, so I assumed he wanted changes. The automated
applied emails just get lost in my inbox. It would be nice if they
kept the subject instead of adding 'Applied "...' so gmail would group
them. Of course, it would be nice if gmail could honor threading too.

Rob

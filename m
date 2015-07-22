From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 22 Jul 2015 09:30:54 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <20150722044925.GN23525@localhost>
References: <cover.1433364398.git.hramrach@gmail.com>
 <20150604171547.GA1530@localhost.localdomain>
 <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
 <201507151352.27689.marex@denx.de> <20150715155946.GB21362@localhost>
 <CAOMqctTJEg7EauKfrqW-6rUQ-QOmtkTfkgOyz0rCuyh_-XrW5w@mail.gmail.com>
 <20150721042932.GF23525@localhost>
 <CAOMqctSzzUV1J8Vj03XJ3Y70R9ynVErP4RZVtbjarDcZ9JLnaw@mail.gmail.com>
 <20150722044925.GN23525@localhost>
Message-ID: <CAOMqctQH4MnKMthOnuPgB-A5k6PCOAmhwHzJfn7gE3R4w8bufg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2015 at 06:49, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Jul 21, 2015 at 10:14:11AM +0200, Michal Suchanek wrote:
>> > Or alternatively we could publish the limitations of the channel using
>> > capabilities so SPI knows I have a dmaengine channel and it can transfer max N
>> > length transfers so would be able to break rather than guessing it or coding
>> > in DT. Yes it may come from DT but that should be dmaengine driver rather
>> > than client driver :)
>> >
>> > This can be done by dma_get_slave_caps(chan, &caps)
>> >
>> > And we add max_length as one more parameter to existing set
>> >
>> > Also all this could be handled in generic SPI-dmaengine layer so that
>> > individual drivers don't have to code it in
>> >
>> > Let me know if this idea is okay, I can push the dmaengine bits...
>>
>> It would be ok if there was a fixed limit. However, the limit depends
>> on SPI slave settings. Presumably for other buses using the dmaengine
>> the limit would depend on the bus or slave settings as well. I do not
>> see a sane way of passing this all the way to the dmaengine driver.
> I don't see why this should be client (SPI) dependent. The max length
> supported is a dmaengine constraint, typically flowing from max
> blocks/length it can transfer. Know this limit can allow clients to split
> transfers.

In practice on the board I have the maximum transfer length before it
fails depends on SPI bus speed which is set up per slave. I did not
try searching the space of possible settings thorougly and settled for
a setting that gives reasonable speed and transfer length.

However, if this was not tied to the particular slave setting picked
in the current DT a formula would be needed that translates arbitrary
client settings to transfer size limit and there would be need to
somehow get the client settings to the formula in the dmaengine
driver.

Thanks

Michal

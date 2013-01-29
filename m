From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 16:19:14 +0530
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301291035.30265.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
 <201301291035.30265.arnd@arndb.de>
Message-ID: <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2013 16:05, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 January 2013, Viresh Kumar wrote:

>> Shouldn't this be 4? Would be better to mention what fields are these,
>> right here. I have seen them below though.
>
> Correct. I changed these a couple of times while trying to understand
> what the fields are, and I missed this instance. I'm still not sure
> whether we actually need all four fields, or what the simplest format
> for them would be. This just mirrors what you had in your binding.

You can add request_line number and leave first two fields, cfghi and lo.

>> > +       /* FIXME: memory leak! could we put this into dw_dma_chan? */
>> > +       sd = devm_kzalloc(dw->dma.dev, sizeof (*sd), GFP_KERNEL);
>>
>> Yes.
>
> Yes it can be in dw_dma_chan or yes it is a memory leak?

Yes it can be in dw_dma_chan :)

>> > +       if (dma_spec->args_count != 4)
>>
>> args_count contains count of all params leaving the phandle?
>
> That was my interpretation from reading the code, but I have not tried it.

Okay, it was just a question from my side :)

>> > +       /* FIXME: This binding is rather clumsy. Can't we use the
>> > +          request line numbers here instead? */
>>
>> yes.
>
> Ok, Very good. What is the encoding of the registers then?

You can still keep fargs as is and just fill them as:

       fargs.cfg_lo = 0;

if (DMA_TO_DEV)
       // dest is periph
       fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
else if (DEV_TO_DMA)
       // src is periph
       fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;

The field size is 4 bits.

> Thanks a lot for the input. When I fix the above, are actually able
> to test the changes, or have you lost access to the hardware when
> leaving ST?

I don't have any sort of access for testing these :(
But, Vipul might try these at his end.

From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 17 Apr 2018 17:53:51 +0300
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
Message-ID: <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-17 16:58, Lars-Peter Clausen wrote:
>>> There are two options.
>>>
>>> Either you extend the generic interfaces so it can cover your usecase in a
>>> generic way. E.g. the ability to attach meta data to transfer.
>>
>> Fwiw I have this patch as part of a bigger work to achieve similar results:
> 
> That's good stuff. Is this in a public tree somewhere?

Not atm. I can not send the user of the new API and I did not wanted to
send something like this out of the blue w/o context.

But as it is a generic patch, I can send it as well. The only thing is
that the need for the memcpy, so I might end up with
ptr = get_metadata_ptr(desc, &size); /* size: in RX the valid size */

and set_metadata_size(); /* in TX to tell how the client placed */

Or something like that, the attach_metadata() as it is works just fine,
but high throughput might not like the memcpy.

>>> Or you can implement a interface that is specific to your DMA controller and
>>> any client using this interface knows it is talking to your DMA controller.
>>
>> Hrm, so we can have DMA driver specific calls? The reason why TI's keystone 2
>> navigator DMA support was rejected that it was introducing NAV specific calls
>> for clients to configure features not yet supported by the framework.
> 
> In my opinion it is OK, somebody else might have different ideas. I mean it
> is not nice, but it is better than the alternative of overloading the
> generic API with driver specific semantics or introducing some kind of IOCTL
> catch all callback.

True, but the generic API can be extended as well to cover new grounds,
features. Like this metadata thing.

> If there is tight coupling between the DMA core and client and there is no
> intention of using a generic client the best solution might even be to no
> use DMAengine at all.

This is how the knav stuff ended up. Well it is only used by networking
atm, so it is 'fine' to have custom API, but it is not portable.

> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 15 Aug 2010 15:42:28 +0200
Subject: [PATCH 3/3] ARM: S3C64XX: Stop and flush requests on freeing
In-Reply-To: <AANLkTinC-mmdrhbGRsuuWVHTeFGCf2E6PMEU3tFOv3Ts@mail.gmail.com>
References: <4c67e6b3.487e0e0a.0a1b.22d7@mx.google.com>	<AANLkTimvW3KM6k5grpXXoZw1Z64J1OtZkqpCavPApbsn@mail.gmail.com>
	<AANLkTinC-mmdrhbGRsuuWVHTeFGCf2E6PMEU3tFOv3Ts@mail.gmail.com>
Message-ID: <4C67EEC4.3040001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 15-08-10 15:36, Jassi Brar schreef:
> On Sun, Aug 15, 2010 at 10:28 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Mon, May 31, 2010 at 8:34 PM, Maurus Cuelenaere
>> <mcuelenaere@gmail.com> wrote:
>>> When a DMA channel is freed, its pending requests should be flushed and the
>>> channel should be halted. This patch ensures that happens.
>>>
>>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
>>> ---
>>>  arch/arm/mach-s3c64xx/dma.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
>>> index 1fd9d0c..e1f22af 100644
>>> --- a/arch/arm/mach-s3c64xx/dma.c
>>> +++ b/arch/arm/mach-s3c64xx/dma.c
>>> @@ -560,7 +560,8 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
>>>                       channel, chan->client, client);
>>>        }
>>>
>>> -       /* sort out stopping and freeing the channel */
>>> +       s3c64xx_dma_flush(chan);
>>> +       s3c64xx_dma_stop(chan);
>> I think, the order should be reverted.

You're probably right.

> Though it's a matter of S3C DMA API spec.
> Shouldn't the client be made to explicitly do S3C2410_DMAOP_FLUSH
> a pending req before freeing the channel? If so, the patch may not be needed.

I can't find anything about the client needing to flush the request itself.

Documentation/arm/Samsung-S3C24XX/DMA.txt doesn't mention anything regarding it
and the comment above s3c2410_dma_free() says "release the given channel back to
the system, will stop and flush any outstanding transfers, and ensure the
channel is ready for the next claimant."


-- 
Maurus Cuelenaere

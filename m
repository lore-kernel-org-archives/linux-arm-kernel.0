From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 6 Jul 2011 12:05:18 +0530
Subject: [PATCH] ARM:SAMSUNG: DMA Cleanup as per sparse
In-Reply-To: <00c001cc3ba3$34558670$9d009350$%kim@samsung.com>
References: <1309428980-20176-1-git-send-email-sangwook.lee@linaro.org>
	<00c001cc3ba3$34558670$9d009350$%kim@samsung.com>
Message-ID: <CABb+yY219tLKj=zd7U=C=VFzWxia+vukEG12hw6tvwGYve6fXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 11:38 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kukjin Kim wrote:
>>
>> Sangwook Lee wrote:
>> >
>> > Function declaration differs between file:s3c-pl330.c and file:dma.h
>> > and SPARSE (Documentation/sparse.txt) gives error messages
>> >
>> > Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
>> > ---
>> > ?arch/arm/plat-samsung/include/plat/dma.h | ? 16 ++++++++--------
>> > ?1 files changed, 8 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-
>> > samsung/include/plat/dma.h
>> > index 2e8f8c6..7365f46 100644
>> > --- a/arch/arm/plat-samsung/include/plat/dma.h
>> > +++ b/arch/arm/plat-samsung/include/plat/dma.h
>> > @@ -62,7 +62,7 @@ typedef int ?(*s3c2410_dma_opfn_t)(struct
>> > s3c2410_dma_chan *,
>> > ? * request a dma channel exclusivley
>> > ?*/
>> >
>> > -extern int s3c2410_dma_request(unsigned int channel,
>> > +extern int s3c2410_dma_request(enum dma_ch id,
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct s3c2410_dma_client *, void *dev);
>> >
>> >
>> > @@ -71,14 +71,14 @@ extern int s3c2410_dma_request(unsigned int channel,
>> > ? * change the state of the dma channel
>> > ?*/
>> >
>> > -extern int s3c2410_dma_ctrl(unsigned int channel, enum s3c2410_chan_op
> op);
>> > +extern int s3c2410_dma_ctrl(enum dma_ch id, enum s3c2410_chan_op op);
>> >
>> > ?/* s3c2410_dma_setflags
>> > ? *
>> > ? * set the channel's flags to a given state
>> > ?*/
>> >
>> > -extern int s3c2410_dma_setflags(unsigned int channel,
>> > +extern int s3c2410_dma_setflags(enum dma_ch id,
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int flags);
>> >
>> > ?/* s3c2410_dma_free
>> > @@ -86,7 +86,7 @@ extern int s3c2410_dma_setflags(unsigned int channel,
>> > ? * free the dma channel (will also abort any outstanding operations)
>> > ?*/
>> >
>> > -extern int s3c2410_dma_free(unsigned int channel, struct
> s3c2410_dma_client *);
>> > +extern int s3c2410_dma_free(enum dma_ch id, struct s3c2410_dma_client
> *);
>> >
>> > ?/* s3c2410_dma_enqueue
>> > ? *
>> > @@ -95,7 +95,7 @@ extern int s3c2410_dma_free(unsigned int channel,
> struct
>> > s3c2410_dma_client *);
>> > ? * drained before the buffer is given to the DMA system.
>> > ?*/
>> >
>> > -extern int s3c2410_dma_enqueue(unsigned int channel, void *id,
>> > +extern int s3c2410_dma_enqueue(enum dma_ch idx, void *id,
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ?dma_addr_t data, int size);
>> >
>> > ?/* s3c2410_dma_config
>> > @@ -103,14 +103,14 @@ extern int s3c2410_dma_enqueue(unsigned int
> channel,
>> > void *id,
>> > ? * configure the dma channel
>> > ?*/
>> >
>> > -extern int s3c2410_dma_config(unsigned int channel, int xferunit);
>> > +extern int s3c2410_dma_config(enum dma_ch id, int xferunit);
>> >
>> > ?/* s3c2410_dma_devconfig
>> > ? *
>> > ? * configure the device we're talking to
>> > ?*/
>> >
>> > -extern int s3c2410_dma_devconfig(unsigned int channel,
>> > +extern int s3c2410_dma_devconfig(enum dma_ch id,
>> > ? ? ? ? ? ? enum s3c2410_dmasrc source, unsigned long devaddr);
>> >
>> > ?/* s3c2410_dma_getposition
>> > @@ -118,7 +118,7 @@ extern int s3c2410_dma_devconfig(unsigned int
> channel,
>> > ? * get the position that the dma transfer is currently at
>> > ?*/
>> >
>> > -extern int s3c2410_dma_getposition(unsigned int channel,
>> > +extern int s3c2410_dma_getposition(enum dma_ch id,
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dma_addr_t *src, dma_addr_t *dest);
>> >
>> > ?extern int s3c2410_dma_set_opfn(unsigned int, s3c2410_dma_opfn_t rtn);
>> > --
>
> Hi Sangwook Lee,
>
> I reverted this in my -fix tree just now because this makes following error
> with s3c2410_defconfig.

Sangwook's patch does the right thing.
IMO another patch to fix the following issues is needed.

>
> arch/arm/plat-samsung/include/plat/dma.h:66: warning: 'enum dma_ch' declared
> inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:66: warning: its scope is only this
> definition or declaration, which is probably not what you want
> arch/arm/plat-samsung/include/plat/dma.h:74: warning: 'enum dma_ch' declared
> inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:82: warning: 'enum dma_ch' declared
> inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:89: warning: 'enum dma_ch' declared
> inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:99: warning: 'enum dma_ch' declared
> inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:106: warning: 'enum dma_ch'
> declared inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:114: warning: 'enum dma_ch'
> declared inside parameter list
> arch/arm/plat-samsung/include/plat/dma.h:122: warning: 'enum dma_ch'
> declared inside parameter list
> drivers/mmc/host/s3cmci.c: In function 'finalize_request':
> drivers/mmc/host/s3cmci.c:889: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c: In function 's3cmci_dma_setup':
> drivers/mmc/host/s3cmci.c:927: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:930: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:933: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c: In function 's3cmci_prepare_dma':
> drivers/mmc/host/s3cmci.c:1091: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:1111: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:1114: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:1119: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c: In function 's3cmci_probe':
> drivers/mmc/host/s3cmci.c:1692: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c:1778: error: type of formal parameter 1 is
> incomplete
> drivers/mmc/host/s3cmci.c: In function 's3cmci_remove':
> drivers/mmc/host/s3cmci.c:1840: error: type of formal parameter 1 is
> incomplete
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

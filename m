From: kassey1216@gmail.com (Kassey Lee)
Date: Tue, 10 Apr 2012 18:42:49 +0800
Subject: questions about drivers/dma/amba-pl08x.c
In-Reply-To: <CACRpkdaC3=vSGF6XH=7Oiqsdg0RVDfbv-M5NZDY5psF96BssHQ@mail.gmail.com>
References: <CAKwPUozgACvV-TZdn92f1O2shSEvFBfbN-hrS=FNQ5O+DEEY5g@mail.gmail.com>
 <CACRpkdaC3=vSGF6XH=7Oiqsdg0RVDfbv-M5NZDY5psF96BssHQ@mail.gmail.com>
Message-ID: <CAKwPUoy6ooNbKDb=gbS_jAZuaA7SteGP+RVEhoeCK-eLKoqamw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Linus, Walleij:
        thanks for your answer! is this you meaning?

Subject: [PATCH] dmaengine/amba-pl08x: check slave_channels to avoid kernel
 panic

slave_channels is platform dependent, it should
be initialized by board.c, and here we need to check it
to avoid a NULL panic.

Signed-off-by: Kassey,Lee <kassey1216@gmail.com>
---
 drivers/dma/amba-pl08x.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c301a8e..b558ea6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1687,6 +1687,13 @@ static int
pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
                chan->state = PL08X_CHAN_IDLE;

                if (slave) {
+                       if (!pl08x->pd->slave_channels) {
+                               dev_err(&pl08x->adev->dev,
+                                       "%s slave_channels is
+                                                not initialized\n", __func__);
+                               kfree(chan);
+                               return -EFAULT;
+                       }
                        chan->cd = &pl08x->pd->slave_channels[i];
                        pl08x_dma_slave_init(chan);
                } else {
--
1.7.5.4

2012/4/10 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Apr 10, 2012 at 9:30 AM, Kassey Lee <kassey1216@gmail.com> wrote:
>
>> ? ? ? ? ? ? 1) how to add the devices resource for this driver ? i
>> did not find any info in the kernel but this driver.
>
> There are pending patches fore RealView for this driver.
> http://marc.info/?l=linux-arm-kernel&m=128568461506103&w=2
>
> (Yes I know I should finish this patch set...)
>
> Hm, Viresh have you posted your platform code for PL080 on
> SPEAr?
>
>> ? ? ? ? ? ? 2) in the below function, if the slave is set true,
>> kernel will panic, because slave_channels is NULL, and nobody
>> initialize this member, should this member be initialized by vendor ?
>>
>>
>> static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
>> ? ? ? ? ? ? ? ?struct dma_device *dmadev, unsigned int channels, bool slave)
>> {
>> ? ? ? ?struct pl08x_dma_chan *chan;
>> ? ? ? ?int i;
>>
>> ? ? ? ?INIT_LIST_HEAD(&dmadev->channels);
>>
>> ? ? ? ?/*
>> ? ? ? ? * Register as many many memcpy as we have physical channels,
>> ? ? ? ? * we won't always be able to use all but the code will have
>> ? ? ? ? * to cope with that situation.
>> ? ? ? ? */
>> ? ? ? ?for (i = 0; i < channels; i++) {
>> ? ? ? ? ? ? ? ?chan = kzalloc(sizeof(*chan), GFP_KERNEL);
>> ? ? ? ? ? ? ? ?if (!chan) {
>> ? ? ? ? ? ? ? ? ? ? ? ?dev_err(&pl08x->adev->dev,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"%s no memory for channel\n", __func__);
>> ? ? ? ? ? ? ? ? ? ? ? ?return -ENOMEM;
>> ? ? ? ? ? ? ? ?}
>>
>> ? ? ? ? ? ? ? ?chan->host = pl08x;
>> ? ? ? ? ? ? ? ?chan->state = PL08X_CHAN_IDLE;
>>
>> ? ? ? ? ? ? ? ?if (slave) {
>> ? ? ? ? ? ? ? ? ? ? ? ?chan->cd = &pl08x->pd->slave_channels[i];
>> ? ? ? ? ? ? ? ? ? ? ? ?pl08x_dma_slave_init(chan);
>> ? ? ? ? ? ? ? ?} else {
>>
>
> Sorry, I'm not following, so slave is true and there is still no slave
> channels defined? It looks like your platform data is wrong.
>
> But better error checking is always needed so if you want to,
> please send a patch to improve it...
>
> Yours,
> Linus Walleij



-- 
Best regards
Kassey

From: kassey1216@gmail.com (Kassey Lee)
Date: Tue, 10 Apr 2012 15:30:58 +0800
Subject: questions about drivers/dma/amba-pl08x.c
Message-ID: <CAKwPUozgACvV-TZdn92f1O2shSEvFBfbN-hrS=FNQ5O+DEEY5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Linus, Walleij:

             I found the dma controller driver for amba-pl08x.
             may i have two questions for you ? Thank you very much!

             1) how to add the devices resource for this driver ? i
did not find any info in the kernel but this driver.
             2) in the below function, if the slave is set true,
kernel will panic, because slave_channels is NULL, and nobody
initialize this member, should this member be initialized by vendor ?


static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
                struct dma_device *dmadev, unsigned int channels, bool slave)
{
        struct pl08x_dma_chan *chan;
        int i;

        INIT_LIST_HEAD(&dmadev->channels);

        /*
         * Register as many many memcpy as we have physical channels,
         * we won't always be able to use all but the code will have
         * to cope with that situation.
         */
        for (i = 0; i < channels; i++) {
                chan = kzalloc(sizeof(*chan), GFP_KERNEL);
                if (!chan) {
                        dev_err(&pl08x->adev->dev,
                                "%s no memory for channel\n", __func__);
                        return -ENOMEM;
                }

                chan->host = pl08x;
                chan->state = PL08X_CHAN_IDLE;

                if (slave) {
                        chan->cd = &pl08x->pd->slave_channels[i];
                        pl08x_dma_slave_init(chan);
                } else {

-- 
Best regards
Kassey

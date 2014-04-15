From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 09:43:24 +0800
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <20140414200628.GX25182@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
Message-ID: <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-15 4:06 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, Apr 14, 2014 at 02:30:01PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> sometimes t->tx can be equal with t->rx. for example, spidev will make
>> tx and rx point to spidev->buffer at the same time. currently, for this
>> case, we map the buffer BIDIRECTION to fix the cache consistency.
>
> I've applied this but such usage is out of spec - do we have any drivers
> doing this in mainline?

i felt strange too at the first look from internal gerrit. qipan told
me there is one:
drivers/spi/spidev.c

static int spidev_message(struct spidev_data *spidev,
                struct spi_ioc_transfer *u_xfers, unsigned n_xfers)
{
buf = spidev->buffer;
..
k_tmp->rx_buf = buf;
...
k_tmp->tx_buf = buf;
...
spi_message_add_tail(k_tmp, &msg);

spidev_sync(spidev, &msg);
}

-barry

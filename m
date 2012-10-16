From: vasanthananthan@gmail.com (Vasanth Ananthan)
Date: Tue, 16 Oct 2012 12:03:47 +0530
Subject: [PATCH 6/6] ARM: EXYNOS5: SATA PHY controller driver
In-Reply-To: <10179968.slaZyPIETn@flatron>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
 <1349783332-18467-7-git-send-email-vasanthananthan@gmail.com>
 <10179968.slaZyPIETn@flatron>
Message-ID: <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Sat, Oct 13, 2012 at 4:20 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi,
>
> On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:
>> This patch adds a platform driver and I2C client driver for SATA PHY
>> controller
>>
>> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
>> ---
>>  drivers/ata/Makefile          |    2 +-
>>  drivers/ata/sata_exynos_phy.c |  303
>> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304
>> insertions(+), 1 deletions(-)
>>  create mode 100644 drivers/ata/sata_exynos_phy.c
>>
[ ... ]
>> +
>> +     phy->init = sataphy_init;
>> +     phy->shutdown = sataphy_shutdown;
>> +     phy->priv_data = (void *)sataphy;
>> +     phy->dev = &pdev->dev;
>> +
>> +     ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
>> +     if (ret < 0)
>> +             goto err4;
>
> Do you have any warranties that phy callbacks won't get called before i2c
> device probes and sets i2c_client?
>
>> +
>> +     ret = i2c_add_driver(&sataphy_i2c_driver);
>> +     if (ret < 0)
>> +             goto err5;
>> +
>> +     platform_set_drvdata(pdev, phy);

I shall register my i2c client driver before assigning the SATA PHY
call backs. Would that guarantee the calling of phy callbacks after
the i2c device probes?

--
Vasanth Ananthan

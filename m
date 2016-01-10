From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 10 Jan 2016 08:14:11 -0500
Subject: [PATCH V11 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <CAHp75Vd49-1H+1dkDmJzLpVhov1g+uJV+YiTBC9Xd3hVTmwRVg@mail.gmail.com>
References: <1451865996-12808-1-git-send-email-okaya@codeaurora.org>
 <1451865996-12808-4-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd49-1H+1dkDmJzLpVhov1g+uJV+YiTBC9Xd3hVTmwRVg@mail.gmail.com>
Message-ID: <56925923.6080007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +
>> +static int set_priority(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
>> +{
>> +       u64 tmp;
>> +       int rc;
>> +
>> +       if (i > mdev->dma_channels)
> 
> Shouldn't be >= ? I somehow missed that.
>
Corrected.

 
>> +               return -EINVAL;
>> +
>> +       tmp = mdev->priority[i];
>> +       mdev->priority[i] = val;
>> +       rc = hidma_mgmt_setup(mdev);
>> +       if (rc)
>> +               mdev->priority[i] = tmp;
>> +       return rc;
>> +}
>> +
>> +static int set_weight(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
>> +{
>> +       u64 tmp;
>> +       int rc;
>> +
>> +       if (i > mdev->dma_channels)
> 
> Ditto.
OK

> 
>> +               return -EINVAL;
>> +
>> +       tmp = mdev->weight[i];
>> +       mdev->weight[i] = val;
>> +       rc = hidma_mgmt_setup(mdev);
>> +       if (rc)
>> +               mdev->weight[i] = tmp;
>> +       return rc;
>> +}
>> +

>> +
>> +int hidma_mgmt_init_sys(struct hidma_mgmt_dev *mdev)
>> +{
>> +       unsigned int i;
>> +       int rc;
>> +       int required;
>> +       struct kobject *chanops;
>> +
>> +       required = sizeof(*mdev->chroots) * mdev->dma_channels;
>> +       mdev->chroots = devm_kmalloc(&mdev->pdev->dev, required, GFP_KERNEL);
>> +       if (!mdev->chroots)
>> +               return -ENOMEM;
>> +
>> +       chanops = kobject_create_and_add("chanops", &mdev->pdev->dev.kobj);
>> +       if (!chanops)
>> +               return -ENOMEM;
>> +
>> +       /* create each channel directory here */
>> +       for (i = 0; i < mdev->dma_channels; i++) {
>> +               char name[10];
> 
> I would make this bigger just in case i comes bigger by some reason.
> 16 or 20 looks reasonable.
> 
made 20



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

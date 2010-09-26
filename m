From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 00:04:01 +0100
Subject: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP@mail.gmail.com>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org>
	<AANLkTimHQ=ag5z+SKbGrm5BD-eF+xcDuKp4R_=4tf3cP@mail.gmail.com>
Message-ID: <4C9FD161.2000606@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/10 20:01, Sundar wrote:
> Hi Kenneth,
> 
> just some error codes and leaks if I am right :)
> 
> On Wed, Sep 8, 2010 at 6:29 AM, Kenneth Heitke <kheitke@codeaurora.org> wrote:
>> +
>> +static int __devinit
>> +qup_i2c_probe(struct platform_device *pdev)
>> +{
>> +
>> +       qup_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +                                               "qup_phys_addr");
>> +       if (!qup_mem) {
>> +               dev_err(&pdev->dev, "no qup mem resource?\n");
>> +               return -ENODEV;
> 
> I think this should be -ENXIO instead of -ENODEV?

I think both are inappropriate here, -ENXIO is an IO failure
and -ENODEV is 'device is not here'. However, some people don't
like the use of things like -ENOENT (filesystem errors) for this
sort of situation. ENOTSUP might be something you could use.

As a note, both ENXIO and ENODEV will be taken by the device
framework as a device is not there at-all and not display any
error to the user (which is annoying if you then forget to
do anything about it)

As a note, you may want to have a look at devres to offload the
tracking of the requested and mapped resources.

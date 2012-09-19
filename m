From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Sep 2012 09:28:04 -0600
Subject: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
In-Reply-To: <50591C9C.2080809@atmel.com>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
 <50588A8F.30203@wwwdotorg.org> <50591C9C.2080809@atmel.com>
Message-ID: <5059E484.6090708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2012 07:15 PM, Bo Shen wrote:
> Hi Stephen Warren,
> 
> On 9/18/2012 22:51, Stephen Warren wrote:
>> On 09/18/2012 03:02 AM, Bo Shen wrote:
>>> When i2c-gpio node number is greater than 1, the second can not
>>> sucessfully
>>> regiter
>>>
>>> Using alias method to get the pdev->id, or else the second device
>>> will use
>>> the same id which will cause fail to register
>>
>> pdev->id shouldn't be used at all with device tree. Why does
>> registration fail without this change?
> 
> I add the debug info, and it give the following error without this patch.
> 
> --<8----------------------------------
> adap->name = i2c-gpio-1
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c-gpio-1
> i2c-gpio: probe of i2c.3 failed with error -16
> -->8----------------------------------
> 
> With this patch, it successfully registered.
> --<8----------------------------------
> adap->name = i2c-gpio0
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name = i2c-gpio1
> i2c-gpio i2c.3: using pins 90 (SDA) and 91 (SCL)
> -->8----------------------------------

Yes, that explains why the registration fails, but not why this patch is
the correct solution to the problem.

The problematic code appears to be:

snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);

Instead, I think that should be something more like:

adap->name = dev_name(&pdev->dev);

or perhaps:

if (pdev->dev.of_node)
  /* named will be based on DT node name */
  adap->name = dev_name(&pdev->dev);
else
  snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);

?

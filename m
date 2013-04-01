From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 2 Apr 2013 00:42:07 +0100
Subject: [PATCH 2/6] rtc: rtc-m48t86: add hooks to support driver side
 memory mapping
In-Reply-To: <515A1A0B.8040803@gmail.com>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
 <515A1A0B.8040803@gmail.com>
Message-ID: <20130401234207.GL1953@edkhil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 10:36:43AM +1100, Ryan Mallon wrote:
>On 02/04/13 10:22, Alexander Clouter wrote:
>> If platform_data is not defined (as before), then named memory io
>> ranges need to be defined ("rtc_index" and "rtc_data").  The driver
>> then maps those regions and uses them as the RTC index and data
>> addresses.
>>
>> Does compile with the following warnings, I cannot see the codepath
>> affected myself:
>> ----
>> drivers/rtc/rtc-m48t86.c: In function ?m48t86_rtc_probe?:
>> drivers/rtc/rtc-m48t86.c:180: warning: ?res_index? may be used uninitialized in this function
>> drivers/rtc/rtc-m48t86.c:180: warning: ?res_data? may be used uninitialized in this function
>
>It is caused by the exit paths. If pdev->dev.platform_data is set, the
>res_index and res_data are never initialised, but in the error case you
>still for rtc_device_register you jump to out_io_data, which will then
>dereference res_index/res_data. You need to make the exit paths
>conditional on pdev->dev.platform_data (or init res_index/data to NULL
>and make the release_mem_regions conditional on that).

However, the 'goto out_io_data' in the 'IS_ERR(priv->rtc)' is wrapped in a 'if 
(!pdev->dev.platform_data)', else we jump to out_free.

I suspect I am probably missing something *too* obvious here for it to click?

Cheers

>> +	priv->rtc = rtc_device_register("m48t86",
>> +				&pdev->dev, &m48t86_rtc_ops, THIS_MODULE);
>> +	if (IS_ERR(priv->rtc)) {                <--------------
>> +		err = PTR_ERR(priv->rtc);
>> +		if (!pdev->dev.platform_data)   <--------------
>> +			goto out_io_data;
>> +		else
>> +			goto out_free;
>> +	}
>>
>>  	/* read battery status */
>> -	reg = ops->readbyte(M48T86_REG_D);
>> -	dev_info(&dev->dev, "battery %s\n",
>> +	reg = m48t86_rtc_readbyte(&pdev->dev, M48T86_REG_D);
>> +	dev_info(&pdev->dev, "battery %s\n",
>>  		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
>>
>>  	return 0;
>> +
>> +out_io_data:
>> +	iounmap(priv->io_data);
>> +out_io_index:
>> +	iounmap(priv->io_index);
>> +out_release_data:
>> +	release_mem_region(res_data->start, resource_size(res_data));
>> +out_release_index:
>> +	release_mem_region(res_index->start, resource_size(res_index));
>> +out_free:
>> +	platform_set_drvdata(pdev, NULL);
>> +	kfree(priv);
>> +	return err;
>>  }

-- 
Alexander Clouter
.sigmonster says: Zeus gave Leda the bird.

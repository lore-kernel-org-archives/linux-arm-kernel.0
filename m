From: marcel@holtmann.org (Marcel Holtmann)
Date: Sun, 21 Dec 2014 00:39:31 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <20141220154850.GA28390@amd>
References: <20141213223727.GA13894@amd>
 <97C706D6-765B-446A-8180-600F5FB6C68B@holtmann.org>
 <20141219095000.GA24703@amd>
 <7DC7F8DF-CBC7-47CE-8B6F-5BA19ADBB3B6@holtmann.org>
 <20141220154850.GA28390@amd>
Message-ID: <5AC947DA-87BA-48B7-ABB8-7663B3D3E844@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

>>> I have trouble understanding... h4p_hci_open() seems to be called as
>>> soon as I insmod the driver. Who does that? Is it some kind of udev
>>> magic?
>> 
>> As soon as you do hci_register_dev, it will bring up the device and run the basic initialization. That is needed to get the address, version information and features. Otherwise the mgmt interface can not work. We need basic information about the device.
>> 
>> So what the kernel will do internally when you find a device is bring it up, get the basics and then bring it back down (in case nobody uses it). See hci_power_on work.
>> 
> 
> Aha, slightly unexpected, but it matches observations. Good.

we are at Bluetooth 4.2 specification now. Thinks got a lot more complicated these days.

> 
>>> To use __hci_cmd_sync()
>>> 
>>>>> +
>>>>> +	SET_HCIDEV_DEV(hdev, info->dev);
>>>>> +
>>>>> +	if (hci_register_dev(hdev) >= 0)
>>>>> +		return 0;
>>>>> +
>>>>> +	dev_err(info->dev, "hci_register failed %s.\n", hdev->name);
>>>>> +	hci_free_dev(info->hdev);
>>>>> +	return -ENODEV;
>>>>> +}
>>>> 
>>>> And normally this is folded into the probe handling and not in a
>>>> separate function.
>>> 
>>> The probe function is too long, already...
>> 
>> Have you compared it to other functions. Normally probe() functions in general are all pretty long since they have to do tons of stuff. Having all in one function means you can read through it at once.
>> 
> 
> Ok.
> 
>>>>> +#include "hci_h4p.h"
>>>> 
>>>> Why is this a separate file? And if so, why not all UART specific details are in this file. Including bunch of the defines you have in the header.
>>>> 
>>> 
>>> Well, you wanted less global functions, so I moved some as inlines to
>>> headers. I guess I can merge nokia_core and nokia_uart if really wanted.
>> 
>> Would this become easier when some of the OMAP specific stuff is moved out of this driver? If that is possible.
>> 
> 
> Yes, I can investigate further cleanups. But original plan was to
> merge it and then clean up the rest. Could we do that, please?

You need to fix all these small details. There are tons of whitespace damages, indentation issues, trailing whitespaces and what not. Even if they were in the original driver to begin this, they can not be in a driver submitted these days.

Regards

Marcel

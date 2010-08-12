From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Thu, 12 Aug 2010 19:08:57 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <4C632217.9000608@gmail.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>	<4C627479.4060400@parrot.com>	<AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>	<4C62C7B3.2030706@nvidia.com>
	<20100811203505.GA463@n2100.arm.linux.org.uk>
	<4C632217.9000608@gmail.com>
Message-ID: <4C642AA9.1060404@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Fuzzey a ?crit :
>> We don't want to add support for this to DMA bounce.  DMA bounce is already
>> a pain in the backside and causes its own set of problems - please let it
>> die a long slow but quite death.
>>
>> If you want to see the kind of pain dmabounce causes, look at this long
>> standing and as yet unsolved bug:
>>
>>   http://bugzilla.kernel.org/show_bug.cgi?id=7760
>>
>>   
> Well I don't know the dmabounce code but why is using it likely to cause
> OOM problems (at least why more so than copying the buffer in the HCD or
> the usb core). In both cases there will be two copies of the buffer in
> memory which could I agree be a problem in memory constrained systems.
> But if we _do_ want to accept unaligned buffers from usb drivers I can't
> see  a way round that.
> 
memmove is our friend :
the buffer allocated in usbnet got an offset.
All you have to do it remove this offset and memmove the data. That what 
I did [1], and why it is better to do it in usb driver.


Matthieu




[1] http://article.gmane.org/gmane.linux.usb.general/28700
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gadget-align.diff
Type: text/x-diff
Size: 2251 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100812/7bf8e096/attachment.bin>

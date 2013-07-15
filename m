From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Mon, 15 Jul 2013 23:16:19 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <20130706193646.GB9778@kroah.com>
References: <20130617225847.GA9494@kroah.com>
 <20130624092942.GG26008@lukather> <20130624160440.GA15201@kroah.com>
 <51C87DC7.50005@schinagl.nl> <20130624181509.GA8847@kroah.com>
 <51C8B84C.3020200@schinagl.nl> <20130624214615.GA17604@kroah.com>
 <51CAA709.4060801@schinagl.nl> <20130626175144.GC2222@kroah.com>
 <51D674BF.9030207@schinagl.nl> <20130706193646.GB9778@kroah.com>
Message-ID: <51E466A3.4010503@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/13 21:36, Greg KH wrote:
> On Fri, Jul 05, 2013 at 09:24:47AM +0200, Oliver Schinagl wrote:
>> The other 'broken' drivers that where linked earlier, also use the
>> BINARY attributes.
>>
>> So Greg, if you could be so kind and give me an example how to
>> implement this properly, I am at loss and don't know :(
>
> Ah crap, devices don't have a binary attribute group, like struct class
> does.  I'll go add that on Monday and send you the patch to see if that
> helps you out.  I'll also go through and fix up all of the binary
> attribute drivers to keep them from doing that...
>
> Sorry, I missed that earlier, but thanks for trying and pointing out my
> mistake.
>
> greg k-h
>

Greg,

I know you are a busy man and I hate take away some of your time, but 
could you be so kind and point me into the right direction and show me 
what I should do?

With your latest patches for binary attributes and your blog post, I 
thought that you want to create your binary attributes before the probe 
function, to avoid the userspace race. To do that, we have two options, 
create them in init (ugly?) or fill the .group member if available so it 
gets automatically created from the register function.

Well in my case, I'm using the module_platform_driver() macro which 
expects the struct platform_driver. Platform_driver has a device_driver 
member .driver where the .groups is located. Great, using that works and 
we should have the sysfs entry race-free. However I don't know hot to 
exchange data between that and the rest of my driver.

Before I used to_platform_device(kobj_to_dev(kobj)) as passed via the 
.read function to obtain a platform_device where i could use 
platform_get_drvdata on. All was good, but that doesn't fly now and my 
knowledge is a bit short as to why.

The second method is finding some other shared structure given that we 
get a platform_device in the probe function, yet I couldn't find 
anything and this platform_device isn't the same as the one from the .read.

Of course using a global var bypasses this issue, but I'm sure it won't 
pass review ;)

So using these new patches for binary attributes, how can I pass data 
between my driver and the sysfs files using a platform_driver? Or are 
other 'hacks' needed and using the .groups attribute from 
platform_driver->device_driver->groups is really the wrong approach.

I did ask around and still haven't figured it out so far, so I do 
apologize if you feel I'm wasting your precious time.

Oliver
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sunxi_sid.c
Type: text/x-csrc
Size: 4119 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/7e9d8821/attachment-0001.bin>

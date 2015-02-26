From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 25 Feb 2015 16:24:06 -0800
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <54E53278.70705@broadcom.com>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <2797126.uqvyZJisPk@wuerfel> <54E3AD2E.8050902@broadcom.com>
 <11865413.8NsXkQ6AUR@wuerfel> <54E53278.70705@broadcom.com>
Message-ID: <54EE67A6.609@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan and Arnd

I wanted to follow up on this patch and ascertain what I would have to 
change. Please see below for my questions

On 15-02-18 04:46 PM, Arun Ramamurthy wrote:
>
>
> On 15-02-18 07:15 AM, Arnd Bergmann wrote:
>> On Tuesday 17 February 2015 13:05:50 Arun Ramamurthy wrote:
>>> On 15-02-17 12:53 PM, Arnd Bergmann wrote:
>>>> On Tuesday 17 February 2015 12:00:49 Arun Ramamurthy wrote:
>>>>> Arnd, I patched the ehci and ohci driver to accept multiple phys so
>>>>> they
>>>>> require different names and cannot both be "usb". That patch was
>>>>> accepted by Alen Stern but I did not update the bindings
>>>>> documentation.
>>>>> I will send out another patch for that. Could we go with the naming
>>>>> scheme of "usb" + "p" + port number or do you have other suggestions?
>>>>
>>>> I don't have a good idea, but I think it would be best if the first
>>>> phy could remain named "usb" for compatibility with the existing
>>>> binding.
>>>>
>>> The patch was written in a way that all the existing and new drivers can
>>> continue to use "usb" if they are using only one phy so that we remain
>>> compatible. The names need to be different only if more than one phy is
>>> specified. In such cases i don't think the first phy should be "usb" as
>>> it would be confusing to have
>>>          phy-names = "usb","usbp1"
>>
>> I see your patch now, as 7e7a0e67f2c ("usb: ehci-platform: add support
>> for
>> multiple phys per controller"), and I'm not too happy about the way you
>> did this.
>
>> We already concluded that there should have been a binding change
>> to go along with this, and that would have caught the fact that you
>> circumvent the API here by reading the phy names manually. That
>> part should never have made it into the kernel.
>>
>> I think we can do this either by defining specific names for the
>> phy, or by changing the generic PHY binding to allow anonymous
>> phy references (leaving out "phy-names" entirely), and adding a
>> proper API for that.
>>
> Thanks Arnd, I will wait for Alan's comments before proceeding. I am
> happy to patch the ehci-platform driver to use a new api instead of
> devm_phy_get if that is the best option.
>
>>> Should I run this by Alan Stern?
>>
>> I've added him to Cc here. He clearly didn't know the background about
>> the DT binding change, and should not need to, but he may have an opinion
>> on what names we should use.
>>
>
Arnd, should I re patch the ehci-platform driver to avoid phy-names 
entirely? Alan, if not do you have an opinion on what the usb phy names 
should be? The current patch uses "usbp" + port number such as "usbp0" , 
"usbp1" etc

>>>> What is the reason for having two phys in your case? Are these
>>>> identical phy devices connected to a single controller or do they
>>>> server different purposes?
>>>>
>>> Yes, we have three identical phys connected to a single host controller
>>> and one of the phys is also connected to the device controller
>>
>> Ok, no problem with that, let's just make sure we come up with a
>> good binding for it.
>>
Arnd do you have any other comments on the phy driver itself? Thank you
>>     Arnd
>>

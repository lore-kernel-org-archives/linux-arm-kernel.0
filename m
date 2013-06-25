From: rogerq@ti.com (Roger Quadros)
Date: Tue, 25 Jun 2013 16:37:11 +0300
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <20130624193643.GC11815@arwen.pp.htv.fi>
References: <20130620121749.GF9817@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
 <20130624193643.GC11815@arwen.pp.htv.fi>
Message-ID: <51C99D07.6030307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 10:36 PM, Felipe Balbi wrote:
> On Thu, Jun 20, 2013 at 01:25:31PM -0400, Alan Stern wrote:
>> On Thu, 20 Jun 2013, Felipe Balbi wrote:
>>
>>>> In fact, the PHY setting and handling is related to platform or SOC,
>>>> and for different SOC they can
>>>> have same EHCI HCD but they PHY handling can be different.
>>>> Omap'a case is the example, and i think some other vendors may have
>>>> silimar cases.
>>>> From above point, It is better to leave the PHY initialization and
>>>> shutdown to be done by each echi-xxx driver.
>>>>
>>>> So Alan and Felipe
>>>> What are your ideas about it?
>>>
>>> If we have so many exceptions, then sure. But eventually, the common
>>> case should be added generically with a flag so that non-generic cases
>>> (like OMAP) can request to handle the PHY by themselves.
>>>
>>> Alan ?
>>
>> I don't have very strong feelings about this; Felipe has much more
>> experience with these things.
>>
>> However, when the common case is added into the core, the simplest way
>> to indicate that the HCD wants to handle the PHY(s) by itself will be
>> to leave hcd->phy set to NULL or an ERR_PTR value.
>>
>> One important thing that hasn't been pointed out yet: When we move
>> these calls into the core, the same patch must also remove those calls
>> from the glue drivers that currently do set hcd->phy.  And it must make
>> sure that the glue drivers which handle the PHY by themselves do not
>> set hcd->phy.
> 
> perfect summary. Perhaps Roger could already work on private PHY handle
> for ehci-omap.c and later we can start moving generic case to usbcore
> without having to touch ehci-omap.c at all. Roger, any commetns ?
> 

This looks fine to me. I don't have anything to add.

cheers,
-roger

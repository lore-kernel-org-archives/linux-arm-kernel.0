From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 5 Aug 2016 10:34:20 +0200
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <874m6zybc7.fsf@belgarion.home>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160804153835.GY1041@n2100.armlinux.org.uk>
 <32e4f4c5-81d1-4a84-69af-e1b05d564bd7@codeaurora.org>
 <39afe8fb-4356-b6a3-9e17-5b60abf10040@metafoo.de>
 <874m6zybc7.fsf@belgarion.home>
Message-ID: <991ce35d-4278-629b-0240-758a2eae71a9@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2016 08:32 AM, Robert Jarzmik wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
> 
>> On 08/04/2016 06:08 PM, Sinan Kaya wrote:
>> [...]
>>> The other way is I can feed this information to what Dave just introduced
>>> as part of the callback mechanism and not touch this.
>>
>> Use the callback mechanism. It is a lot easier to implement correctly than
>> the tx_status() mechanism.
>>
>>> The main discussion here is that 
>>>
>>> "tx_status does not indicate whether the final transaction is successful or
>>> not" whether the driver has the capability to determine error or not.
>>
>> tx_status() is supposed to be able to indicate whether a transfer failed or
>> not. But in my opinion this feature is broken by design and implementing it
>> correctly is very difficult without creating memory leaks. Which is probably
>> why so few drivers actually implement it.
> 
> I think you can implement the error reporting by remembering the "last" cookie
> where an error occurred such as in :
>  - e093bf60ca49 ("dmaengine: pxa: handle bus errors")
>    => see the part of the commit beginning with "As dma_cookie_status() ..."
> 
> The point about error reporting was already discussed  with Vinod in here:
>    https://lkml.org/lkml/2016/4/13/471
>    => Vinod and I were seeing the reporting can be improved

But that allows you only to report the error for the last descriptor that
failed. If two or more have failed any but the last will return DMA_COMPLETE
instead of DMA_ERROR. In your case that sort of works because you completely
stop execution after a descriptor failed. But as you noted in the commit
message this will report misleading status values for the descriptors after
the descriptor that failed.

I believe we need to invest some effort to come up with clear semantics on
what is the expected behavior when transferring a descriptor fails.
Potentially allowing clients to choose the desired behavior, e.g. either
abort all descriptors on error or continue with the next one.

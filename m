From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Aug 2013 22:15:15 +0100
Subject: [PATCH 1/2] DMA: fix AMBA PL08x driver issue with 64bit DMA
 address type
In-Reply-To: <520D430E.2050803@linaro.org>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
 <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
 <20130814130026.GS23006@n2100.arm.linux.org.uk>
 <CAL_JsqLRtRvPyFagLLaRAjciiur=qVKmt2v7q5MPtEGuDske4Q@mail.gmail.com>
 <520D430E.2050803@linaro.org>
Message-ID: <20130815211515.GF23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:07:26PM +0200, Andre Przywara wrote:
> On 08/14/2013 09:13 PM, Rob Herring wrote:
>> On Wed, Aug 14, 2013 at 8:00 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> NAK.
>>
>> This patch has nothing to do with dma masks or your dma mask series.
>> The code deals with bus alignment and cleans up the code to do
>> alignment operations in a sane way compared to modulo operator. The
>> only thing 64-bit dma_addr_t did was expose crap code.
>
> I agree. Actually I'd see the DMA mask thing just as an opportunity to  
> fix this code, not as the reason. I guess there are gazillions of  
> drivers in the ARM world which have problems with any address related  
> variable being bigger than 32bit, and those should all be fixed 
> eventually.

No they shouldn't.  If the DMA address registers are 32-bit, then the
DMA engine can *only* handle 32-bit addresses.

That's partly the point of my patch set: if the DMA registers are 32-bit,
then the device driver should set a 32-bit DMA mask to tell the rest of
the kernel that this driver only supports 32-bit addresses.

If DMA bus addresses of 0-4G translates to memory in the range (say) of
4G-8G physical, and you have memory in the region of 4G-8G, then that
should work.  At the moment, it doesn't - and that's what those patches
address.

The fact that the PL08x driver was ending up with DMA addresses in the
4G-8G range is a bug.  DMA addresses after mapping are supposed to be
the _exact_ value you program into the hardware.  If that value is not,
then the DMA API is buggy for that platform.

That all said, yes this patch is mostly fine, except:

>>>> +static int bus_addr_offset(struct pl08x_bus_data *bus)
>>>> +{
>>>> +     return bus->addr & (bus->buswidth - 1);
>>>> +}

that this is a poor name for this function - and we don't need it because
we have a generic form of this - IS_ALIGNED().  Is there any reason to
re-code what's already provided?

From: leoli@freescale.com (Li Yang)
Date: Wed, 9 Mar 2016 17:16:50 -0600
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <CAOCOHw7wgzyp5JmhBF9i1mAsjOHHJhwvn4sw=aMdQjOQPDGqWA@mail.gmail.com>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <56CADCE9.9090305@linaro.org> <20160222220750.GI21240@tuxbot>
 <CADRPPNRH28W6u8adSb9Ja0JSJvFgcKF+2jYa3GSKBcGVsZcdLQ@mail.gmail.com>
 <CADRPPNS0q3Q9j4AYvqRfcSaQ6BzLiL6zM5tn7MwJ613iNA1iPQ@mail.gmail.com>
 <CAOCOHw7wgzyp5JmhBF9i1mAsjOHHJhwvn4sw=aMdQjOQPDGqWA@mail.gmail.com>
Message-ID: <CADRPPNRTXiiVzbqmpX7h_af7Q+qw+-ZB3zDb0855a1U=CmWh-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 9:40 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue, Mar 8, 2016 at 11:52 AM, Li Yang <leoli@freescale.com> wrote:
>> On Wed, Mar 2, 2016 at 4:59 PM, Li Yang <leoli@freescale.com> wrote:
>>> On Mon, Feb 22, 2016 at 4:07 PM, Bjorn Andersson
>>> <bjorn.andersson@linaro.org> wrote:
>>>> On Mon 22 Feb 02:03 PST 2016, Srinivas Kandagatla wrote:
>>>>
>>>>>
>>>>>
>>>>> On 22/02/16 05:32, Bjorn Andersson wrote:
>>>>> >On certain platforms (e.g. ARM64) the dma_ops needs to be explicitly set
>>>>> >to be able to do DMA allocations, so use the of_dma_configure() helper
>>>>> >to populate the dma properties and assign an appropriate dma_ops.
> [..]
>>>>> None of the drivers call of_dma_configure() explicitly, which makes me feel
>>>>> that we are doing something wrong. TBH, this should be handled in more
>>>>> generic way rather than driver like this having an explicit call to
>>>>> of_dma_configure().
>>>>>
>>>>
>>>> I agree, trying to figure out if it should be inherited or something.
>>>
>>> I also agree.  We need address it in a more generic way.  I did a
>>> search for platform_device_add()/platform_device_register() in the
>>> kernel source code.  I found a lot of them and many could be also
>>> doing DMA.  Looks like it is still too early to assume every device is
>>> already getting dma_ops set through bus probe.  Otherwise, many
>>> drivers are potentially broken by this assumption.
>>
>> Any further comment on this topic?  I added the linux-arm mailing list
>> which was missing from previous discussion.
>>
>
> I had the chance to go through this with Arnd and the verdict is that
> devices not described in DT should not do DMA (or allocate buffers for
> doing DMA).
>
> So I believe the solution is to fall back on Peter's description; the
> chipidea driver is the core driver and the Qualcomm code should just
> be a platform layer.
>
> My suggestion is that we turn the chipidea core into a set of APIs
> that can called by the platform specific pieces. That way we will have
> the chipidea core be the device described in the DT.

But like I said, this problem is not just existing for chipidea
driver.  We already found that the dwc3 driver is also suffering from
the same issue.  I don't know how many other drivers are impacted by
this change, but I suspect there will be some. A grep of
platform_device_add() in driver/ directory returns many possible
drivers to be impacted.  As far as I know, the
drivers/net/ethernet/freescale/fman/mac.c is registering child
ethernet devices that definitely will do dma.   If you want to do this
kind of rework to all these drivers, it will be a really big effort.

Regards,
Leo

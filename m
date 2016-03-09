From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 8 Mar 2016 19:40:08 -0800
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <CADRPPNS0q3Q9j4AYvqRfcSaQ6BzLiL6zM5tn7MwJ613iNA1iPQ@mail.gmail.com>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <56CADCE9.9090305@linaro.org> <20160222220750.GI21240@tuxbot>
 <CADRPPNRH28W6u8adSb9Ja0JSJvFgcKF+2jYa3GSKBcGVsZcdLQ@mail.gmail.com>
 <CADRPPNS0q3Q9j4AYvqRfcSaQ6BzLiL6zM5tn7MwJ613iNA1iPQ@mail.gmail.com>
Message-ID: <CAOCOHw7wgzyp5JmhBF9i1mAsjOHHJhwvn4sw=aMdQjOQPDGqWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 11:52 AM, Li Yang <leoli@freescale.com> wrote:
> On Wed, Mar 2, 2016 at 4:59 PM, Li Yang <leoli@freescale.com> wrote:
>> On Mon, Feb 22, 2016 at 4:07 PM, Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>>> On Mon 22 Feb 02:03 PST 2016, Srinivas Kandagatla wrote:
>>>
>>>>
>>>>
>>>> On 22/02/16 05:32, Bjorn Andersson wrote:
>>>> >On certain platforms (e.g. ARM64) the dma_ops needs to be explicitly set
>>>> >to be able to do DMA allocations, so use the of_dma_configure() helper
>>>> >to populate the dma properties and assign an appropriate dma_ops.
[..]
>>>> None of the drivers call of_dma_configure() explicitly, which makes me feel
>>>> that we are doing something wrong. TBH, this should be handled in more
>>>> generic way rather than driver like this having an explicit call to
>>>> of_dma_configure().
>>>>
>>>
>>> I agree, trying to figure out if it should be inherited or something.
>>
>> I also agree.  We need address it in a more generic way.  I did a
>> search for platform_device_add()/platform_device_register() in the
>> kernel source code.  I found a lot of them and many could be also
>> doing DMA.  Looks like it is still too early to assume every device is
>> already getting dma_ops set through bus probe.  Otherwise, many
>> drivers are potentially broken by this assumption.
>
> Any further comment on this topic?  I added the linux-arm mailing list
> which was missing from previous discussion.
>

I had the chance to go through this with Arnd and the verdict is that
devices not described in DT should not do DMA (or allocate buffers for
doing DMA).

So I believe the solution is to fall back on Peter's description; the
chipidea driver is the core driver and the Qualcomm code should just
be a platform layer.

My suggestion is that we turn the chipidea core into a set of APIs
that can called by the platform specific pieces. That way we will have
the chipidea core be the device described in the DT.

I'll try to find some time to prototype this after Connect.

Regards,
Bjorn

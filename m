From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Mon, 09 Mar 2015 15:12:39 -0400
Subject: [PATCH v5] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <20150309155711.GS8656@n2100.arm.linux.org.uk>
References: <1424969811-11197-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424969811-11197-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <54F5DC08.1040807@linaro.org> <20150309155711.GS8656@n2100.arm.linux.org.uk>
Message-ID: <54FDF0A7.20009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2015 11:57 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 03, 2015 at 11:06:32AM -0500, Jorge Ramirez-Ortiz wrote:
>> On 02/26/2015 11:56 AM, Jorge Ramirez-Ortiz wrote:
>>> -	chan = dma_request_slave_channel(dev, "tx");
>>> +	uap->dma_probed = true;
>>> +
>>> +	chan = dma_request_slave_channel_reason(uap_dev, "tx");
>>> +	if (IS_ERR(chan)) {
>>> +		if (PTR_ERR(chan) == -EPROBE_DEFER) {
>>> +			dev_info(uap_dev, "DMA driver not ready\n");
> I still object to this.

it was an oversight, not intentional. my fault.

>
> It _can't_ be right that we plaster the kernel console with these
> messages when the is a DMA possible, but the DMA driver is a module
> which hasn't been loaded yet.
>
> You probably don't realise it, but init daemons tend to open the
> console, write their message, and then close it again.  What your
> message above means is that each time an init daemon does that, we
> get a "DMA driver not ready" message.

I initially - before your first remarks- did think about the init daemons and
balancing the value I saw in having the message in (for product developers) I
thought it was worth having it.

What I didnt know relates to your second point about modules:

- That for as long as the device tree declares a DMA name that matches the one
that the UART requests in its DT settings, attempting to request a channel on it
before said DMA driver has been registered would be returning EPROBE_DEFER (same
thing for ACPI).

- And yes, as the situation described above could go on for ever (maybe the
driver was blacklisted) the clutter in the log would be unacceptable.

[I had only looked at defer driver probing from the perspective of its internal
lists (deferred_probe_ending/active_list) and did not have the overall picture
in mind. So I missed this point]

>
> IMHO, that is unacceptable.
>

agree.

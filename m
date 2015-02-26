From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 25 Feb 2015 21:27:27 -0500
Subject: [PATCH v3] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <20150226005601.GJ8656@n2100.arm.linux.org.uk>
References: <1424910661-26474-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20150226005601.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <54EE848F.5060009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 07:56 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 25, 2015 at 07:31:01PM -0500, Jorge Ramirez-Ortiz wrote:
>> @@ -275,9 +277,16 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>  	struct dma_chan *chan;
>>  	dma_cap_mask_t mask;
>>  
>> -	chan = dma_request_slave_channel(dev, "tx");
>> +	uap->dma_probed = true;
>> +
>> +	chan = dma_request_slave_channel_reason(dev, "tx");
>> +	if (IS_ERR(chan)) {
>> +		if (PTR_ERR(chan) == -EPROBE_DEFER) {
>> +			dev_warn(uap->port.dev, "DMA driver not ready\n");
>> +			return;
>> +		}
>> +		dev_info(uap->port.dev, "no OF or ACPI DMA data\n");
> So if we get an -EPROBE_DEFER, we never try again, because uap->dma_probed
> is left true?

Yes that is the idea: the DMA is expected to be ready at that time (when user
requires access to the uart for the first time)

We wont see any degradation with respect to the previous version of the driver
(the previous version was a single attempt to probe the DMA on a device_initcall
- before even deferred probing had a chance to begin).

hw_init also gets called during resume and allowing that probe would have been
unnecessary.
As well as removing the comment you mentioned I realized that the following is
needed.

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3501ccc..486d510 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -285,7 +285,6 @@ static void pl011_dma_probe(struct device *dev, struct
uart_amba_port *uap)
                        dev_warn(uap->port.dev, "DMA driver not ready\n");
                        return;
                }
-               dev_info(uap->port.dev, "no OF or ACPI DMA data\n");
 
                /* We need platform data */
                if (!plat || !plat->dma_filter) {
@@ -2208,7 +2207,6 @@ static int pl011_probe(struct amba_device *dev, const
struct amba_id *id)
        if (ret) {
                amba_ports[i] = NULL;
                uart_unregister_driver(&amba_reg);
-               pl011_dma_remove(uap);
        }
 
        return ret;


>
> Should we even emit a message here?  What if userspace opens and closes
> the device multiple times before the DMA driver is ready?

If the DMA is not ready when the user wants to use the UART for the first time
then we give up on attempting to associate a DMA to that uart.
I dont think the tty is available to userland before deferred probes have been
handled anyway?

And open/closing the tty will not cause further attempts to probe and therefore
the message will not be displayed.


>
> Please get rid of that "no OF or ACPI DMA data" message.  There are
> situations where we have a DMA engine, but there is quite legally no
> DMA available on the port.  Such a message would be an annoyance.
> DMA is optional.

yes since the DMA is optional I left it as an info message (not an error)

I put it there in case there was a problem in the device tree strings that
define the DMA to use.
But I guess it can become annoying even if it is only shown once.
OK I'll take it out.



>

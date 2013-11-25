From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 25 Nov 2013 09:45:18 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <5293883A.8050808@wwwdotorg.org>
References: <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
 <5293883A.8050808@wwwdotorg.org>
Message-ID: <CAA9_cmfMtp4WjRGVzfTxrwcNWP95+HE7DAYg_GeWfqi=L2K2aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 9:26 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/22/2013 05:34 PM, Russell King - ARM Linux wrote:
> [... various discussions re: IS_ERR, IS_ERR_OR_NULL, etc.]
>
> Russell, so if we document dma_request_slave_channel() as follows:
>
>> /*
>>  * dma_request_slave_channel - try to allocate an exclusive slave channel
>> ...
>>  * Returns pointer to appropriate DMA channel on success or an error pointer.
>>  * In order to ease compatibility with other DMA request APIs, this function
>>  * guarantees NEVER to return NULL.
>>  */
>
> Are you then OK with clients doing either of e.g.:
>
> chan = dma_request_slave_channel(...);
> if (IS_ERR(chan))
>         // This returns NULL or a valid handle/pointer
>         chan = dma_request_channel()
> if (!chan)
>         Here, chan is invalid;
>         return;
> Here, chan is valid
>

If the driver falls back to dma_request_channel then this one is cleaner.

> or:
>
> if (xxx) {
>         chan = dma_request_slave_channel(...);
>         // Convert to same error value as else{} block generates
>         if (IS_ERR(chan))
>                 chan = NULL
> } else {
>         // This returns NULL or a valid handle/pointer
>         chan = dma_request_channel()
> }
> if (!chan)
>         Here, chan is invalid
>         return;
> Here, chan is valid

Regardless of whether the driver was dma_request_channel as a
fallback, it will currently use NULL to indicate an allocation
failure.  We could go and audit the driver's usage of the result to
add more IS_ERR() guards.  In the absence of a later call to
dma_request_channel() immediately converting to NULL is the least
error prone conversion.  Of course it's up to the driver, for example:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index aaa22867e656..c0f400c3c954 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -278,7 +278,7 @@ static void pl011_dma_probe_initcall(struct device
*dev, struct uart_amba_port *

        chan = dma_request_slave_channel(dev, "tx");

-       if (!chan) {
+       if (IS_ERR(chan)) {
                /* We need platform data */
                if (!plat || !plat->dma_filter) {
                        dev_info(uap->port.dev, "no DMA platform data\n");

...does not need to convert it to NULL.

Nor this one...
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index ff9d6de2b746..b71c5f138968 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -502,7 +502,7 @@ static int cppi41_dma_controller_start(struct
cppi41_dma_controller *controller)
                musb_dma->max_len = SZ_4M;

                dc = dma_request_slave_channel(dev, str);
-               if (!dc) {
+               if (IS_ERR(dc)) {
                        dev_err(dev, "Falied to request %s.\n", str);
                        ret = -EPROBE_DEFER;
                        goto err;

...but need to go back and see if this can be cleaned up to not invent
the error code here.

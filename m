From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 12:00:55 -0700
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <CAA9_cmcqO-=7Gf53ygG3oYwC0=fQgF8xPL2Wywgw84Dz1ZKs6g@mail.gmail.com>
References: <528D28A1.2050307@wwwdotorg.org>	<CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>	<528E4F55.9070204@wwwdotorg.org>	<CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>	<528F95A9.2050305@wwwdotorg.org>	<CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>	<528F9DF9.6080706@wwwdotorg.org>	<20131123003442.GH16735@n2100.arm.linux.org.uk>	<5293883A.8050808@wwwdotorg.org>	<CAA9_cmfMtp4WjRGVzfTxrwcNWP95+HE7DAYg_GeWfqi=L2K2aw@mail.gmail.com>	<20131125180000.GR16735@n2100.arm.linux.org.uk>
 <CAA9_cmcqO-=7Gf53ygG3oYwC0=fQgF8xPL2Wywgw84Dz1ZKs6g@mail.gmail.com>
Message-ID: <52939E67.6040300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 11:42 AM, Dan Williams wrote:
> On Mon, Nov 25, 2013 at 10:00 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Nov 25, 2013 at 09:45:18AM -0800, Dan Williams wrote:
>>> Regardless of whether the driver was dma_request_channel as a
>>> fallback, it will currently use NULL to indicate an allocation
>>> failure.
>>
>> At the moment, dma_request_slave_channel()'s return values are valid
>> pointer or NULL.  I'd suggest as that's how it's been established,
>> that function is left alone - changing the return values in this kind
>> of invisible way is Really Bad(tm) because you can't check that it's
>> right in any future users - unless you're prepared to review every
>> single new user of this function for the next few years or more.
>>
>> Instead, leaving it as is and introducing a new function name with
>> the different return error method is the right way to do this.
> 
> I was attempting to tap the brakes on the number of request_channel
> apis in circulation.
> dma_request_channel
> dma_request_slave_channel
> dma_request_slave_channel_compat
> ... and now dma_request_slave_channel_reason
> 
> ...but given we already have things like samsung_dmadev_request() in
> the wild, tracking correct usage going forward will be an uphill
> battle.  We can do this the other way round.  Introduce the new api
> and delete the old one (after some time).
> 
> Stephen,
> 
> Can we make the new api not pass the 'defer' flag.  You mention it is
> for compat reasons, but since there are no users I'm not seeing how
> there can be compatibility concerns.  Can you elaborate?

dma_request_slave_channel_or_err() doesn't have a defer flag. Rather,
__dma_request_slave_channel_or_err() did, which is the shared
implementation between the existing existing dma_request_slave_channel()
and the new dma_request_slave_channel_or_err().

That flag exists so it can be passed to of_dma_request_slave_channel().
That function needs it because I didn't want to change the existing
behaviour of dma_request_slave_channel() at all, yet I wanted slightly
different behaviour from dma_request_slave_channel_or_err().

Specifically, if of_dma_request_slave_channel() finds an entry in the
dmas DT property for which there is no registered DMA controller, it
simply ignores that entry and carries on, hoping to find an alternative
entry that can satisfy the request (since some controllers can be
supported by multiple DMA controllers). However, to support deferred
probe, we really need to bail out from the loop early with -EPROBE_DEFER
if any DMA controller isn't found, in order to wait for it to be registered.

I suppose an alternative would be to remove that flag, and have the loop
in of_dma_request_slave_channel() initially ignore any unregistered DMA
controllers, and still continue to look through the property for any
alternative controller, and return a channel from one if it is found.
Then, at the very end of the function, we could always return
-EPROBE_DEFER if any unregistered DMA controllers were found, otherwise
return -ENODEV. That would keep compatible behaviour, but it would mean
that device probe order would/could influence which dmas entry provided
the channel, since some entries might be ignored based simply on
timing/ordering of DMA controller registration. Is that acceptable?

Either way, just let me know and I'll adjust the code accordingly; the
code changes for either option are simple.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 17:18:34 -0600
Subject: [PATCH V4 1/4] ASoC: Samsung: I2S: Add quirks as driver data
 in I2S
In-Reply-To: <20130812231327.GK6427@sirena.org.uk>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
 <1376300994-1679-2-git-send-email-padma.v@samsung.com>
 <52096871.4030703@wwwdotorg.org> <20130812231327.GK6427@sirena.org.uk>
Message-ID: <52096D4A.5070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 05:13 PM, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 04:57:53PM -0600, Stephen Warren wrote:
>> On 08/12/2013 03:49 AM, Padmavathi Venna wrote:
> 
>>> +- compatible : should be one of the following. +   -
>>> samsung,s3c6410-i2s: for 8/16/24bit stereo I2S. +   -
>>> samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with 
>>> +     secondary fifo, s/w reset control and internal mux for
>>> root clk src.
> 
>> Those descriptions seem a little odd. If I have an SoC that
>> isn't s5pv210, yet supports "8/16/24bit multichannel(5.1) I2S
>> with secondary fifo, s/w reset control and internal mux for root
>> clk src", will compatible="samsung,s5pv210-i2s" work for my HW?
> 
>> I wonder if you should instead include the IP block version in
>> the compatible value?
> 
> We've been round this loop several times, I'd prefer the IP block 
> versions too but they're at best patchily documented and so as a
> general policy the Samsung bindings use the name of the SoC an IP
> first appeared in as the version.
> 
>> In other words, I don't think we have an answer to the question:
>> Should differences between similar HW blocks be encoded into DT
>> properties, or should the driver encode them into some table, and
>> look them up from compatible value?
> 
> For usability it seems better to just be able to say which IP
> you've got, this also makes it easier to implement support for new
> IP features later on without having to go back and add new
> properties which would be sad.

That seems quite reasonable, but I don't think everyone involved in DT
has come out and agreed on that. I'm quite happy with the approach of
looking up everything based on compatible.

>> (although I dare say that at least samsung,supports-rstclr should
>> be modified to use the new reset controller bindings)
> 
> Really?  That doesn't seem terribly sane - I had thought that was
> for bodging resets on the side of things that don't normally have
> them or need board specific logic.  Also note that this is actually
> a magic register write done to reset the IP on some specific IPs.

I believe that's exactly what the reset subsystem and associated DT
bindings were designed for.

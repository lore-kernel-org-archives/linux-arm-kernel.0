From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Nov 2013 09:37:07 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <2443024.JdDKnfkC18@wuerfel>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <1432962.yW4lKnaQJE@flatron> <25161583.XICaeMWvPh@flatron>
 <2443024.JdDKnfkC18@wuerfel>
Message-ID: <5277CD33.6030003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 02:28 AM, Arnd Bergmann wrote:
> On Monday 04 November 2013 00:26:29 Tomasz Figa wrote:
>>
>> Aha, one more thing. As it was mentioned on ARM Mini Summit, as a long 
>> term goal, we will eventually have to introduce another validation tool 
>> that checks device drivers against device tree bindings. We should keep 
>> this in mind when considering schema design.
> 
> Incidentally I have just had an idea for a new driver-level API that
> should let us do this much easier. I hope to find some time in the
> next few days to come up with draft kernel patches. If you don't hear
> back from me soon but want to work on validating the drivers against
> the bindings, please contact me again.
> 
> The basic idea is to extend 'devres' to automatically register
> all the resources (registers, irq, dma, gpio, pinctrl, clk, regulator, ...)
> and simple properties before the ->probe() callback is even called,
> based on a per-driver data structure that describes them, and that
> can be easily parsed by an external tool.

I had suggested that while talking to someone at the kernel summit,
basically each driver supplies functions like:

1) ACPI -> platform data or resources converter
2) DT -> platform or resources data converter
3) anything else -> platform or resources data converter
4) probe()

One of (1)..(3) (depending on device instantiation source) is called to
translate the data source to platform data or resources, before probe
(and could indeed handle much of deferred probe I suppose).

(4) is called to actually initialize the device, and always has complete
pre-parsed platform data/resources available, and does no DT/ACPI/...
parsing.

I forget who I was talking to, but it was asserted something like this
had been proposed before, and wasn't accepted. Unfortunately, I don't
entirely recall why...

It may have been due to the fact I proposed (1) and (2) above being
separate, rather than identical, due to using some unified API to read
data from ACPI and DT. That wasn't the most interesting aspect of the
proposal though. Still, I think conceptually there could be other data
sources in the future, so we may need to allow different types of
conversion function at some point, even if the ACPI and DT
implementations can end up being the same.

From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 21 Sep 2016 08:30:53 +0100
Subject: [PATCH 2/4] ARM: tegra: nyan: Use external control for bq24735
 charger
In-Reply-To: <1474394567.1215.14.camel@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-2-contact@paulk.fr>
 <00697eef-0b36-1ff5-9c7a-43c1b53b52bc@nvidia.com>
 <1474394567.1215.14.camel@paulk.fr>
Message-ID: <90828c8d-e46d-0956-d6b3-e88fc90f3049@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/09/16 19:02, Paul Kocialkowski wrote:
> * PGP Signed by an unknown key
> 
> Le mardi 20 septembre 2016 ? 18:40 +0100, Jon Hunter a ?crit :
>> On 28/08/16 18:32, Paul Kocialkowski wrote:
>>>  
>>> Nyan boards come with an embedded controller that controls when to
>>> enable and disable the charge. Thus, it should not be left up to the
>>> kernel to handle that.
>>>  
>>> Using the ti,external-control property allows specifying this use-case.
>>  
>> So the bq24735 is populated under the EC's 'i2c-tunnel' property which
>> is there to specifically interface it's child devices to the host. So I
>> am a bit confused why this is expose to the host if it should not be used?
> 
> Well, it needs to access the information in the read-only registers provided by
> the chip, which is allowed by the setup in place that you described.

Is this to expose the current state to the kernel so we can monitor the
battery state?

> However, the EC has its internal state machine that decides when to start
> charging, etc and so should be the only one to write registers, to avoid
> conflicts.
> 
>> Again you may right and I did find the original series [0] for this
>> which specifically references the Acer Chromebook that needs this.
>> However, I am not sure why this was never populated? Is there any other
>> history here?
> 
> I am also confused about why it wasn't applied earlier. However, the cros kernel
> is using the very same scheme.

Do you have a reference?

>> What is the actual problem you see without making this change?
> 
> There is a risk of conflict (even though it's probably not that significant),
> given the low variety of possible cases here. The idea is simply to say that the
> EC is in charge and to let it do its job without interfering.
> 
>> The original series states ...
>>  
>> "On Acer Chromebook 13 (CB5-311) this module fails to load if the
>> charger is not inserted, and will error when it is removed."
> 
> I'm confused about that comment. At this point (and with this patch), it works
> normally.

Ok, I think Thierry prefers to only apply fixes for problems that can be
reproduced. Is there a simple way to check the battery status and
charging status via say the sysfs? If I can test that this has no
negative impact may be it is ok.

Cheers
Jon

-- 
nvpublic

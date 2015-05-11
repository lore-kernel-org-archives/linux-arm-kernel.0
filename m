From: lho@apm.com (Loc Ho)
Date: Mon, 11 May 2015 15:29:10 -0700
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <2154265.kZOTsisCx2@wuerfel>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <20150506182900.GI22949@pd.tnic>
 <CAPw-ZTmJ8C3KmujZJN1z21S3LFQ-TRouUeAjN0Y02HOTKAG1_g@mail.gmail.com>
 <2154265.kZOTsisCx2@wuerfel>
Message-ID: <CAPw-ZT=ubrjAvgTHBthzYQC7faSbaOvyFgX81=vcaiWKA8+bug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>>
>> On Wed, May 6, 2015 at 11:29 AM, Borislav Petkov <bp@alien8.de> wrote:
>> > On Wed, May 06, 2015 at 11:12:20AM -0700, Loc Ho wrote:
>> >> 1. Whether to have an single driver for APM EDAC or multiple instance
>> >> of 4 different drivers. With single driver, it does not scale in the
>> >> future when we add/remove memory controllers and CPU domains. This is
>> >
>> > Why doesn't it scale? Please explain this to me more verbosely.
>>
>> Let me explain a bit more. We have four memory controller today.
>> Therefore, I would like to have 4 DTS node and the same driver probe
>> function called 4 times. If there is only one driver for the entire
>> APM EDAC, I would have to merge all the resource registers into an
>> single DTS node and its probe function called one time. In this one
>> driver design, what would I do in future chip or variant of the chip
>> in which it remove or add an addition memory controller? I would have
>> to change the driver as well as the DTS node. In the four instance
>> probe design, all I need is to add an additional DTS node.
>
> There are lots of possible representations in DT that would solve this.
>
> First of all, a device node can be turned into a platform_device but
> does not have to, so you you could have one DT node for the common
> parts (the pcp), and then subnodes underneath it, and have the driver
> attach to the main device but parse the subnodes manually to see
> what registers are there. There is no magic involved here, and this
> would address the concerns that Boris and I have.
>
> Another option would be to have multiple drivers: have one driver
> that handles the common parts here, and make that export a shared
> interface to which the other drivers can register, then create
> five drivers that each do one thing. In my opinion that would work
> just as well, and be a nice abstraction, but I suspect that Boris
> would prefer doing it the other way.

Thanks all for the comment. I will follow the design as with
gpio-dwapb driver. This would take care of Borislav concern as
mentioned by Arnd.

-Loc

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 16 Apr 2015 15:41:34 +0200
Subject: [PATCH v4 04/10] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <552FB4DF.1030403@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
 <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
 <552EB7F0.2090106@gmail.com> <552FB4DF.1030403@free-electrons.com>
Message-ID: <552FBC0E.20004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2015 03:10 PM, Ezequiel Garcia wrote:
> On 04/15/2015 04:11 PM, Sebastian Hesselbarth wrote:
>> On 15.04.2015 19:24, Antoine Tenart wrote:
>>> Rework the pxa3xx_nand driver to allow using functions exported by the
>>> nand framework to detect the flash and to configure the timings.
>>>
>>> Because this driver supports some non-ONFI devices, we also keep the
>>> custom timing setup of this driver so these devices won't break.
>>>
>>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>>> ---
>> [...]
>> How about we get rid of the driver specific timings completely
>> and pick up the best onfi timing match instead? The nand_ids table
>> allows for a default_onfi_timing parameter even if onfi itself is
>> not supported.
>>
>> For generic flash, i.e. no specific entry in the nand_ids table,
>> we either choose onfi mode 0 (most conservative) or an even slower
>> one.
>>
>
> I think Robert mentioned [1] that using "ONFI default timings" on
> non-ONFI devices didn't work for him.
>
> [1] https://lkml.org/lkml/2015/3/8/124

Ok, I see. But there is still the option to pass board specific
timings with driver's platform_data. We could use

(a) pdata timings if passed
(b) onfi timings if available
(c) equivalent onfi timings if set
(d) conservative equivalent onfi timings otherwise

All we need is a function to convert sdr_timings to sane driver
timings. And we really need to split this patch into tiny pieces
otherwise it is not reviewable - or at least I need a full overview
about the driver first.

Also, as soon as Robert moves pxa3xx boards fully to DT, we'll loose
the pdata timings option above. *sigh*

Thoughts?

Sebastian

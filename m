From: lho@apm.com (Loc Ho)
Date: Wed, 6 May 2015 11:43:36 -0700
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <20150506182900.GI22949@pd.tnic>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <2150970.xGYLhDU9BR@wuerfel>
 <CAPw-ZTkuZWNM9D_wJRfQq009KeL1coyYKXhqhWV+FWW6C=xRiA@mail.gmail.com>
 <20150506182900.GI22949@pd.tnic>
Message-ID: <CAPw-ZTmJ8C3KmujZJN1z21S3LFQ-TRouUeAjN0Y02HOTKAG1_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On Wed, May 6, 2015 at 11:29 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, May 06, 2015 at 11:12:20AM -0700, Loc Ho wrote:
>> 1. Whether to have an single driver for APM EDAC or multiple instance
>> of 4 different drivers. With single driver, it does not scale in the
>> future when we add/remove memory controllers and CPU domains. This is
>
> Why doesn't it scale? Please explain this to me more verbosely.

Let me explain a bit more. We have four memory controller today.
Therefore, I would like to have 4 DTS node and the same driver probe
function called 4 times. If there is only one driver for the entire
APM EDAC, I would have to merge all the resource registers into an
single DTS node and its probe function called one time. In this one
driver design, what would I do in future chip or variant of the chip
in which it remove or add an addition memory controller? I would have
to change the driver as well as the DTS node. In the four instance
probe design, all I need is to add an additional DTS node.


>
>> also agreed by Rob Herring from review of the DTS nodes. For L3 and
>> SoC EDAC, they are less of an issue as I don't see a situation that we
>> would have multiple instances.
>>
>> 2. With regard to the top level PCP interrupt, they are just for
>> status and once configured, it will not be touch. Therefore, I keep
>> the current implementation. With an single driver, there is no need to
>> worry about read/modify/write as it will be guarded with an lock. For
>> multiple instance, I am thinking that the xgene_edac_mc module will
>> provide exported lock functions for the other drivers.
>
> Doing this would be a very bad design and it would be a homegrown case
> only for this driver. Then other ARM drivers will appear which will do
> their own locking too. No no no. No ad-hoc hackery.
>

What if I move the locking function into a common module to be
included by the EDAC framework? Or would you prefer that I go and
write an common driver that all it does is provide locking?

Any suggestion as all I need is an way to share access to an CSR which
can't use atomic operations? It isn't an actual interrupt controller
either.

-Loc

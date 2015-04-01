From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 31 Mar 2015 21:03:31 -0700
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <CAM4voanzd-iiyTbGvZpTz4nmULJu9_VUFz3EibLB5L295K4P-Q@mail.gmail.com>
 (Abhilash Kesavan's message of "Wed, 1 Apr 2015 08:49:14 +0530")
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <7hiodg98z7.fsf@deeprootsystems.com>
 <CAM4voanzd-iiyTbGvZpTz4nmULJu9_VUFz3EibLB5L295K4P-Q@mail.gmail.com>
Message-ID: <7h1tk47awc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan <kesavan.abhilash@gmail.com> writes:

> On Wed, Apr 1, 2015 at 2:32 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:
>>
>> [...]
>>
>>> Unfortunately I don't fully understand why this clock needs to be
>>> enabled. It would be good if someone at Samsung can explain in more
>>> detail what the real problem really is.
>>
>> +1
>>
>> Maybe Abhilash can shed some light here?
>>
>> We really should know *why* this is needed because having the fix in the
>> clock driver just doesn't seem right.  It seems like the DMA driver
>> should be managing this clock.
>
> I think my last mail might not have reached you (was accidentally sent
> as html). 

Yeah, I saw it a bit later in Javier's reply.  Thanks for doing the
research and reporting back.

> We are gating the aclk266_g2d clock without checking the
> CG_STATUS0 register bits as specified in the UM. It looks like we need
> to keep several clocks alive or gate them only after checking the
> CG_STATUSx register bits.

I dont' know much about this clock hardware, but to me it sounds like a
clock driver bug.  The suspend fix Javier is proposing would fix it, but
to me it sounds like the clock driver needs to actually start checking
these CG_STATUSx bits before gating clocks.

Otherwise, we might fix this current bug but a similar one will come and
bite us another day.

Kevin

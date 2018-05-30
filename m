From: collinsd@codeaurora.org (David Collins)
Date: Wed, 30 May 2018 16:58:54 -0700
Subject: [PATCH v4 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=WF+onhAAWrbmwcHiWyCjuZ=6vvnhodUsia=Ps-da6_4A@mail.gmail.com>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <7489cd65fedb8a31488cf8188885759bcd4820ce.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=WF+onhAAWrbmwcHiWyCjuZ=6vvnhodUsia=Ps-da6_4A@mail.gmail.com>
Message-ID: <5e65b713-6d45-4b33-d05e-6ebe2c6b6cec@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 05/29/2018 10:32 PM, Doug Anderson wrote:
> On Tue, May 22, 2018 at 7:43 PM, David Collins <collinsd@codeaurora.org> wrote:
>> + * @ever_enabled:              Boolean indicating that the regulator has been
>> + *                             explicitly enabled at least once.  Voltage
>> + *                             requests should be cached when this flag is not
>> + *                             set.
> 
> Do you really need this extra boolean?  Can't you just check if
> "enabled" is still "-EINVAL"?  If it is then you don't pass the
> voltage along.
> 
> ...this would mean that you'd also need to send the voltage vote when
> the regulator core tries to disable unused regulators at the end of
> bootup, but that should be OK right?  If we never touched a regulator
> anywhere at probe time and we're about to vote to disable it, we know
> there's nobody requiring it to still be on.  We can vote for the
> voltage now without fear of messing up a vote that the BIOS left in
> place.
> 
> In theory this should also allow you to assert your vote about the
> voltage of a regulator that has never been enabled, which (if I
> understand correctly) you consider to be a feature.

Removing 'ever_enabled' and caching the voltage when 'enabled == -EINVAL'
seems workable.  I'm a little concerned about this resulting in voltage =
regulator-min-microvolt requests being sent for all regulators that are
not explicitly enabled by Linux consumers before late_initcall_sync().
Theoretically all of the boot loader hand-off cases should be taken care
of by this point so it should be safe.

I'll make this change.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

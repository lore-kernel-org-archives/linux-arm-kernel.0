From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 09:09:55 -0700
Subject: [PATCH] RFC: pinctrl: grab default handler with bus notifiers
In-Reply-To: <CACRpkdYd6B-fTfUg18q5BjZRbY7sUAUNXA_7VPBs9SQoug9Q4w@mail.gmail.com>
References: <1352636539-6318-1-git-send-email-linus.walleij@stericsson.com>
 <50A15A54.3090803@wwwdotorg.org>
 <20121113063546.GD18224@opensource.wolfsonmicro.com>
 <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
 <50A53304.6040904@wwwdotorg.org>
 <CACRpkdYd6B-fTfUg18q5BjZRbY7sUAUNXA_7VPBs9SQoug9Q4w@mail.gmail.com>
Message-ID: <50A66553.3050705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 04:36 AM, Linus Walleij wrote:
> On Thu, Nov 15, 2012 at 7:23 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/15/2012 07:03 AM, Linus Walleij wrote:
> 
>>> OK I'll have to come up with a patch to the device core
>>> instead... it'll be much simpler anyway and if both of you guys
>>> can back it I guess Greg might be OK with it too.
>>
>> I did have one thought here; how will this interact with hogs? If a
>> device's pinctrl configuration must be pinctrl_get()'d before the device
>> is probed, then a pinctrl device with hogs will never get probed because
>> it won't be registered to provide the pinctrl node parsing.
> 
> Catch 22 :-(
> 
> Yeah we need to come up with something there.
> 
>> Solutions might include:
>>
>> a) Some special case where if the pinctrl driver only can't probe due to
>> missing pinctrl from its own node, don't defer the probe, but defer the
>> pinctrl_get().
>>
>> b) Separate out DT node parsing from device instantiation, so that the
>> driver can always parse the DT, without needing the context of a
>> specific pinctrl device to do so.
> 
> But this mechanism can't be device tree-specific, we have some
> of olschool pdata users and ACPI probing around the corner.
> 
> I will likely just cook up something like seeing if the
> dev_name() for provider and consumer is the same and
> in that case avoid deferral.

Well, the DT parsing is all about creating the mapping table from the
DT. Without DT, this doesn't need to happen, since the board file
already contains the complete mapping table. So, this isn't so much a
special case for DT, but rather simply a step we don't need to take for
DT, if you get what I mean (and that's all true irrespective of the
change we're discussing here).

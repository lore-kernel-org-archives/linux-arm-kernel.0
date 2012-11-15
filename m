From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Nov 2012 11:23:00 -0700
Subject: [PATCH] RFC: pinctrl: grab default handler with bus notifiers
In-Reply-To: <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
References: <1352636539-6318-1-git-send-email-linus.walleij@stericsson.com>
 <50A15A54.3090803@wwwdotorg.org>
 <20121113063546.GD18224@opensource.wolfsonmicro.com>
 <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
Message-ID: <50A53304.6040904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 07:03 AM, Linus Walleij wrote:
> On Tue, Nov 13, 2012 at 7:35 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Nov 12, 2012 at 01:21:40PM -0700, Stephen Warren wrote:
>>> On 11/11/2012 05:22 AM, Linus Walleij wrote:
>>
>>>> Another solution that was discussed was whether to move
>>>> the default pinctrl handle and state grab to the device
>>>> core as an optional field in struct device itself, but
>>>> I'd like to first propose this less intrusive mechanism.
>>
>>> I think doing that approach makes a lot more sense; wouldn't it
>>> completely avoid the issues with deferred probe that this notifier-based
>>> method can't solve? It would also be very much in line with e.g.
>>> dev_get_regmap() - if every resource that a driver required were handled
>>> like that, then deferred probe could be significantly isolated into the
>>> driver core rather than in every driver...
>>
>> I have to say that I agree with this, notifiers seem to make life more
>> complicated for limited gain.  Otherwise I guess we could enhance
>> notifiers so that they're able to trigger deferrals?
> 
> OK I'll have to come up with a patch to the device core
> instead... it'll be much simpler anyway and if both of you guys
> can back it I guess Greg might be OK with it too.

I did have one thought here; how will this interact with hogs? If a
device's pinctrl configuration must be pinctrl_get()'d before the device
is probed, then a pinctrl device with hogs will never get probed because
it won't be registered to provide the pinctrl node parsing. Solutions
might include:

a) Some special case where if the pinctrl driver only can't probe due to
missing pinctrl from its own node, don't defer the probe, but defer the
pinctrl_get().

b) Separate out DT node parsing from device instantiation, so that the
driver can always parse the DT, without needing the context of a
specific pinctrl device to do so.

I haven't thought through this in any detail though.

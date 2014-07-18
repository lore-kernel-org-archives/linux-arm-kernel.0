From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jul 2014 20:45:32 -0600
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>	<1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>	<20140707004417.GE8469@quad.lixom.net>	<20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
Message-ID: <53C88A4C.3070304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 11:47 AM, Olof Johansson wrote:
> On Tue, Jul 8, 2014 at 6:43 AM, Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
>> On Mon, Jul 07, 2014 at 02:44:17AM +0200, Olof Johansson wrote:
>>> On Mon, Jun 23, 2014 at 03:23:45PM -0600, Stephen Warren wrote:
>>>> This branch moves code related to the Tegra fuses out of arch/arm and
>>>> into a centralized location which could be shared with ARM64. It also
>>>> adds support for reading the fuse data through sysfs.
>>>
>>> The new/moved misc driver isn't acked by any misc maintainer, so I can't
>>> take this branch.
>>>
>>> I saw no indication from searching the mailing list of that either,
>>> so it wasn't just a missed acked-by.
>>>
>>> I wonder if this code should go under drivers/soc/ instead?
>>
>> It's modelled after sunxi_sid.c which lives in drivers/misc/eeprom/.
>> Originally this driver was also in drivers/misc/eeprom/, but Stephen objected
>> and therefore it was moved to drivers/misc/fuse. I think that's the right
>> place still.
> 
> I disagree, I think this belongs under drivers/soc. Especially since
> you're adding dependencies on this misc driver from other parts of the
> kernel / other drivers.
> 
> I also don't like seeing init calls form platform code down into
> drivers/misc like you're adding here. Can you please look at doing
> that as a regular init call setup?

I strongly disagree with using init calls for this kind of thing. There
are ordering dependencies between the initialization code that can only
be sanely managed by explicitly calling functions in a particular order;
there's simply no way to manage this using initcalls. This is exactly
why the hooks in the ARM machine descriptors exist...

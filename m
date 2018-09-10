From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 10 Sep 2018 14:22:24 +0200
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <20180910141820.6c715895@bbrezillon>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org>
 <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
 <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
 <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
 <20180910141820.6c715895@bbrezillon>
Message-ID: <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-10 14:18 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> Hi Srinivas,
>
> On Mon, 10 Sep 2018 12:47:19 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> On 10/09/18 12:31, Bartosz Golaszewski wrote:
>> > About that: there are no users of nvmem_device_cell_read/write()
>> > currently and with the new API I'm not sure this is still needed. Are
>> > you alright with removing those two?
>>
>> Why do you want to remove them? Other than reason of no users.
>
> I'm just sharing my (and probably other maintainers/developers) PoV
> here, so please don't take this as an attempt to force you to change
> your mind, but rather an attempt at explaining why APIs usually stay
> private when they have no users.
>
> Kernel maintainers tend to reject APIs that have no users because
> adding something that nobody needs yet is hard to get right. I mean,
> you can design an API on what you think will be needed/appropriate, and
> then, when people actually start needing this feature, they realize it
> does not quite match what they need, and they have to adjust/rework
> this API.
>
>>
>> All it boils down to if we support device based apis using cell info or
>> not?
>
> But it looks like nobody is actually using it, and the first potential
> user (Bart) proposed a different approach with the nvmem cell table
> declaration.
>
>> IMO, I see no harm in leaving these apis as it is, unless there is a
>> strong reason to do so.
>
> It's harmless, but it's also unused. If people start using it and you
> realize the API is not working for some use cases, then you'll have to
> patch all existing users.
>
> All this being said, it's your call to make, and if you think it makes
> sense to keep these functions around for any reason, then be it.
>

Also: the general notion in most subsystems is that drivers should be
generalized enough to not have to care about the provider's internals,
which is the case if we allow users to specify cell info. They should
just query the subsystem for a given resource, use it, then put it.
Fortunately this is what all current users do in this case - we don't
even have any users of nvmem_device_get() which is good since it
should be reserved for very special cases.

While one can argue that nvmem_device_cell_read/write() may be needed
in some strange corner case now, once we add the cell lookup API, we
can safely remove it and force users to do the right thing.

Best regards,
Bartosz Golaszewski

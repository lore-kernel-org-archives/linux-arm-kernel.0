From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 7 Sep 2015 14:31:06 +0200
Subject: [PATCH v3 02/18] of/platform: add of_platform_probe
In-Reply-To: <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150807121913.GS20873@sirena.org.uk>
 <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
Message-ID: <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 August 2015 at 11:37, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 7 August 2015 at 14:19, Mark Brown <broonie@kernel.org> wrote:
>> On Thu, Aug 06, 2015 at 04:11:39PM +0200, Tomeu Vizoso wrote:
>>
>>> Walks the OF tree up and finds the closest ancestor that has a platform
>>> device associated with it, probing it if isn't bound to a driver yet.
>>
>>> The above should ensure that the dependency represented by the passed OF
>>> node is available, because probing a platform device should cause its
>>> descendants to be probed as well.
>>
>> This sounds like it's going to break in the case where we have MFDs that
>> represent their functions in DT (not a pattern I'm a fan of but it's a
>> thing people do).  We'll walk back to the platform device for the MFD
>> function, try to probe it and then give up.  Perhaps that's good enough
>> anyway but it's not clear to me why we don't just try every parent we
>> find?
>
> Agreed. In the attempt at probing dependencies before a device is
> probed, I considered that a device's parent is also a dependency and
> that worked well. From what I saw, few devices will defer their probe
> if their parent hasn't been probed yet, assuming that it will have
> probed already. But with simple-mfd and simple-bus that shouldn't be
> relied upon as things will break if their parents defer their probe.
> With async probing enabled this failure scenario becomes more
> probable.

Actually I'm not sure how we could probe the ascendants on demand, as
currently the parent's device lock is taken when probing so trying to
probe a sibling from within a probe callback will cause a deadlock.

AFAICS this is only needed for USB interface devices and this
behaviour could be limited to them, but I don't like much assuming
that no USB device will ever have a dependency on a sibling (though
that probably won't happen ever).

Regards,

Tomeu

>> I'm also not a fan of the fact that the interface here is explicitly
>> saying that we want to probe a platform device, that's an implementation
>> detail that callers shouldn't need to know about.  From the point of
>> view of the callers what they're trying to do is kick any dependencies
>> into being instantiated, the fact that we currently try to accomplish it
>> with platform devices isn't something they care about.
>
> Agreed.
>
> Thanks,
>
> Tomeu

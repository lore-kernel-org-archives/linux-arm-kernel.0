From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 05 Aug 2010 08:19:19 -0700
Subject: [linux-pm] [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
In-Reply-To: <AANLkTinv2ZpLaRYEN+FVwuX1QTK_+568K8BckVp_tx=K@mail.gmail.com>
	(Grant Likely's message of "Wed, 4 Aug 2010 16:54:59 -0600")
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
	<34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
	<AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
	<87k4o7r7sv.fsf@deeprootsystems.com>
	<AANLkTinv2ZpLaRYEN+FVwuX1QTK_+568K8BckVp_tx=K@mail.gmail.com>
Message-ID: <87mxt11408.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Tue, Aug 3, 2010 at 10:16 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Magnus Damm <magnus.damm@gmail.com> writes:
>>
>>> On Sun, Jul 25, 2010 at 5:24 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>>> "Magnus Damm" <magnus.damm@gmail.com> wrote:
>>>>>On Tue, Oct 27, 2009 at 8:13 AM, Kevin Hilman
>>>>><khilman@deeprootsystems.com> wrote:
>>>>>> Eric Miao <eric.y.miao@gmail.com> writes:
>>>>>>> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
>>>>>>> <khilman@deeprootsystems.com> wrote:
>>>>>>>> Mikael Pettersson wrote:
>>>>>>>>> Eric Miao writes:
>>>>>>>>> ?> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>>>>>>> ?> <khilman@deeprootsystems.com> wrote:
>>>>>>>>> ?> > On ARM platforms, power management can be very platform specific.
>>>>>>>>> ?> > This patch allows ARM subarches to extend the platform_device
>>>>>>>>> ?> > pdev_archdata for each subarch by creating a new struct pdev_machdata
>>>>>>>>> ?> > and allowing each subarch to customize it as needed.
>>>
>>>>>Do you remember what happened with this patch?
>>>>
>>>> I don't have all the details in front of me because I'm on my phone,
>>>> but I advised against pdev_archdata because it is
>>>> multiplatform-unfriendly.
>>>
>>> Ok, I did not expect that. =) But after thinking a bit it does make
>>> sense. I wonder what my options are. I'm not so fond of the idea to
>>> wrap the platform devices - that's not more multi-platform friendly,
>>> is it?
>>
>> [sorry for the lag, been on vacation]
>>
>> Wrapping is more multi-platform friendly because only platform-specific
>> code accesses the wrapped code. ?It's also logically consistent as
>> a struct device is contained by a platform_device which is then
>> contained by an omap_device (in our case.) ? Only OMAP-specific code
>> ever knows about or touches that layer.
>
> (I just noticed this; will also reply on the other thread so it is
> recorded in the public record) But it is also really dangerous;
> particularly in the case of dynamically allocated platform_devices.
> When handed a random platform_device pointer, you have absolutely *no*
> idea whether or not it is valid to dereference a pointer at a lower
> address from the platform_device pointer.  It is very likely that
> there will be other code in the system that will register
> platform_devices without the omap_device wrapper.
>
>>> How about using devres and platform bus notifiers?
>>
>> That seems fine too, and probably better if the amount of data/code you need
>> is small. ?In the OMAP case, it's rather complicated so it's cleaner
>> IMHO to keep it in a separate omap_device layer and struct.
>
> but it is safe
>

/me is beaten into submission.  ;)

OK, it would not be too much work to move the OMAP implementation to
devres + notifiers either.  I can give it a spin.

Kevin

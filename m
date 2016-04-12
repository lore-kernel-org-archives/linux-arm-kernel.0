From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 12 Apr 2016 13:39:58 +0200
Subject: [PATCH v5 RESEND 4/5] ARM: amba: Move reading of periphid to
 amba_match()
In-Reply-To: <CAPDyKFph8O+P9F124R859+OqY7B0YXCm=oOGxviyOo6tkNPQzQ@mail.gmail.com>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
 <20160215175250.GJ10826@n2100.arm.linux.org.uk>
 <56C426C4.7040907@samsung.com>
 <20160217200828.GH19428@n2100.arm.linux.org.uk>
 <CAPDyKFph8O+P9F124R859+OqY7B0YXCm=oOGxviyOo6tkNPQzQ@mail.gmail.com>
Message-ID: <CAPDyKFpjTOhmG69x=EP=jje76C1ijjh0m_N8PrJ3yxqRq3HFiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- trimmed cc list

On 2 March 2016 at 11:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 February 2016 at 21:08, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Feb 17, 2016 at 08:52:36AM +0100, Marek Szyprowski wrote:
>>> Then the only solution right now I see is to get back to v1:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388199.html
>>> which at least handles correctly device registration when power domain
>>> driver is available.
>>
>> ... and which has the ability to break platforms if the PM domain is
>> not already available.
>>
>> What's wrong with the patch in the link above _combined_ with a patch
>> which addresses the concern I have with that patch: build a list of
>> the failed-to-register devices, and retry them later - maybe from a
>> late_initcall(), or a similar mechanism?
>
> This will improve the robustness of the device registration process,
> but I wonder if it's really worth the efforts of complicating the amba
> device registration code.
>
> The problem I see with such approach, is to know *when* shall we retry
> to register the devices.
>
> We will rely on the PM domain driver to be probed, as to have the
> corresponding OF genpd provider registered, else the device
> registration will continue to fail.
> Now, I don't think there are PM domain drivers as removable modules
> (yet), but in such cases a late_initcall won't help much.
>
>>
>> My view is the risk to existing systems is _too_ high to apply either
>> this patch, or the patch you link to above, and I refuse to play the
>> "lets apply it and see if we break anything" lottery with this.
>
> I agree!
>
> Although I think with some adjustments, perhaps we can move forward with v1?
>
> The adjustments I think is needed:
> Instead of propagating the error code from dev_pm_domain_attach(),
> let's print a debug message and continue the device registration.
> In that way, we shouldn't introduce regressions for cases where the OF
> genpd provider hasn't yet been registered, but the issue Marek is
> trying to solve for Exynos should be fixed.
>
> What do you think?
>

Ping. Any news on this? Would be nice if we could agree on a way forward.

Kind regards
Uffe

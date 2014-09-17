From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 17 Sep 2014 20:25:44 +0200
Subject: [v4, 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
In-Reply-To: <4451285.EDb1j6ttbA@vostro.rjw.lan>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org>
 <6318611.DnX9cEgMjk@vostro.rjw.lan>
 <20140915165359.GA13080@core.coreip.homeip.net>
 <4451285.EDb1j6ttbA@vostro.rjw.lan>
Message-ID: <CAPDyKFq6FZcuU=TCMh0JE0ymbS73_eLtNrTgmgKA4OxEp=_zpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 September 2014 01:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, September 15, 2014 09:53:59 AM Dmitry Torokhov wrote:
>> On Sun, Sep 14, 2014 at 06:38:58PM +0200, Rafael J. Wysocki wrote:
>> > On Friday, September 12, 2014 02:05:53 PM Dmitry Torokhov wrote:
>> > > Hi Ulf,
>> > >
>> > > On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
>> > > > To give callers the option of acting on a errors while removing the
>> > > > pm_domain ops for the device in the ACPI PM domain, let
>> > > > acpi_dev_pm_detach() return an int to provide the error code.
>> > >
>> > > So how would callers handle the errors? As far as I can see
>> > > acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
>> > > there is no meaningful strategy to handle errors as you are past the point of
>> > > no return and you keep on tearing down the device.

The benefit is only relevant when ACPI and genpd PM domains would
co-exist. In that case we might be able to skip genpd_dev_pm_detach()
if acpi_dev_pm_detach() succeeds. So, currently there are  no benefit,
but still it doesn't hurt.

>> >
>> > This is specifically for what patch [3/9] is doing AFAICS.
>> >
>> > The existing callers don't need to worry about this.
>>
>> OK, so I have the very same comment about patch 3 then: we have
>> dev_pm_domain_detach() returning error. How would the callers handle errors?
>
> Ulf?

I see your point. How about making dev_pm_domain_detach() to be a void
function instead?

>
>> WRT this patch: I'd rater we did not just return generic "error code" just
>> because we do not know who manages PD for the device. Can we add API to check
>> if we are using ACPI to manage power domains? Then patch #3 could check if it
>> needs to use ACPI or generic power domain API.

The problem is scalability. If we have other PM domains implementation
in future, each of them need to be checked prior invoking the attach
functions.
Also, how would we distinguish between genpd and a new PM domain XYZ?

Kind regards
Uffe

>
> The rule is that if there is an ACPI companion object for the given device, then
> ACPI is used.  So the API is ACPI_COMPANION(dev) and we have that check around
> until someone realized that acpi_dev_pm_attach/detach() made it too.  We can
> restore it, I suppose, but I'm not sure how much better it is going to be.
>
> Either way, I have no strong preferences here.
>
> Rafael
>

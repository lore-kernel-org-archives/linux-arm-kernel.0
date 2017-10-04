From: opendmb@gmail.com (Doug Berger)
Date: Tue, 3 Oct 2017 19:09:23 -0700
Subject: [PATCH 2/7] gpio: brcmstb: release the bgpio lock during irq
 handlers
In-Reply-To: <CADtm3G58SBF0FskUPJCs_8km8oXrKYs-+hrJoV4osyw9mvQbiQ@mail.gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-3-opendmb@gmail.com>
 <CADtm3G58SBF0FskUPJCs_8km8oXrKYs-+hrJoV4osyw9mvQbiQ@mail.gmail.com>
Message-ID: <2cdf149b-f034-d98a-e77a-e2779a0d1e47@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2017 06:55 PM, Gregory Fong wrote:
> Hi Doug,
> 
> On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
>> The basic memory-mapped GPIO controller lock must be released
>> before calling the registered GPIO interrupt handlers to allow
>> the interrupt handlers to access the hardware.  Otherwise, the
>> hardware accesses will deadlock when they attempt to grab the
>> lock.
> 
> I was having some trouble understanding exactly what the problem was
> here, but I think I see it now.  Since this locks the entire bank,
> where some GPIOs might be set as inputs and some as inputs (and
> interrupt sources), then an interrupt on a GPIO that is supposed to
> set another GPIO in the bank would result in deadlock.  Is that
> correct?  If so, please update the commit message to make that clear,
> and nice fix.  If not that, it would be nice to know what scenario can
> cause a problem.

That is an example, but there are really many possibilities.

Basically, if a registered interrupt handler wants to access its GPIO
you are likely to run into trouble.  Another example might be an
interrupt that is configured to trigger on either edge transition and
the handler wants to know whether the input is currently high or low.

I can submit a V2 with a change in the description if you would like,
but I'm not sure what the clearest example would be.

> 
> Thanks,
> Gregory
> 

Thanks for the feedback,
    Doug

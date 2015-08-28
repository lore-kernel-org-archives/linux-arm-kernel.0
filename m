From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 27 Aug 2015 17:24:13 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
 (Dmitry Torokhov's message of "Tue, 25 Aug 2015 16:47:58 -0700")
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
 <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
Message-ID: <7hmvxc45w2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Aug 25, 2015 at 3:45 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Doug Anderson <dianders@chromium.org> writes:
>>
>>> To put things in a
>>> concrete way, for pd_vio we'd go through the entire device tree
>>> ourselves and find all properties that look like "power-domains =
>>> <&power RK3288_PD_VIO>;".  We'd then find the parent of those
>>> properties and look for a property named "clocks".  We'd then iterate
>>> over all those clocks and turn those on.  Did I get that right?
>>
>> ... but you make it sound like more work than it is.  The genpd already
>> keeps a list of devices that refer to the power domain.  In fact, the
>> genpd 'attach' method can be platform-specific, so could be used to keep
>> track of a list (or a subset) of clocks which are needed for reset.
>
> That is not really workable: the attach and detach happen in
> probe/remove path; if you do not have driver for the device you will
> miss the clocks for it. 

And in my proposal, I suggested that clocks without drivers are
good candidates to list in the domain, with the caveat that the be
called out (documented) as being device clocks that are missing a
driver, so when a driver shows up they can be moved accordingly, and in
a way that actually describes the hardware.

> And the quirk of this SoC is that we need to
> turn all clocks during domain transition, regardless of whether there
> is a driver for all devices.

I understand.  And that "quirk" is not unique to rockchip socs.

Kevin

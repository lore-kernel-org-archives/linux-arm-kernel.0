From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Nov 2012 11:00:06 -0700
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20121115105954.GA17119@lizard>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org> <20121112082546.GU22029@lunn.ch>
 <50A1212C.2080601@wwwdotorg.org> <20121112181947.GS24583@lunn.ch>
 <20121112184340.GA15643@lizard> <50A146E7.2040608@wwwdotorg.org>
 <CACRpkdb=ra9NwqEneyMoM5YnOFTVQoBxPATjUN6anooXVLiCjw@mail.gmail.com>
 <20121115105954.GA17119@lizard>
Message-ID: <50A52DA6.3070409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 03:59 AM, Anton Vorontsov wrote:
> On Thu, Nov 15, 2012 at 11:35:36AM +0100, Linus Walleij wrote:
>> On Mon, Nov 12, 2012 at 7:58 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 11/12/2012 11:43 AM, Anton Vorontsov wrote:
>>
>>>> Should the gpio driver fix its bindings then?.. Polarity is a quite
>>>> generic concept of a GPIO, and flags are there for a reason. I'd rather
>>>> prefer having
>>>
>>> There is no "GPIO driver" to fix; each GPIO driver has its own bindings,
>>> and unfortunately, some of the GPIO binding authors chose not to include
>>> any flags cell in the GPIO specifier (e.g. Samsung ARM SoCs IIRC, but
>>> there are probably more).
>>
>> So can I read this something like we have been too liberal with the
>> GPIO DT bindings and they are now a bit messy and need to be shaped
>> up? I don't know how to achieve that :-(
> 
> I guess there's really no reason to panic. :)
> 
> 'git grep gpio-cells Documentation/' shows just mrvl-gpio.txt and
> twl6040.txt having the wrong gpio-cells (i.e. 1).

If there are too-few cells, the binding and driver can always be
expanded to support more cells in a backwards-compatible way.

> But even these can use one cells for both flags and pin number (unless you
> really have 4294967295 GPIOs per controller).
> 
> FWIW, current Samsung SOCs use 3 and even 4 cells for a GPIO specifier,
> which is absolutely fine. Plus, the Samsung bindings do specify the
> inversion flag. So, unless we have a lot of other [undocumented] bindings,
> I don't see a big mess. And everything I currently see is fixable.

Oh, I always thought that the Samsung bindings were one of the major
issues here, but you're right - they do have the inversion flag already.

So, perhaps there really isn't an issue, and we should revisit the
GPIO-based regulator bindings and drivers, and allow them to
(additionally) rely on the GPIO flags in the standard way.

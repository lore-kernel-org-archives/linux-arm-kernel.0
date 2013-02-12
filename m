From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 13 Feb 2013 00:59:28 +0900
Subject: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <CACRpkdaHuv7CXCy15-o94G0r0+2BStsi34ZVbBAhyGj=U3xgOg@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
 <CACRpkdbib-+pvMiLQN=f6d-1dhK2OK3znJeGoL7rDxDQYuJRuA@mail.gmail.com>
 <CAAVeFu+phNtzzj7rw96g9iH8sj9gGqd5SfAqtkDHvu3PeL_oQA@mail.gmail.com>
 <20130209091729.978C73E1A18@localhost>
 <CACRpkdagLssOG3FW8Qr1zqFabGMgdupADwg1=c0eQ7e76_XM5A@mail.gmail.com>
 <51192CC5.9060300@wwwdotorg.org>
 <CACRpkdaHuv7CXCy15-o94G0r0+2BStsi34ZVbBAhyGj=U3xgOg@mail.gmail.com>
Message-ID: <20130212155927.GE6088@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 01:29:10PM +0100, Linus Walleij wrote:
> On Mon, Feb 11, 2013 at 6:39 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 02/11/2013 07:09 AM, Linus Walleij wrote:
> 
> >> However if you take this all the way to the descriptor API
> >> it will make the consumer (driver) API for GPIO descriptors deviate
> >> from what is today used for clocks, regulators and pins.
> >>
> >> With all the resulting confusion for users.
> >> I've seen worse subsystem deviations though.
> >
> > Sorry I haven't looked at the specific APIs this discussion refers to,
> > but clients of the GPIO descriptor API are going to need to distinguish
> > "fail" from "deferred probe", so at least some initial get-like API will
> > need to pass back some error detail...
> 
> Right, so in some other patch I stated that this would lead
> to a GPIO descriptor fetch interface such as this:
> 
> int gpiod_get(struct gpiod_desc **gpiod, struct device *dev, const char *name);
> 
> Rather than the more established:
> 
> struct gpio_desc *gpiod_get(struct device *dev, const char *name);
> 
> And I'm worried about the lack of consistency.
> 
> While I do get the point... I chatted with Grant about it and
> I want to talk to some toolchain people about this to see if
> pointers containing potential error codes can somehow be
> "flagged" by the compiler so we can enforce error checking on
> them. (It may sound a bit utopic...)
> 
At the very least you can __must_check annotate, although that's probably
still a bit coarser grained than what you're after.

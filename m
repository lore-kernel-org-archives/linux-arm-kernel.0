From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 9 Feb 2013 14:37:39 +0000
Subject: [PATCH 8/9] gpiolib: use gpio_chips list in gpio_to_desc
In-Reply-To: <CAAVeFuK39k322MeQuzLDibGDSdidrhzqwstSWOPWwCy41Ehg-Q@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
 <20130209095803.61C653E2CF2@localhost>
 <CAAVeFuK39k322MeQuzLDibGDSdidrhzqwstSWOPWwCy41Ehg-Q@mail.gmail.com>
Message-ID: <CACxGe6uLsznC=X7TUnJajqh3GZYE7EQwo2DwTQbWPGvKFLwtSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 9, 2013 at 2:21 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> On Sat, Feb 9, 2013 at 6:58 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> I'm actually going to NAK this one. This is a hot path. Having a O(1)
>> lookup from gpio number to gpio desc is important. I know you want to be
>> rid of the gpio_desc table entirely, but in this case I think it is
>> warranted. However, you can change the gpio_desc table to be a table of
>> pointers to gpio_descs instead of a table of gpio_descs. That would save
>> a lot of memory since unused GPIOs wouldn't have gpio_descs associated
>> with them. It is also the mechanism used by the IRQ subsystem.
>
> That would work - what I don't like is that it still ends being a
> fixed-size static array that is not necessarily tailored to the
> platform's needs. But I understand you don't want to punish the users
> of the integer-based API, even though the penalty should really be
> neglectable here.
>
> Well, maybe I can try to come again with this once everybody uses GPIO
> descriptors instead of integers. ;)

Yes, when everyone uses descriptor handles the problem goes away.
Until then we can just make the table fairly large. If it is pointers
to descs instead of the descs themselves then the memory cost really
isn't that significant.

We could also make the table itself grow dynamically, but I don't
think there is evidence suggesting that is needed. Thomas tried to do
the same thing with the irq desc table and found the resulting code
was far more convoluted than he wanted to support.

g.

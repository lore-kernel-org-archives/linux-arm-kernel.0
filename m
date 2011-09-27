From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 27 Sep 2011 16:28:37 +0300
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <20110927131222.GL2138@amd.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
Message-ID: <CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 4:12 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> You pass a pointer to an unsigned long for the page-size bitmap. This
> allows to use an array of unsigned long. But a single unsigned long is
> sufficient

This is fine; I can change that if you like it better (though without
doing the change below this is probably moot).

> and you can use functions like ffs() and fls() together with
> shifting. These functions often translate to a single intruction in the
> binary. The find_next_bit function has much more overhead because it
> needs to handle the array-of-ulong case.

So you're suggesting to re-implement find_next_bit() using ffs()/fls()
and shifting ?

What's the point ?

Sure, if we'll have a proven performance issue while using
find_next_bit() we can think of doing this, but at this stage, this
sounds to me like a premature optimization which isn't too elegant.

At this point I strongly prefer readable, maintainable and easier to
debug code over optimization which isn't proven to be necessary.

Thanks,
Ohad.

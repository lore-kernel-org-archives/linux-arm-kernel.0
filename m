From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Jan 2011 16:24:17 -0700
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
In-Reply-To: <20110110222524.GE12552@n2100.arm.linux.org.uk>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
	<20110110221802.GD12552@n2100.arm.linux.org.uk>
	<20110110222524.GE12552@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinOWvu5TNMtsrw19-ERc1JpopvQkyp0QH3sQpkL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 3:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 10, 2011 at 10:18:02PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Jan 10, 2011 at 01:58:12PM -0700, Grant Likely wrote:
>> > On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie@jamieiles.com> wrote:
>> > > Some platforms have been known to return NULL from clk_get() if they
>> > > support only a single struct clk. ?Whilst tegra doesn't do this, make
>> > > the drivers consistent with others.
>> > >
>> > > Cc: Erik Gilling <konkers@android.com>
>> > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> >
>> > Hi James,
>> >
>> > If NULL does get returned, say due to a future change to the clock
>> > code, then this change causes the driver to oops. ?I'm not going to
>> > apply this patch.
>>
>> Please apply it - the clock API just defines struct clk as a cookie
>> where errors are IS_ERR/PTR_ERR. ?Other values must be considered by
>> drivers as perfectly valid, including NULL.
>
> Also note that drivers have no business ever dereferencing struct clks.
> So if they oops, that's their own fault for dereferencing something
> that they shouldn't.

I was actually looking at the implementation of clk_enable() which is
called by the driver and doesn't do any NULL checking.  But I suppose
that it then becomes the clock-code's own fault if it returns NULL and
then oopses on a NULL being passed to it.  Okay, I'll apply it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

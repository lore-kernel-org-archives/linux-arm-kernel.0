From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 7 Dec 2009 13:15:08 +0100
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091207113927.GB7279@sortiz.org>
References: <771cded00911130054p2ef293ebse84b1de3cf4fa9fd@mail.gmail.com>
	<20091120150215.GF3733@sortiz.org>
	<771cded00911211625g74601e5die59a680f36903cb3@mail.gmail.com>
	<20091127145820.GA3640@sortiz.org>
	<771cded00911291743u76688d24ja40a30472ebd6af8@mail.gmail.com>
	<20091130101943.GA3696@sortiz.org>
	<771cded00912062334q7f92bf25hb9e7a10f8720812@mail.gmail.com>
	<20091207113927.GB7279@sortiz.org>
Message-ID: <20091207131508.3ed89841@hyperion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Dec 2009 12:39:28 +0100, Samuel Ortiz wrote:
> Hi Haojian
> 
> On Mon, Dec 07, 2009 at 02:34:58AM -0500, Haojian Zhuang wrote:
> > On Mon, Nov 30, 2009 at 5:19 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > > On Sun, Nov 29, 2009 at 08:43:45PM -0500, Haojian Zhuang wrote:
> > >> I tried to add some comments of the chip's background. Up to now, I
> > >> can't find a better idea to handle this driver without mixed structure
> > >> since usb charger linkes them tightly. If there's a better prototype
> > >> to handle this, I'll adopt it.
> > > Thanks for the explanations, I appreciate.
> > > Only the board definition can describe what's the relationship between your
> > > 8806 and 8807, so here is what I propose: Add an i2c address to your 880x
> > > platform data, and have only a 8806 definition on your board specific file.
> > > Then from the 880x driver, you check for the platform data i2c address. If
> > > it's a valid one, that means we are expecting a 8807 to be present on the
> > > board and thus we can instantiate this i2c device by calling i2c_new_device().
> > > That will give you a link to your 8807 i2c client from your 8806. The
> > > advantage of that solution is to keep the 880x driver board and design
> > > neutral while avoiding any static definitions.
> > > Waiting for your feedback.
> > >
> > Hi Samuel,
> > 
> > Excuse me to response late. If I implement i2c_new_device(), I should
> > have to create adapter, algorithm and so on. It means that I have to
> > implement i2c-pxa.c duplicately in mfd driver. Is it right?
> I dont think so, no. i2c_new_device should be called at i2c probe time. Your
> 8806 is probed, and you then check the corresponding platform data. If there
> is a valid additional 8807 i2c address, it means that your platform comes with
> a 8807. You then need to call i2c_new_device(), on the same adapter as your
> 8806 is sitting in, i.e. i2c_client->adapter. You would build the 8807
> board_info structure from your platform data i2c address.
> Jean does that make sense from an i2c point of view ? Please let me know if
> you need more background on this issue.

Some more background would be welcome, yes. In particular on how the
8806 and 8807 relate to each other, and what kind of chips they are.
And what problem you are trying to solve in the first place ;)

In any case, you never get to duplicate the i2c-pxa driver code
anywhere. If you have several I2C bus segments controlled by PXA-like
hardware, then you instantiate that many i2c_adapters, all driven by
the same driver (i2c-pxa.)

Calling i2c_new_device() from an i2c client's probe() routine is rather
unusual. I can't really think of a good reason to do this. If the first
client was declared as part of platform init data, I'd expect the
second to be declared there as well.

There's one which is somewhat similar though: chips which reply to more
than one I2C address. The extra addresses are reserved using
i2c_new_dummy(). This gives you an i2c_client handle for easy register
access. This might be suitable for the problem at hand, but I can't
tell for sure without knowing the details.

> > And you want to us i2c_new_device(). Does it mean that there's only
> > 8607 device and address in platform driver and mfd driver
> > distinguishing 8606 from platform data?
> That's correct, yes. As I said, the only place where you can correctly
> describe the relationship between your 8806 and 8807 is your platform data.

-- 
Jean Delvare

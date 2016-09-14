From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Sep 2016 15:07:22 -0500
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160914180754.GA16053@kroah.com>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
Message-ID: <CAL_JsqJtDs-DrPDN4=9ET=EdEDTKxP-gRDkMziimQAz4LG457A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 1:07 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Sep 14, 2016 at 06:36:26PM +0100, Mark Rutland wrote:
>> Hi Greg,
>>
>> On Wed, Sep 14, 2016 at 12:09:49PM +0200, Greg KH wrote:
>> > Given that it's never a good idea to keep subsystems out of the mainline
>> > kernel, I've put together this pull request that adds the greybus driver
>> > layer to drivers/greybus/.  Because this was 2 1/2 years of work, with
>> > many many developers contributing, I didn't want to flatten all of their
>> > effort into a few small patches, as that wouldn't be very fair.  So I've
>> > built a git tree with all of the changes going back to the first commit,
>> > and merged it into the kernel tree, just like btrfs was merged into the
>> > kernel.
>>
>> > Unless people point out some major problems with this, I'd like to get
>> > it merged into 4.9-rc1.
>>
>> I'm extremely concerned that these patches have *never* seen upstream
>> review, and this pull request gives no real opportunity for people to
>> make a judgement regarding the code, as many relevant parties have not
>> been Cc'd.
>
> As I said, I will send a set of simple patches, I wanted to get this out
> as soon as possible and other things came up today.  Will do it in the
> morning, sorry.
>
>> From a quick scan of the git tree, I can see code (that isn't even
>> placed under staging/) for which I have fundamental objections to as a
>> maintainer, and has not been Cc'd to a relevant list.
>>
>> For example, I see commit 5a450477311fbfe2 ("greybus: timesync: Add
>> timesync core driver"). This states that it directly accesses the ARMv7
>> architected timer, though it's unclear as to precisely what it's doing
>> since it introduces an (undocumented) compatible string, and what should
>> be an unnecessary devicetree property.
>>
>> That's never gone to the linux-arm-kernel mainline list, myself or Marc
>> (as maintainers of the arch timer driver), nor has the binding seen any
>> review on the devicetree mailing list.
>
> Hm, odd, I thought we had Rob review all of the device tree bindings,
> but maybe the timesync stuff missed him.  And timesync is "odd" to say
> the least, wait until you see the firmware side of it :)

I have not. There weren't any when I was involved (other than SOC
related bindings). Some like USB devices were discussed at least, but
at the time there was no common definition of how to deal with
soldered, on-board USB devices. And that was also what's good enough
to move forward with development, not ready for mainline. There's a
binding now for USB, but what's there for arche predates it IIRC. This
is the first I've heard of timesync having a binding. I can't imagine
why it needs one.

I was going to stay out of this, but now that I'm here...

I'm not all that worried about the quality of the code, but do
question whether this really makes sense to merge at this time. While
I worked on Ara and would like to see all this code be used, I'm
pretty doubtful it will be. Yes, Motorola is using a version of it,
but they forked it some time back and changed who knows what. So what
is upstream won't likely even work with any publicly available device.
And how long that Motorola phone lasts is unknown. Sure it is self
contained, but maintenance to keep it in tree is not 0.

There's also things that never got solved. Like how do you describe
devices on I2C, SPI, UART, etc. behind a greybus device? The plan was
to use DT overlays, but that was never solved and brings a whole set
of problems to solve upstream.

Rob

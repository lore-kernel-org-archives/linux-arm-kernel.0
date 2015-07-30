From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 30 Jul 2015 10:24:37 +0200
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <20150729184043.GL11162@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk>
 <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
 <20150729184043.GL11162@sirena.org.uk>
Message-ID: <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 20:40, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 29, 2015 at 08:21:34PM +0200, Michal Suchanek wrote:
>> On 29 July 2015 at 19:16, Mark Brown <broonie@kernel.org> wrote:
>
>> >> It will not break anything. It will just spam dmesg.
>
>> > I'm confused - if all this change does is to spam dmesg then what's the
>> > point?
>
>> Presumably when your SPI NOR flash fails to probe this message will be
>> just above and you will look into the binding doc and add the
>> compatible.
>
> If you're looking to add a warning message when the flash device fails
> to probe then add that in the flash driver when it detects an error,
> this will cause needless noise for everyone else using this controller
> purely to work around the broken binding.

Technically nobody needs to see the warning with in-tree boards since
the dts can be amended with the compatible.

There is no error in flash device driver.

There is only error parsing partition scheme. In my opinion this
should never cause an error. With disk drives failure to parse
partition table results in unpartitioned disk. As there are number of
partitioning schemes failure to parse one still does not prevent other
in succeding.

>
> And like I say compatible really seems like it isn't an appropriate
> property here.

So to sum up the discussion adding compatible to s3c64xx
controller-data is not desirable and making ofpart more robust is
desirable.

I think the suggestion to use a subnode for ofpart gives the most
robust solution.

Even adding compatibles to the partition subnodes ofpart still
monopolizes the address and cells property of the mtd node which does
not pass the 'if another driver did the same would it work together?'
test.

So my suggestion is to

1) search of ofpart subnode in mtd node. If present read address and
reg from it and search partitions as subnodes of the ofpart node. In
this case unknown nodes can cause error.

2) failing that issue a warning and try to parse ofpart partitions
from the mtd node itself. In this case unknown nodes cannot cause
error for compatibility with other drivers including the already
exisitn s3c64xx controller-data node.

The parser code can be the same for both cases and only operate on
different node with a flag to reject unknown subnodes or not.

Thanks

Michal

From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 10:02:11 -0700
Subject: [PATCH v3 0/8] ARM: sunxi: Add Reduced Serial Bus support
In-Reply-To: <CAGb2v66X-CMQiS1dNqhwamTsVbnf+7siSTV3xGwn-C91Zhw3uA@mail.gmail.com>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
 <20150819163232.GS10748@sirena.org.uk>
 <CAGb2v66X-CMQiS1dNqhwamTsVbnf+7siSTV3xGwn-C91Zhw3uA@mail.gmail.com>
Message-ID: <20150820170211.GB12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 09:59:27AM +0800, Chen-Yu Tsai wrote:
> On Thu, Aug 20, 2015 at 12:32 AM, Mark Brown <broonie@kernel.org> wrote:

> > This is flagged as something that is specific to the Allwinner SoCs.
> > Why add generic regmap support rather than just implement the regmap
> > reg_read() and reg_write() in a regmap in the controller driver?  Are
> > there expected to be other controller drivers from other vendors?

> I don't expect there to be any other controller drivers. And it seems
> at least some of the devices are dual interface (I2C/RSB). Though I
> don't see how its connected to the generic regmap support. Regmap
> is for device drivers connected to the RSB bus, not the bus controller
> itself.

The point here is that you can use regmap for a custom controller
without having to implement a bus, to repeat what I said:

| > Why add generic regmap support rather than just implement the regmap
| > reg_read() and reg_write() in a regmap in the controller driver?  Are

> I could throw all the RSB-related stuff together, presumably under
> drivers/soc/sunxi/rsb, though that doesn't help the fact that common
> regmap code would be  better than scattering regmap_* in various mfd
> drivers.

If there is only one controller driver you just have a single call into
that driver in the client device which gives you the same level of
shared code, having a wrapper layer in regmap that puts regmap_
functions around the equivalent controller specific functions isn't
really adding a huge amount.

It's a similar thing to the way we just reuse the platform bus for basic
buses rather than copying it to make new bus types, we don't need to
create lots of new boilerplate regmap types that are just really basic
wrappers.  There are a lot of these custom buses that people have.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/7be80764/attachment.sig>

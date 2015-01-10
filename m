From: broonie@kernel.org (Mark Brown)
Date: Sat, 10 Jan 2015 11:17:48 +0000
Subject: [PATCH v2 2/4] Documentation: bindings: Add the regulator
 property to the sub-nodes AHCI bindings
In-Reply-To: <54B0FCDD.7000300@redhat.com>
References: <1420799989-10645-1-git-send-email-gregory.clement@free-electrons.com>
 <1420799989-10645-3-git-send-email-gregory.clement@free-electrons.com>
 <54AFF7E3.4070506@redhat.com> <54AFFFDC.7020307@free-electrons.com>
 <CAGb2v674q4Cjp9qy9CbUXe2j5pT_ez98CKxXHC8u4Diap2TT1A@mail.gmail.com>
 <20150109171131.GH2634@sirena.org.uk> <54B0FCDD.7000300@redhat.com>
Message-ID: <20150110111748.GB4160@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 11:20:13AM +0100, Hans de Goede wrote:
> On 09-01-15 18:11, Mark Brown wrote:

> >Or if the supply is for the device at the other end of the link (which
> >is what it sounded like) then use that.  This just sounds like the same
> >problem we have for all the enumerable buses in embedded systems where
> >we need to be able to understand that the device exists prior to it
> >being fully ready to appear in the system.  Having the link/slot be a
> >device in Linux does indeed seem to be a common way people think about
> >doing this, it sounds like for this one it might be the most direct.

> I think we should be careful to not think too much from an implementation
> pov here, the purpose of the devicetree description is to describe the hardware,
> as is.

I don't think anyone is talking about changing the DT here, only the way
it's represented inside Linux.

>                 sata0: sata-port at 0 {
>                         reg = <0>;
>                         phys = <&sata_phy 0>;
> 			target-supply = <&reg_sata0>;
>                 };
> 
>                 sata1: sata-port at 1 {
>                         reg = <1>;
>                         phys = <&sata_phy 1>;
> 			target-supply = <&reg_sata1>;
>                 };
>         };

> Seems to match the hardware pretty exactly, and also matches how we've
> been describing similar devices with only one sata port + power plug sofar,
> so from a consistency pov it also is a good model.

Right, I think that makes sense - it also looks to me like these things
should be representable as devices within Linux.

> So supporting this model requires having a regulator_get API which allows
> specifying which of_node to get the regulator from, e.g. the proposed

It requires nothing of the sort.

> of_regulator_get function. I know you (Mark) do not like this, but all
> other subsystems have an of_foo_get function taking an of_node as argument,
> I do not see how the regulator subsys is so special that it cannot have one,
> and also notice that this is only a kernel internal API which we can always
> change later.

Two things there.  One is that mostly those APIs are legacy APIs from
before we made DT a first class citizen and generally they shouldn't be
used these days.  The other is that at least for regulators we have
constant problems with people abusing the API in various ways, as a
result the API has a goal of not helping undesirable usage patterns in
order to help people spot problems.  Having an API which makes it easy
create broken bindings means that it is much more likely that people
will do just that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150110/70c1fc6a/attachment.sig>

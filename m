From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 16:58:58 +0200
Subject: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio:
 add support for H3 thermal sensor
In-Reply-To: <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
 <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
 <20180903102022.fkxfkxadkt4vpbmb@flea>
 <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
Message-ID: <20180905145858.4ny5c7xojn7aiwlv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 07:01:47PM +0800, Icenowy Zheng wrote:
> ? 2018?9?3? GMT+08:00 ??6:20:22, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >On Fri, Aug 31, 2018 at 05:51:41PM +0800, Icenowy Zheng wrote:
> >> Personally I suggest to leave out all SID or calibration related
> >> patches here.
> >> 
> >> Currently we seems to be wrongly converting SID to big endian,
> >however,
> >> the orgnization of the THS calibration data on H6 shows that it's
> >> surely little endian:
> >> 
> >> It consists a temperature value in 1/10 celsuis as unit, and some
> >> thermal register readout values, which are the values read out at the
> >> given temperature, and every value here (the temperature and the
> >> readout) are all half word length.
> >> 
> >> Let the temperature value be AABB, the two readout values be XXYY and
> >> ZZWW, the oragnization is:
> >> BB AA YY XX WW ZZ ** ** .
> >> 
> >> When converting the SID to big endian, it becomes:
> >> XX YY AA BB ** ** ZZ WW ,
> >> which is non-sense, and not able to do sub-word cell addressing.
> >> 
> >> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
> >> whether it will break compatibility.)
> >
> >This is exposed to the userspace, so no.
> 
> Please note the LE2BE totally breaks the SID addressing.

On which SoCs?

> Without it dropped all cells must be referenced with 4 byte word as
> unit, and half word addressing of SID is thus not possible. The
> driver will also need then to split the half words if needed.
> 
> I think this is kind of hardware misbehavior, and not a simple
> UAPI change, so the UAPI stability shouldn't affect this change.

How would you feel having your files on your filesystem suddenly not
in the same endianness and having all the bytes reordered? This is
definitely about the userspace ABI.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/fb9aade5/attachment.sig>

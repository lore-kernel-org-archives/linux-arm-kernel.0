From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Jun 2012 13:39:03 +0100
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
 <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
 <20120531113659.GB2666@opensource.wolfsonmicro.com>
 <CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
Message-ID: <20120601123902.GL24139@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 10:47:44AM +0800, Thomas Abraham wrote:

> 1. There is one instance of 'struct platform_device' for each of the
> spi controller instances (0/1/2) named "s3c64xx-spi" (in
> arch/arm/plat-samsung/devs.c).

Right, which looks rather like it is specific to s3c64xx at least given
the naming...  there aren't any current in tree users, though I do have
one out of tree user on s3c6410.  If this is supposed to be used on the
later SoCs too then I guess it ought to be renamed anyway since what's
there looks wrong.

> 5. If point 4 is not correct, the other option is to create a separate
> instances of 'struct platform_device' for each of the s3c, s5p and
> Exynos4/5 SoC's. Is this the correct way, and if yes, could you please
> help me understand the issues in setting the name of the platform
> device at runtime.

That would seem less painful to me.  The big problem I've found is with
things like matching clocks up where if you look at the device that's
being registered it has one name but at runtime it has another name, it
makes everything much harder to follow.  There was one of the devices
where the .id also ended up getting changed which created even more
confusion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120601/f821ab6d/attachment-0001.sig>

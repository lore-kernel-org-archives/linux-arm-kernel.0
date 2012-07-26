From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 07:07:44 +0000
Subject: Orion Pull request
In-Reply-To: <20120725211740.GD13619@lunn.ch>
References: <20120724081732.GR18778@lunn.ch>
 <201207251420.48634.arnd@arndb.de> <20120725211740.GD13619@lunn.ch>
Message-ID: <201207260707.45157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Andrew Lunn wrote:
> > Please split the other patches into branches according to what
> > they do, and make sure that each branch is based on an -rc release
> > rather than a random point in the git history or patches that
> > are not upstream. We can then decide which ones to still send
> > for v3.6 and which branches to delay for v3.7.
> 
> Hi Arnd
> 
> If i make the branches based on the -rc7 release, how do i test them?
> The patches have dependencies on the I2C patch now accepted by the I2C
> maintainer and the SPI patches accepted by the SPI maintainer.  These
> patches implement the DT support in the drivers. Without those
> patches, all i2c devices are missing, and worst still, the root FS is
> missing on my Kirkwood QNAP device i test with.

You can merge the i2c and spi branches that went upstream into your
own branch before applying your own patches. This way, they become
"dependencies" and should get merged before yours are sent (in this
case they already are)

> Note there is no compile time dependencies, just run time. So i could
> initially build a patchset with those driver patches included, test
> the combination works, rebase to discard the driver patches, and then
> send a pull-request?
> 
> Or is there a better way to handle this?

Yes, don't rebase the stuff after testing. We want the patches that
go upstream to be the exact version you have tested.

> I'm also not sure what topic branches would be appropriate. All that
> is left is DT. One branch could be driver changes and the other
> actually using the driver from DT. But there is a clear dependency
> between the two. I cannot split the three new boards support via DT
> into three topic branches because they cause merge conflicts when you
> try to bring them together. What would you suggest?

If there are just conflicts between merging the branches (two
patches touching the same code lines), the best way to deal with it
is to let us handle the merge. We're quite experienced with this by
now.

If you have an actual dependency (branch B builds fine without branch
A, but the result doesn't work), then the branches need to be
serialized: You provide one standalone branch that has the more
basic changes (cleanups, dt conversion, ...) and then you have another
branch that starts from the top commit of the first one and has the
more advanced changes.

If you have two branches that both need a few patches but then go
on in different directions, that's also fine: just apply the common
patches first, then make two branches starting with that common
changeset and apply the other patches separately.

	Arnd

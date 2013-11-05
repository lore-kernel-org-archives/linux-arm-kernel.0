From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 5 Nov 2013 13:36:59 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <201311052117.33443.arnd@arndb.de>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <201311052034.01114.arnd@arndb.de>
 <20131105195820.GB20600@obsidianresearch.com>
 <201311052117.33443.arnd@arndb.de>
Message-ID: <20131105203659.GA26576@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:17:32PM +0100, Arnd Bergmann wrote:
> Creating a platform_device (or a plain device, for that matter)
> from a proper probe() function would have a similar effect from
> the perspective of the TPM subsystem (or other subsystems using

I'd rather see the core get fixed than more muck in the drivers,
especially since things are going in that direction :)

> Yes. Note that the use of new 'class'es is not recommended any more,
> nowadays we are supposed to use 'bus_type' for this, which is
> traditionally something slightly different, but technically almost
> the same implementation-wise.

Thanks, I will look into that!
 
> That depends: the requirement is that no user space breaks after
> a change. I assume that there is a fairly limited set of packages
> accessing the tpm sysfs files. If all of them are written properly,
> they should be able to deal with looking at the files in a different
> place in sysfs.

The other issue is that none of the sysfs files are even close to
following the one value per file rule, they are all wrong. I actually
think that nothing in userspace ever uses them and they were only ever
done for debugfs-like purposes.

My dark hope is to move them all to debugfs and entirely out of
sysfs.. But I think it will be through a CONFIG_TPM_SYSFS_COMPAT=y +
printk_once("Stop using these sysfs attributes!") kind of scheme.
 
> Another option is to change the TPM core sysfs attributes not to
> look at drvdata, but to use devres_find() to find the data they
> need.

Ooh, that looks like it could work well, I will keep that in mind!

So there is a path forward, it is just long :)

BTW, in the final form TPM will require a 2 stage init much like net,
the sequence will be:
 - Allocate the core and driver memory and resources
 - Setup the driver fully
 - Perform TPM commands on the fully active driver to setup the
   TPM itself
 - Register the TPM with the system

Just remarking,I don't see a problem with this and your devm_probe
plan.

Thanks
Jason

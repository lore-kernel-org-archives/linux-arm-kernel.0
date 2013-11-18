From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Nov 2013 14:19:55 -0500
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <528A65DF.8060000@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384798508.git.jason@lakedaemon.net>
 <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
Message-ID: <20131118191955.GG10335@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 12:09:19PM -0700, Stephen Warren wrote:
> On 11/18/2013 11:38 AM, Jason Cooper wrote:
> > Unlike other build products in the Linux kernel, the devicetree blobs
> > are simply the name of their source file, s/dts/dtb/.  There is also no
> > 'make *install' mechanism to put them in a standard place with a
> > standard naming structure.
> > 
> > Unfortunately, users have begun scripting pulling the needed dtbs from
> > within the kernel tree, thus hardcoding the dtbs names.  In turn, this
> > means any changes to the dts filenames breaks these scripts.
> > 
> > This patch is an attempt to fix this problem.  Akin to 'make install',
> > this creates a new make target, dtbs_install.  The script that gets
> > called defers to a vendor or distribution supplied installdtbs binary,
> > if found in the system.  Otherwise, the default action is to install a
> > given dtb into
> > 
> >   /lib/modules/${kernel_version}/devicetree/${board_compat}.dtb
> 
> Is co-mingling the DTs in the same (top-level) directory as modules a
> good idea. I guess there is an explicit devicetree/ sub-directory so
> they're easy to pull out of the source tree, but even so, they're
> certainly not modules. I would assume that distros would put them into
> e.g. /boot/dtbs/${kernelversion} or something more like that. Would it
> make sense for the install target to use a path more like that, or
> perhaps at least /dtbs/${kernelversion} to keep it separate from modules?

I thought about the proposed /boot/dtbs/${kernelversion} and it didn't
sit well with me.  /boot is for the files needed to boot the machine,
not all the files you *might* need to boot the machine.  I'm speaking
generally, I understand your situation is different.

I tried to follow the analogy of the kernel modules, All of them are
installed in /lib/modules/$kernelversion}, then, the initramfs builder
selects a few modules needed to find the rootfs, etc and packs just
those into the initramfs.

> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> 
> > +dtbs_install: dtbs

This answers below ^^^^

> > +	$(CONFIG_SHELL) $(srctree)/$(boot)/installdtbs.sh $(KERNELRELEASE) \
> > +	"$(MODLIB)/devicetree" "$(srctree)/$(boot)/dts"
> 
> Architectures besides ARM use device trees. Shouldn't "make
> dtbs_install" work for them too?

Yes, once the idea is hammered out, I'll add powerpc/mips/etc.

> > diff --git a/arch/arm/boot/installdtbs.sh b/arch/arm/boot/installdtbs.sh
> 
> > +for dtb in `find "$3" -name "*.dtb"`; do
> > +	# we use dtc to parse the dtb, get the board compatible string,
> > +	# and then copy the dtb to $2/${board_compatible}.dtb
> > +	compat="`$DTC -I dtb -O compat "$dtb"`"
> > +
> > +	if [ -e "$2/${compat}.dtb" ]; then
> > +		echo "Install $dtb: $2/${compat}.dtb already exists!" 1>&2
> > +		exit 1
> > +	else
> > +		cp "$dtb" "$2/${compat}.dtb"
> > +	fi
> > +done
> 
> This only appears to create ${compat}.dtb, and not ${dtb} too. 

See my comment, above.

> So, it doesn't seem to address part of the cover letter, "In addition,
> some vendors have done a diligent job naming their devicetree source
> files appropriately and we don't want to break their setups." Was that
> deliberate? If so, I guess I need to send some patches to U-Boot.

I assume you are still pulling from arch/arm/boot/dts/*.dtb, right?
Those build products don't go away with this patch, so you should be
fine.  Unless I'm mis-understanding your workflow...

thx,

Jason.

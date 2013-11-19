From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Nov 2013 19:22:46 +0000
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119152146.GN16735@n2100.arm.linux.org.uk>
References: <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
 <20131119150212.GM16735@n2100.arm.linux.org.uk>
 <20131119152047.GB28859@titan.lakedaemon.net>
 <20131119152146.GN16735@n2100.arm.linux.org.uk>
Message-ID: <20131119192246.GP16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 03:21:46PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 19, 2013 at 10:20:47AM -0500, Jason Cooper wrote:
> > By "That" are you referring to extending the standard for compatible
> > strings to the board level, or forcing consistent naming on the dts
> > files?
> 
> A consistent file naming on both the dtb and dts files.

It's time to knock the idea of naming the DT blobs after the compatible
string on its head as well.  That's really not going to work.  Just
leave the filenames as is, and move the problem into userspace to solve.

Why?

arch/arm/boot/dts/imx28-cfa10036.dts-   compatible = "crystalfontz,cfa10036", "fsl,imx28";
arch/arm/boot/dts/imx28-cfa10037.dts-   compatible = "crystalfontz,cfa10037", "crystalfontz,cfa10036", "fsl,imx28";
arch/arm/boot/dts/imx28-cfa10049.dts-   compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
arch/arm/boot/dts/imx28-cfa10055.dts-   compatible = "crystalfontz,cfa10055", "crystalfontz,cfa10037", "crystalfontz,cfa10036", "fsl,imx28";
arch/arm/boot/dts/imx28-cfa10057.dts-   compatible = "crystalfontz,cfa10057", "crystalfontz,cfa10036", "fsl,imx28";

We already have DT blobs where the compatible string(s) for a DT blob
conflict with other DT blobs.

Using the compatible string as a filename means that you have to choose
one of the above to name the DT blob, whereas the above compatible
strings allow any of those to be used with "crystalfontz,cfa10036".

So, given a platform with "crystalfontz,cfa10036" you may wish to
offer to the user to select one of those five.  How do you do that
if you've named the files after the compatible string (maybe the
first compatible string.)

See - by doing this, you are building policy into the kernel build
system and potentially taking away choice from userspace.

Just use the filenames we already have in the kernel tree.  Let userspace
parse the DT blobs for the compatible strings - it can then provide the
user with the choice of all and _also_ show that certain of DT blobs
may be compatible with a range of boards as well.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Mar 2013 17:57:46 +0000
Subject: [RFC] Kbuild support for ARM FIT images
In-Reply-To: <20130318174931.GB4230@amd.pavel.ucw.cz>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
 <20130318163648.GA3722@amd.pavel.ucw.cz>
 <20130318164426.GI30923@n2100.arm.linux.org.uk>
 <20130318174931.GB4230@amd.pavel.ucw.cz>
Message-ID: <20130318175746.GJ30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 06:49:32PM +0100, Pavel Machek wrote:
> What I wanted to say is that kernel build traditionaly produced
> something useful, something bootloader can actually boot. Currently,
> make uImage produces u-boot image. Please keep that capability.

Unfortunately, there is a fundamental problem with uImage.  It encodes
the load address, and that is utterly incompatible with the goal of
having a kernel image which boots on multiple platforms.

uImage isn't going anywhere for the time being, but you will find
that:

a) recent kernels will just wrap the zImage without a DTB, so
   appended DTBs can't be used with it
b) it won't work with MULTIPLATFORM-enabled kernels, unless you
   provide make with a LOADADDR= argument to tell it where the
   uImage is to be loaded - which is platform specific.

(b) fundamentally can't be solved in kbuild.  If you want to use
uImage with multiple platforms from the same zImage, then you need
to generate multiple uImage files with different load addresses.
That's purely - and solely - down to the dysfunctional uImage format.

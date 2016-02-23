From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 16:01:06 +0100
Subject: [PATCH] [RFC] ARM: keystone: possibly fix big-endian kernels
In-Reply-To: <20160223145318.GK19428@n2100.arm.linux.org.uk>
References: <1456238609-962461-1-git-send-email-arnd@arndb.de>
 <20160223145318.GK19428@n2100.arm.linux.org.uk>
Message-ID: <3249746.5p1eRtyJ9a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 14:53:18 Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 03:43:21PM +0100, Arnd Bergmann wrote:
> > While discussing a regressing in the netcp driver, I wondered
> > whether Keystone can work with a big-endian kernel, and noticed
> > that we don't switch endianess when we enter the kernel on the
> > secondary CPU, or when we call into smc.
> 
> NAK.  Sorry Arnd, you're worringly wrong on this.
> 
> secondary_startup will do the setend if necessary, there's no need
> to do this kind of junk in each and every platform.  It's been this
> way since:
> 
> commit 97bcb0fea590d3d704f985bec08f342d28992634
> Author: Ben Dooks <ben.dooks@codethink.co.uk>
> Date:   Fri Feb 1 09:40:42 2013 +0000
> 
> So, I hope you've not been telling platform folk to do this.  Please
> audit the arm-soc code to make sure, thanks.
> 

I see my mistake now: I looked at the secondary_startup() function
by looking up the location in ctags, and that pointed me to
arch/arm/kernel/head-nommu.S.

I was surprised when I didn't see the setend() in there, but
didn't realize that I was looking in the wrong place, but it
made some sense when I found the setend in a couple of other
platforms that all need a wrapper anyway.

Sorry about the noise.

	Arnd

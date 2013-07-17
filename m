From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 16:11:48 +0100
Subject: [PATCH] arm: choose debug/uncompress.h include when uncompress
 debug is disabled
In-Reply-To: <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
References: <1373897706-15331-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307171420350.8258@kaball.uk.xensource.com>
Message-ID: <20130717151148.GM24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 02:25:38PM +0100, Stefano Stabellini wrote:
> On Mon, 15 Jul 2013, Julien Grall wrote:
> > Even if uncompress debug is disabled, some board will continue to print
> > information during uncompress step.
> 
> Are you talking about DEBUG_UNCOMPRESS?
> Should I read the sentence as "even if DEBUG_UNCOMPRESS is not selected,
> some board will continue to print information during the uncompress step"?
> 
> Isn't this a bug in the platform specific code that should be fixed anyway?

Hang on, let's be clear what's going on here.

1. The normal output from the decompressor is *not* debugging.  By that
   I mean the "Uncompressing kernel... done" message.  That is part of
   user output.

2. In non-multiplatform environments, the decompressor will normally use
   the putc/flush functions found in arch/arm/mach-*/include/mach/uncompress.h
   to implement its output, irrespective of the DEBUG_UNCOMPRESS setting.
   (An interesting point is that DEBUG_UNCOMPRESS really should depend on
   MULTIPLATFORM so that this point is explicit - the option requires
   MULTIPLATFORM to be set.)

3. DEBUG_UNCOMPRESS allows the functions which we've implemented for LL
   debug to be re-used for decompressor output.

4. When DEBUG_UNCOMPRESS is not set in a multiplatform kernel, the
   decompressors putc() and flush() functions are stubbed out.

So, it's quite right that you get output from the decompressor even when
DEBUG_UNCOMPRESS is not set.  There's no problem with that.

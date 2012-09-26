From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 26 Sep 2012 09:34:46 -0600
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <20120926151023.GC30938@n2100.arm.linux.org.uk>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <201209261417.18883.arnd@arndb.de> <506315A6.3090300@am.sony.com>
 <201209261449.48468.arnd@arndb.de>
 <20120926151023.GC30938@n2100.arm.linux.org.uk>
Message-ID: <50632096.7080208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 09:10 AM, Russell King - ARM Linux wrote:
> On Wed, Sep 26, 2012 at 02:49:48PM +0000, Arnd Bergmann wrote:
>> Right now, a multiplatform kernel has no way of debugging the
>> decompressor using console output, so it's actually /smaller/
>> than a single-platform kernel, but also less capable.
> 
> Err, are you sure about all your details above?  You do realise when
> debugging is disabled there is no debug code included anywhere in the
> decompressor?
> 
> I think what you're referring to is not the debug output, but the normal
> decompressor output.  (The "Decompressing Linux..." message is not
> debug output.)
> 
> Let's be a little more clear about what "less capable" means - it will
> be unable to report any errors that occur during the decompression.
> What that means is that you'll end up with mere silence should an
> error occur.

In the Tegra case, by omitting uncompress.h, we lose more than just the
"Decompressing Linux..." message; uncompress.h contains code to parse
extract the platform's debug UART ID from data set up by the boot ROM
(since we have 5 UARTs), and pass this on to debug-macro.S. Without
uncompress.h running, debug-macro.S would either have to hard-code a
single UART ID (and different boards uses different UARTs, which would
make running a single kernel image across all Tegra devices with
earlyprintk enabled impossible) *or* we'd have to port the UART ID
extraction code to debug-macro.S too, which I don't fancy very much
since that's assembly whereas uncompress.h is C.

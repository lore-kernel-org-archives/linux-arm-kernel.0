From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 13:08:22 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
In-Reply-To: <20130328125513.GY18316@opensource.wolfsonmicro.com>
References: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201303281239.46639.arnd@arndb.de>
 <20130328125513.GY18316@opensource.wolfsonmicro.com>
Message-ID: <201303281308.22738.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Mark Brown wrote:
> On Thu, Mar 28, 2013 at 12:39:46PM +0000, Arnd Bergmann wrote:
> 
> > Axel Lin reported the same problem and I fixed the below code earlier
> > today by using the correct __attribute__((unused)) and dropping the
> > section magic for the non-OF case. My patch now looks contains the
> 
> That still looks like it'll reference the function?

Yes, that is intentional. The idea is to create a reference to the
function so gcc doesn't complain about unused symbols if the function
gets marked static, but at the same time mark the data structure we
define as unused so gcc can drop the structure as well as the function
if they are not referenced from anywhere else.  This should let us
get away with fewer #ifdef hacks in the code, better build-time coverage
but without producing larger object code.

> > change below. I also proposed a fix for the clocksource driver
> > at http://lkml.org/lkml/2013/3/26/103.
> 
> This is a different driver that I'm trying to look at here, the s3c24xx
> one which is still not merged.  

Ah, sorry about that. It seems to have the same bug.

	Arnd

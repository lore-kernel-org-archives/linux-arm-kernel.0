From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 May 2017 22:25:02 +0200
Subject: [PATCH] ARM: s3c64xx: don't select ARM_AMBA from S3C64XX_PL080
In-Reply-To: <20170531195849.GD27796@n2100.armlinux.org.uk>
References: <20170524155845.1778223-1-arnd@arndb.de>
 <20170531195849.GD27796@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a3gxrkn1TOLWXzW4-s8H8uJWvC1vC3_fjxm-tXXkooxUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 9:58 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, May 24, 2017 at 05:58:34PM +0200, Arnd Bergmann wrote:
> Yes, selecting ARM_AMBA from drivers is definitely not right; this
> symbol should be selected only by platforms that want AMBA primecell
> bus support, not by drivers, precisely because of these dependency
> issues.
>
> There's another case where ARM_AMBA is selected that probably needs
> fixing - the coresight hwtracing code.

[Adding Mathieu to cc]

Mathieu,

do you remember how we ended up with this?

menuconfig CORESIGHT
       bool "CoreSight Tracing Support"
       select ARM_AMBA

As Russell says, probably shouldn't select that symbol, most likely
we want either the individual drivers that register an amba_driver to have
a 'depends on ARM_AMBA' or alternatively replace the 'select' with 'depends
on' for the entire subsystem.

        Arnd

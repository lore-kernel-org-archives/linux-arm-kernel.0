From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2016 10:59:11 +0200
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
Message-ID: <3283479.PKRDjkX0Md@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 26, 2016 7:12:51 PM CEST Anson Huang wrote:
> i.MX7D has 2 cortex-a7 ARM core, add support for
> booting up SMP kernel with 2 CPUs.
> 
> The existing i.MX SMP code is designed for i.MX6
> series SoCs which have cortex-a9 ARM core, but i.MX7D
> has 2 cortex-a7 ARM core, so we need to add runtime
> check for those differences between cortex-a9 and
> cortex-a7.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 

Can't you just point i.MX7D to start from secondary_startup
rather than v7_secondary_startup?

 ENTRY(v7_secondary_startup)
+       .word   0xc070                  @ 0xc07 is cortex-a7 id
+       .word   0xfff0                  @ mask for core type
+

This looks like you are trying to execute instructions that are
actually data. Does this work?

On a side note, could you rename v7_secondary_startup to
imx6_secondary_startup? The name sounds overly generic
on a multiplatform kernel.

	Arnd

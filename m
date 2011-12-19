From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 13:58:25 +0100
Subject: [PATCH] ARM: restart: move SWRST based S3C platforms to
 machine_desc hook
In-Reply-To: <03de01ccbe4b$a8a5bb00$f9f13100$%kim@samsung.com>
References: <03dc01ccbe45$80633d30$8129b790$%kim@samsung.com>
 <201112191325.56090.heiko@sntech.de>
 <03de01ccbe4b$a8a5bb00$f9f13100$%kim@samsung.com>
Message-ID: <201112191358.26307.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 19. Dezember 2011, 13:42:24 schrieb Kukjin Kim:
> Heiko St?bner wrote:
> > S3C2412/S3C2416/S3C2443 use a special register to signal the reset to
> > the processor and used therefore the s3c24xx_reset_hook mechanism in the
> > s3c24xx-specific arch reset.
> > 
> > This patch introduces restart functions for these architectures,
> > moves the board files to them and removes the s3c24xx_reset_hook
> > infrastructure, as all users are gone.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > @Kgene: This is my first cleanup step, done before your s3c64xx mail
> > arrived,
> > which transforms the 2412,2416 and 2443 arches which use the special
> > SWRST register to do the reset. Just if it helps :-)
> 
> Heiko, thanks.
> 
> I'm looking at S5P SoCs now and of course this helps. And if possible, let
> me do it with this.
>
> As a note, we need to implement local header file before using new restart
> hook and I'm thinking which one is better to us between all s3c24xx SoCs'
> common or each mach-s3c24xx's one.
For the three arches in the patch I put the function declaration into
s3c2412.h/s3c2416.h/s3c2443.h . They all use a SWRST register, but its
position and the value needed to be written to it differs for each SoC, so
they need to be separate like in the patch.
So these three arches do not seem to need a new header and seem to be ok
with this patch.


The other two S3C24xx-arches (s3c2410 and s3c2440) all use arch_wdt_reset
to do the reset, so I thought about declaring a 

void s3c24xx_default_restart(char mode, const char *cmd)
{
	if (mode == 's') {
		soft_restart(0);
	}

	arch_wdt_reset();

	/* we'll take a jump through zero as a poor second */
	soft_restart(0);
}

for these.

I thought about putting it into plat-s3c24xx/cpu.c and its extern
declaration into plat-samsung/include/plat/cpu.h, but I'm not really sure
if this would be the correct location.


Heiko

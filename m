From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 27 Dec 2016 07:07:40 +0200
Subject: [PATCH v2] watchdog: constify watchdog_info structures
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20161227050740.fqpmxxqxtalkovka@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhumika Goyal,

On Mon, Dec 26, 2016 at 10:35:11PM +0530, Bhumika Goyal wrote:
> Declare watchdog_info structures as const as they are only stored in the
> info field of watchdog_device structures. This field is of type const
> struct watchdog_info *, so watchdog_info structures having this property
> can be declared const too.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_info i at p={...};
> 
> @ok@
> identifier r1.i;
> position p;
> struct watchdog_device obj;
> @@
> obj.info=&i at p;
> 
> @bad@
> position p!={r1.p,ok.p};
> identifier r1.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct watchdog_info i;
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

For digicolor_wdt.c:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

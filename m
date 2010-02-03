From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 3 Feb 2010 09:23:18 -0700
Subject: [PATCHv2 02/11] mxc timer: refactor timer code to use timer
	versions
In-Reply-To: <9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
References: <cover.1265173246.git.amit.kucheria@verdurent.com>
	<cover.1265173480.git.amit.kucheria@canonical.com>
	<0511204199ab83aed2340e70a4639500c0528dab.1265173480.git.amit.kucheria@canonical.com>
	<9fa7a3c70c46a1f776c6520051481cff6525ef02.1265173480.git.amit.kucheria@canonical.com>
Message-ID: <fa686aa41002030823r7ebf0ee5l156ffafb57a8d5d2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2010 at 10:16 PM, Amit Kucheria
<amit.kucheria@canonical.com> wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> Refactor the timer code into version 1 and version 2.
>
> Essentially there are 2 versions of the timer hardware. Version 1 is found on
> MX1/MXL and MX21. Version 2 is found on MX25, MX27, MX31, MX35, MX37, MX51,
> and future parts.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
> ?arch/arm/plat-mxc/time.c | ? 19 +++++++++++--------
> ?1 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> index 844567e..7d6499e 100644
> --- a/arch/arm/plat-mxc/time.c
> +++ b/arch/arm/plat-mxc/time.c
> @@ -57,6 +57,9 @@
> ?#define MX3_TCN ? ? ? ? ? ? ? ? ? ? ? ?0x24
> ?#define MX3_TCMP ? ? ? ? ? ? ? 0x10
>
> +#define timer_is_v1() ?(cpu_is_mx1() || cpu_is_mx27())
> +#define timer_is_v2() ?(cpu_is_mx3() || cpu_is_mx25())

Just from a defensive programming standpoint, it may be better to
define timer_is_v2() as (!timer_is_v1()).  I assume future parts are
more likely to be v2, and doing it that way means one less place in
the code to modify when new parts appear.

Otherwise,
Acked-by: Grant Likely <grant.likely@secretlab.ca>

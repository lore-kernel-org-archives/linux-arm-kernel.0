From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jun 2011 11:01:05 -0700
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <1307034677-27236-2-git-send-email-nsekhar@ti.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
Message-ID: <BANLkTi=oj2Okguie+fje7oDRcPNcWMdAsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 2, 2011 at 10:11 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>
> The DM6467 and DM6467T EVMs use different reference clock
> frequencies. This difference is currently supported by having
> the SoC code call a public board routine which sets up the reference
> clock frequency. This does not scale as more boards are added.
>
> Instead, pass the reference clock frequency as a parameter
> to dm646x_init(). Boards which do not need the default reference
> clock changed can pass NULL to this function.
>
> Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> I have marked Bob as the author of this patch since it is essentially
> his idea. Hope he doesnt mind that :)
>
> ?arch/arm/mach-davinci/board-dm646x-evm.c ? ?| ? 23 +++++++++++------------
> ?arch/arm/mach-davinci/dm646x.c ? ? ? ? ? ? ?| ? ?6 ++++--
> ?arch/arm/mach-davinci/include/mach/common.h | ? 10 ++++++++++
> ?arch/arm/mach-davinci/include/mach/dm646x.h | ? ?4 ++--
> ?4 files changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index f6ac9ba..37c49a9 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -719,9 +719,19 @@ static void __init cdce_clk_init(void)
> ? ? ? ?}
> ?}
>
> +#define DM646X_EVM_REF_FREQ ? ? ? ? ? ?27000000
> +#define DM6467T_EVM_REF_FREQ ? ? ? ? ? 33000000
> +
> +static struct davinci_board_info dm646x_evm;
> +
> ?static void __init davinci_map_io(void)
> ?{
> - ? ? ? dm646x_init();
> + ? ? ? if (machine_is_davinci_dm6467tevm())
> + ? ? ? ? ? ? ? dm646x_evm.ref_clk_rate = DM6467T_EVM_REF_FREQ;
> + ? ? ? else
> + ? ? ? ? ? ? ? dm646x_evm.ref_clk_rate = DM646X_EVM_REF_FREQ;
> +
> + ? ? ? dm646x_init(&dm646x_evm);


Do you foresee needing more members of the davinci_board_info struct
in the near future? If so, this approach is OK. If this is the only
anticipated use today, just passing in the refclk rate as an integer
argument would be just as clean, with less infrastructure.


-Olof

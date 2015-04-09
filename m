From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 9 Apr 2015 09:18:21 +0200
Subject: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
In-Reply-To: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <552627BD.9060109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Brian,

On 04/08/2015 08:59 PM, Brian Norris wrote:
> When working on another SATA driver that uses libahci_platform, I
> noticed an error in this driver; it tries to the the driver data for its
> device, while libata also thinks it can set the driver data. See:
>
>    ahci_platform_init_host()
>    -> ata_host_alloc_pinfo()
>       -> ata_host_alloc()
>          -> dev_set_drvdata()
>
> So instead of sticking the IP-specific platform data into drvdata, let's
> use the plat_data variable that is reserved for this use.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
> This is ONLY compile tested; I don't have hardware to run. This looks like it
> could have ramifications on suspend/resume support, and hot device removal
> (e.g., sysfs unbind), so it might qualify as -stable, if someone can test it
>
>   drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
>
>

Your patch looks sensible, thanks for spotting this issue.

Peter, do you have the SATA setup in place to test Brian's patch?

Once tested, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
